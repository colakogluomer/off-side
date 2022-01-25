import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api/token_repository.dart';
import 'package:frontend/constants/settings.dart' as settings;

class Api {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: settings.serverUrl));
  final loginDio = Dio(BaseOptions(
    baseUrl: settings.serverUrl,
    followRedirects: false,
    validateStatus: (status) {
      return status! < 500;
    },
  ));

  Api._internal();

  static final _instance = Api._internal();

  factory Api() => _instance;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: settings.serverUrl,
      receiveTimeout: 15000, // 15 seconds
      connectTimeout: 15000,
      sendTimeout: 15000,
    ));

    dio.interceptors.add(AppInterceptors());
    return dio;
  }
}

class AppInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Authorization'] =
        'Bearer ${await TokenRepository.getAccessToken()}';
    debugPrint(options.headers.toString());
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == HttpStatus.unauthorized &&
        err.response?.data is Map<String, dynamic>) {
      if (err.response?.data['error'] == "token expired") {
        if (await TokenRepository.storage.containsKey(key: 'refreshToken')) {
          if (await refreshToken()) {
            return handler.resolve(await _retry(err.requestOptions));
          }
        }
      }
    }
    return handler.next(err);
  }

  Future<bool> refreshToken() async {
    final refreshToken =
        await TokenRepository.storage.read(key: 'refreshToken');
    final response = await Api()
        .tokenDio
        .post(settings.refreshEndpoint, data: {'refreshToken': refreshToken});

    if (response.statusCode == HttpStatus.created) {
      TokenRepository.setAccessToken(response.data);
      return true;
    } else {
      // refresh token is wrong
      //TokenRepository.setAccessToken(null);
      //TokenRepository.setRefreshToken(null);
      return false;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return Api().dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
