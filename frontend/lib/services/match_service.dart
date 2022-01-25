import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/models/match/match.dart';

class MatchService {
  static Future<MatchDto?> getById(String id) async {
    MatchDto? retrievedMatch;

    try {
      debugPrint('=============================================$id');
      Response response = await Api().dio.get('/matches/$id');

      debugPrint('Match retrieved: ${response.data}');

      retrievedMatch = MatchDto.fromJson(response.data);
    } catch (e) {
      return null;
    }

    return retrievedMatch;
  }


  static Future<String> sendMatchInvitation(String teamId) async {
    String message;
    try {
      debugPrint('start sending request');
      Response response = await Api().dio.post(
        '/matches/send-match-invitation',
        data: {"teamId": teamId},
      );

      message = "Invitation sent";

      debugPrint('Team created: ${response.data}');
    } on DioError catch (err, stack) {
      debugPrint("error: $stack");
      message = err.response?.data.toString() ?? "";
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
        } catch (e) {
          debugPrint("error: ${e.toString()}");
        }
      }
    } catch (e) {
      debugPrint("error: ${e.toString()}");
      return null;
    }

    debugPrint('retrievedMatches ${retrievedMatches.toString()}');
    return retrievedMatches;
  }
}
