import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/models/team/team.dart';

class TeamService {
  static Future<Team?> getById(String id) async {
    Team? retrievedTeam;

    try {
      Response response = await Api().dio.get('/teams/$id');

      retrievedTeam = Team.fromJson(response.data);
    } catch (e) {
      return null;
    }

    return retrievedTeam;
  }

  static Future<List<Team>> getTeamsListFromIds(List<String> ids) async {
    List<Team> retrievedUsers = [];

    for (final id in ids) {
      final team = await getById(id);
      if (team != null) {
        retrievedUsers.add(team);
      }
    }

    return retrievedUsers;
  }

  static Future<String> create(String name) async {
    String message;
    try {
      await Api().dio.post(
        '/teams',
        data: {"name": name},
      );

      message = "Team created";
    } on DioError catch (err, stack) {
      debugPrint("error: $stack");
      message = err.response?.data;
    }
    return message;
  }

  static Future<String> acceptPlayer(String userId) async {
    String message;
    try {
      Response response = await Api().dio.post(
        '/teams/accept-player',
        data: {"userId": userId},
      );

      message = "Player accepted";

      debugPrint('accepted Player: ${response.data}');
    } on DioError catch (err, stack) {
      debugPrint("error: $stack");
      debugPrint('response: ${err.response?.data}');
      message = err.response?.data;
    }
    return message;
  }

  static Future<String> rejectPlayer(String userId) async {
    String message;
    try {
      await Api().dio.delete(
        '/teams/reject-player',
        data: {"userId": userId},
      );

      message = "Player rejected";
    } on DioError catch (err, stack) {
      debugPrint("error: $stack");
      debugPrint('Error when rejecting: ${err.response?.data}');
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
        } catch (_) {}
      }
    } catch (_) {
      return null;
    }

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
