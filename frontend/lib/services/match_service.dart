import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/models/match/match.dart';
import 'package:intl/intl.dart';

class MatchService {
  static Future<MatchDto?> getById(String id) async {
    MatchDto? retrievedMatch;

    try {
      Response response = await Api().dio.get('/matches/$id');

      retrievedMatch = MatchDto.fromJson(response.data);
    } catch (e) {
      return null;
    }

    return retrievedMatch;
  }

  static Future<String> sendMatchInvitation(String teamId) async {
    String message;
    try {
      Response response = await Api().dio.post(
        '/matches/send-match-invitation',
        data: {"teamId": teamId},
      );

      message = "Invitation sent";

      debugPrint('invitation sent: ${response.data}');
    } on DioError catch (err, stack) {
      debugPrint("error: $stack");
      message = err.response?.data.toString() ?? "";
    }
    return message;
  }

  static Future<String> acceptMatchInvitation(
      String teamId, DateTime date, String address) async {
    String message;
    try {
      debugPrint('accept match: ${{
        "teamId": teamId,
        "adress": address,
        "date": "${DateFormat('yyyy-MM-ddTkk:mm').format(date)}Z",
      }.toString()}');

      await Api().dio.post(
        '/matches/accept-match-invitation',
        data: {
          "teamId": teamId,
          "adress": address,
          "date": "${DateFormat('yyyy-MM-ddTkk:mm').format(date)}Z",
        },
      );

      message = "Match invitation accepted";
    } on DioError catch (err, stack) {
      debugPrint("response: ${err.response?.data}");
      debugPrint("error: $stack");
      message = err.response?.data;
    }
    return message;
  }

  static Future<List<MatchDto>> getTeamMatches(String teamId) async {
    List<MatchDto>? retrievedMatches = [];

    try {
      Response response = await Api().dio.get(
            '/matches/match/$teamId',
          );

      List<dynamic> rawMatchList = response.data;

      for (final rawMatch in rawMatchList) {
        try {
          retrievedMatches
              .add(MatchDto.fromJson(rawMatch as Map<String, dynamic>));
        } catch (e) {
          debugPrint("error in parsing: ${e.toString()}");
        }
      }
    } catch (_, stack) {
      debugPrint("error: $stack");
    }
    return retrievedMatches;
  }

  static Future<String> rejectMatchInvitation(String teamId) async {
    String message;
    try {
      await Api().dio.delete(
        '/matches/reject-match-invitation',
        data: {"teamId": teamId},
      );

      message = "Match invitation rejected";
    } on DioError catch (err, stack) {
      debugPrint("error: $stack");
      message = err.response?.data;
    }
    return message;
  }

  static Future<MatchDto?> create(MatchDto match) async {
    MatchDto? retrievedMatch;

    try {
      Response response = await Api().dio.post(
            '/matches',
            data: match.toJson(),
          );

      debugPrint('Match created: ${response.data}');

      retrievedMatch = MatchDto.fromJson(response.data);
    } catch (e) {
      return null;
    }

    return retrievedMatch;
  }

  static Future<List<MatchDto>?> list() async {
    List<MatchDto>? retrievedMatches = [];

    try {
      Response response = await Api().dio.get('/matches');

      List<dynamic> rawMatchList = response.data;

      for (final rawMatch in rawMatchList) {
        try {
          retrievedMatches
              .add(MatchDto.fromJson(rawMatch as Map<String, dynamic>));
        } catch (_, stack) {
          debugPrint("error in parsing: $stack");
        }
      }
    } catch (e) {
      return null;
    }

    return retrievedMatches;
  }
}
