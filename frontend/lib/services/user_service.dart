import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/api/token_repository.dart';
import 'package:frontend/models/team/team.dart';
import 'package:frontend/models/user/user.dart';

class UserService {
  static Future<User?> getById(String id) async {
    User? retrievedUser;

    try {
      Response response = await Api().dio.get('/users/$id');
      retrievedUser = User.fromJson(response.data);
    } catch (e) {
      return null;
    }

    return retrievedUser;
  }

  static Future<User?> getCurrentUser() async {
    User? currentUser;
    String? id = await TokenRepository.getCurrentUserId();

    if (id == null) return null;

    try {
      Response response = await Api().dio.get('/users/$id');

      currentUser = User.fromJson(response.data);
    } catch (e) {
      return null;
    }

    return currentUser;
  }

  static Future<String?> getCurrentUserId() async {
    return await TokenRepository.getCurrentUserId().then((value) => value);
  }

  static Future<User?> create(User user) async {
    User? retrievedUser;

    try {
      Response response = await Api().dio.post(
            '/users',
            data: user.toJson(),
          );

      retrievedUser = User.fromJson(response.data);
    } catch (e) {
      return null;
    }

    return retrievedUser;
  }

  static Future<String> acceptTeam(String teamId) async {
    String message;
    try {
      await Api().dio.post(
        '/users/accept-team',
        data: {"teamId": teamId},
      );

      message = "You joined the team!";
    } on DioError catch (err, stack) {
      debugPrint("error: $stack");
      message = err.response?.data;
    }
    return message;
  }

  static Future<String> rejectTeam(String teamId) async {
    String message;
    try {
      await Api().dio.delete(
        '/users/reject-team',
        data: {"teamId": teamId},
      );

      message = "Team invitation rejected";
    } on DioError catch (err, stack) {
      debugPrint("error: $stack");
      message = err.response?.data;
    }
    return message;
  }

  static Future<String> invite(String userId) async {
    String message;
    try {
      await Api().dio.post(
        '/teams/invite-player',
        data: {"userId": userId},
      );

      message = "Invitation sent";
    } on DioError catch (err, stack) {
      debugPrint("error: $stack");
      message = err.response?.data.toString() ?? "";
    }
    return message;
  }

  static Future<Team?> team() async {
    Team? retrievedTeam;
    try {
      Response response = await Api().dio.get(
            '/users/team',
          );

      retrievedTeam = Team.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (_) {
      return null;
    }
    return retrievedTeam;
  }

  static Future<String?> leaveTeam() async {
    String? message;
    try {
      await Api().dio.patch('/users/leave-team');
    } on DioError catch (err, stack) {
      debugPrint("error: $stack");
      debugPrint(err.response?.data);
      if (err.response?.statusCode == HttpStatus.notFound) {
        message = err.response?.data;
      }
    }
    return message;
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
          debugPrint("error in parsing: ${e.toString()}");
        }
      }
    } catch (e) {
      debugPrint("error: ${e.toString()}");
      return null;
    }

    return retrievedUsers;
  }

  static Future<List<User>?> getUserListFromIds(List<String> ids) async {
    List<User>? retrievedUsers = [];

    for (final id in ids) {
      final user = await getById(id);
      if (user != null) {
        retrievedUsers.add(user);
      }
    }

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

    if (response.statusCode == HttpStatus.ok) {
      final tokens = response.data['tokens'];
      await TokenRepository.setAccessToken(tokens['access_token']);
      await TokenRepository.setRefreshToken(tokens['refresh_token']);
      await TokenRepository.setCurrentUserId(response.data['_id']);
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
    await TokenRepository.setCurrentUserId(null);
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
