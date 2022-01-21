import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/models/team/team.dart';

class TeamService {
  static Future<Team?> getById(String id) async {
    Team? retrievedTeam;

    try {
      debugPrint('=============================================$id');
      Response response = await Api().dio.get('/teams/$id');

      debugPrint('Team retrieved: ${response.data}');

      retrievedTeam = Team.fromJson(response.data);
    } catch (e) {
      return null;
    }

    return retrievedTeam;
  }

  static Future<String> create(String name) async {
    String message;
    try {
      debugPrint('start sending request');
      Response response = await Api().dio.post(
        '/teams',
        data: {"name": name},
      );

      message = "Team created";

      debugPrint('Team created: ${response.data}');
    } on DioError catch (err, stack) {
      debugPrint("error: $stack");
      message = err.response?.data;
    }
    return message;
  }

  static Future<String> acceptPlayer(String userId) async {
    String message;
    try {
      debugPrint('start sending request');
      Response response = await Api().dio.post(
        '/teams/accept-player',
        data: {"userId": userId},
      );

      message = "Player accepted";

      debugPrint('acceptPlayer: ${response.data}');
    } on DioError catch (err, stack) {
      debugPrint("error: $stack");
      message = err.response?.data;
    }
    return message;
  }

  static Future<String> rejectPlayer(String userId) async {
    String message;
    try {
      debugPrint('start sending request');
      Response response = await Api().dio.delete(
        '/teams/reject-player',
        data: {"userId": userId},
      );

      message = "Player rejected";

      debugPrint('Player rejected: ${response.data}');
    } on DioError catch (err, stack) {
      debugPrint("error: $stack");
      message = err.response?.data;
    }
    return message;
  }

  static Future<List<Team>?> list() async {
    List<Team>? retrievedTeams = [];

    try {
      Response response = await Api().dio.get('/teams');

      List<dynamic> rawTeamList = response.data;

      for (final rawTeam in rawTeamList) {
        try {
          retrievedTeams.add(Team.fromJson(rawTeam as Map<String, dynamic>));
        } catch (e) {
          debugPrint("error: ${e.toString()}");
        }
      }
    } catch (e) {
      debugPrint("error: ${e.toString()}");
      return null;
    }

    debugPrint('retrievedTeams ${retrievedTeams.toString()}');
    return retrievedTeams;
  }

  static Future<String?> join(String id) async {
    String? message;

    try {
      await Api().dio.post(
        '/teams/join',
        data: {"teamId": id},
      );
    } on DioError catch (err, stack) {
      debugPrint("error: $stack");
      message = err.response?.data;
    }
    return message;
  }
}
