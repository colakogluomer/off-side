import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/api/token_repository.dart';
import 'package:frontend/models/user/user.dart';

class UserService {
  static Future<User?> create(User user) async {
    User? retrievedUser;

    try {
      Response response = await Api().dio.post(
            '/users',
            data: user.toJson(),
          );

      debugPrint('User created: ${response.data}');

      retrievedUser = User.fromJson(response.data);
    } catch (e) {
      return null;
    }

    return retrievedUser;
  }

  static Future<List<User>?> list() async {
    List<User>? retrievedUsers = [];

    try {
      Response response = await Api().dio.get('/users');

      List<dynamic> rawUserList = response.data;

      for (final rawUser in rawUserList) {
        try {
          retrievedUsers.add(User.fromJson(rawUser as Map<String, dynamic>));
        } catch (e) {
          debugPrint("error: ${e.toString()}");
        }
      }
    } catch (e) {
      debugPrint("error: ${e.toString()}");
      return null;
    }

    debugPrint('retrievedUsers ${retrievedUsers.toString()}');
    return retrievedUsers;
  }

  static Future<String?> register(
      {required String? email,
      required String? password,
      required String? name}) async {
    final response = await Api().loginDio.post('/users', data: {
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

  static Future<String?> login(String email, String password) async {
    final response = await Api().loginDio.post('/users/login', data: {
      'email': email,
      'password': password,
    });
    debugPrint("response.status ${response.statusCode}, data ${response.data}");

    if (response.statusCode == HttpStatus.ok) {
      final tokens = response.data['tokens'];
      await TokenRepository.setAccessToken(tokens['access_token']);
      await TokenRepository.setRefreshToken(tokens['refresh_token']);
      debugPrint(await TokenRepository.getAccessToken());
      return null;
    } else if (response.statusCode == HttpStatus.badRequest) {
      final message = response.data['error'];
      return message.toString();
    }
    return response.data.toString();
  }

  static Future<void> logout() async {
    await TokenRepository.setAccessToken(null);
    await TokenRepository.setRefreshToken(null);
  }

  static Future<String?> resetPassword(String email) async {
    final response = await Api().loginDio.post('/reset-password', data: {
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
