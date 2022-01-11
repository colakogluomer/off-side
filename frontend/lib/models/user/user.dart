import 'package:frontend/models/team/team.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  String? id;
  String? email;
  String name;
  String? profileImage;
  Team? teamId;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    required this.email,
    required this.name,
    this.profileImage,
    this.teamId,
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
