import 'package:frontend/models/team/team.dart';
import 'package:json_annotation/json_annotation.dart';

part 'match.g.dart';

@JsonSerializable()
class MatchDto {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'teamsId')
  List<Team> teams;
  @JsonKey(name: 'adress')
  String address;
  DateTime date;
  DateTime? createdAt;
  DateTime? updatedAt;

  MatchDto({
    required this.id,
    required this.teams,
    required this.address,
    required this.date,
    this.createdAt,
    this.updatedAt,
  });

  factory MatchDto.fromJson(Map<String, dynamic> json) =>
      _$MatchDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MatchDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
