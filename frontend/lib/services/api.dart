import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/constants/settings.dart' as settings;

class Api {
  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  final Dio api = Dio(
    BaseOptions(
      baseUrl: settings.serverUrl,
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
    ),
  );
  String? accessToken;

  final _storage = const FlutterSecureStorage();

  Api._internal() {
    api.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers['Authorization'] = accessToken;
      return handler.next(options);
    }, onError: (DioError error, handler) async {
      if ((error.response?.statusCode == HttpStatus.unauthorized &&
          error.response?.data['error'] == "token expired")) {
        if (await _storage.containsKey(key: 'refreshToken')) {
          if (await refreshToken()) {
            return handler.resolve(await _retry(error.requestOptions));
          }
        }
      }
      return handler.next(error);
    }));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> refreshToken() async {
    final refreshToken = await _storage.read(key: 'refreshToken');
    final response = await api
        .post(settings.refreshEndpoint, data: {'refreshToken': refreshToken});

    if (response.statusCode == HttpStatus.created) {
      accessToken = response.data;
      return true;
    } else {
      // refresh token is wrong
      accessToken = null;
      _storage.deleteAll();
      return false;
    }
  }

  Future<String?> register(
      {required String? email,
      required String? password,
      required String? name}) async {
    final response = await api.post(settings.serverUrl + '/users', data: {
      'name': name,
      'email': email,
      'password': password,
    });
    if (response.statusCode == HttpStatus.created) {
      return null;
    } else if (response.statusCode == HttpStatus.badRequest) {
      final message = response.data['error'];
      return message.toString();
    }
    return response.data.toString();
  }

  Future<String?> login(String email, String password) async {
    final response = await api.post('/users/login', data: {
      'email': email,
      'password': password,
    });
    debugPrint("response.status ${response.statusCode}, data ${response.data}");

    if (response.statusCode == HttpStatus.ok) {
      final tokens = response.data['tokens'];
      accessToken = tokens['access_token'];
      _storage.write(key: "access_token", value: tokens['access_token']);
      _storage.write(key: "refresh_token", value: tokens['refresh_token']);
      return null;
    } else if (response.statusCode == HttpStatus.badRequest) {
      final message = response.data['error'];
      return message.toString();
    }
    return response.data.toString();
  }

  Future<String?> resetPassword(String email) async {
    final response =
        await api.post(settings.serverUrl + '/reset-password', data: {
      'email': email,
    });

    if (response.statusCode == HttpStatus.ok) {
      return null;
    } else if (response.statusCode == HttpStatus.badRequest) {
      final message = response.data['error'];
      return message.toString();
    }
    return response.data.toString();
  }
}
