import 'package:frontend/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team.g.dart';

@JsonSerializable()
class Team {
  @JsonKey(name: '_id')
  String? id;
  String name;
  @JsonKey(name: 'playersId')
  List<User> playerIds;
  User? founder;
  DateTime? createdAt;
  DateTime? updatedAt;

  Team({
    this.id,
    required this.name,
    required this.playerIds,
    required this.founder,
    this.createdAt,
    this.updatedAt,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
