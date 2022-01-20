// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      id: json['_id'] as String,
      name: json['name'] as String,
      playerIds:
          (json['playersId'] as List<dynamic>).map((e) => e as String).toList(),
      founderId: json['founder'] as String,
      matches:
          (json['matches'] as List<dynamic>).map((e) => e as String).toList(),
      matchRequests: (json['matchRequests'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      userRequests: (json['userRequests'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'playersId': instance.playerIds,
      'matchRequests': instance.matchRequests,
      'userRequests': instance.userRequests,
      'matches': instance.matches,
      'founder': instance.founderId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
