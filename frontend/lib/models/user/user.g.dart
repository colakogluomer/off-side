// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      teamRequests: (json['teamRequests'] as List<dynamic>)
          .map((e) => Team.fromJson(e as Map<String, dynamic>))
          .toList(),
      profileImage: json['profileImage'] as String?,
      team: json['teamId'] == null
          ? null
          : Team.fromJson(json['teamId'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'profileImage': instance.profileImage,
      'teamId': instance.team,
      'teamRequests': instance.teamRequests,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
