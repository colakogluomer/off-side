// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/match/match.dart';
import 'package:frontend/models/team/team.dart';
import 'package:frontend/models/user/user.dart';

void main() {
  test('Deserialize user', () async {
    final u = User.fromJson({
      "_id": "61a584f45dae7dcd664dd5dc",
      "name": "qwasdasdasd",
      "password":
          "a19acdd61933930b9fb30fc1b2cbd95a01a983c1c6b7dca9fe85a0be5b09ff3a",
      "email": "omer123@gmail.com",
      "createdAt": "2021-11-30T01:57:08.291Z",
      "updatedAt": "2021-11-30T01:57:08.291Z"
    });

    expect(u.name, "qwasdasdasd");
    expect(u.id, "61a584f45dae7dcd664dd5dc");
    expect(u.email, "omer123@gmail.com");
    expect(u.createdAt?.day, 30);
  });

  test('Deserialize user with team', () async {
    final u = User.fromJson(
      {
        "_id": "61d9cfd6467935d08fbe2fd2",
        "name": "Daniel",
        "password":
            "d4c2aa342ba7fe97c0a49c248e4e85d3769481d6885d0a493b4e139fa2849386",
        "email": "daniel@email.com",
        "createdAt": "2022-01-08T17:54:30.941Z",
        "updatedAt": "2022-01-15T20:13:07.976Z",
        "teamId": "61a591e1dd9d6d3a2703ff8f"
      },
    );

    expect(u.teamId, "61a591e1dd9d6d3a2703ff8f");
  });

  test('Deserialize user with team', () async {
    final t = Team.fromJson(
      {
        "_id": "61b4d045a3b665dec3b8bb72",
        "name": "hellotry",
        "playersId": [],
        "founder": {"_id": "61b4cff4a3b665dec3b8bb6f", "name": "omer3434"},
        "createdAt": "2021-12-11T16:22:29.573Z",
        "updatedAt": "2021-12-11T16:22:29.573Z"
      },
    );

    expect(t.playerIds, []);
    expect(t.id, "61b4d045a3b665dec3b8bb72");
    expect(t.name, "hellotry");
    expect(t.createdAt?.day, 11);
    expect(t.founder?.name, "omer3434");
  });

  test('Deserialize match', () async {
    final m = MatchDto.fromJson(
      {
        "_id": "61dee2fe6fd0301c717f1d8c",
        "teamsId": ["61ddfbefd17ef039dfe8b7fc", "61daeb010d81a001a600b621"],
        "adress": "sasdas",
        "date": "2022-01-18T20:00:00.000Z",
        "createdAt": "2022-01-12T14:17:34.600Z",
        "updatedAt": "2022-01-12T14:17:34.600Z"
      },
    );

    expect(m.teamIds[1], "61daeb010d81a001a600b621");
    expect(m.address, "sasdas");
    expect(m.createdAt?.day, 12);
    expect(m.date.day, 18);
  });
}
