import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
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

      retrievedUsers = (response.data as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint("error: ${e.toString()}");
      return null;
    }

    debugPrint('retrievedUsers ${retrievedUsers.toString()}');
    return retrievedUsers;
  }
}
