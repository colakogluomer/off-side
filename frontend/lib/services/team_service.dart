import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/models/team/team.dart';

class TeamService {
  static Future<Team?> create(Team team) async {
    Team? retrievedTeam;

    try {
      Response response = await Api().dio.post(
            '/teams',
            data: team.toJson(),
          );

      debugPrint('Team created: ${response.data}');

      retrievedTeam = Team.fromJson(response.data);
    } catch (e) {
      return null;
    }

    return retrievedTeam;
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
