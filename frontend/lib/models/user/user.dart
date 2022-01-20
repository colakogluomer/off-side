import 'package:frontend/models/team/team.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  String id;
  String email;
  String name;
  String? profileImage;
  @JsonKey(name: 'teamId')
  Team? team;
  List<Team> teamRequests;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.teamRequests,
    this.profileImage,
    this.team,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
