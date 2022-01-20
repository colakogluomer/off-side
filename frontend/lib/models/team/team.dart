import 'package:json_annotation/json_annotation.dart';

part 'team.g.dart';

@JsonSerializable()
class Team {
  @JsonKey(name: '_id')
  String id;
  String name;
  @JsonKey(name: 'playersId')
  List<String> playerIds;
  List<String> matchRequests;
  List<String> userRequests;
  List<String> matches;
  @JsonKey(name: 'founder')
  String founderId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Team({
    required this.id,
    required this.name,
    required this.playerIds,
    required this.founderId,
    required this.matches,
    required this.matchRequests,
    required this.userRequests,
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
