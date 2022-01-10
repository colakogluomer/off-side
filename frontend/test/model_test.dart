// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
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
    final u = User.fromJson({
      "_id": "61b4cff4a3b665dec3b8bb6f",
      "name": "omer3434",
      "password":
          "bdbcbc97008bba7bb43115696cb2699baf2ff38998230f2b84cb84915a428fc2",
      "email": "omercolakoglu52@gmail.com",
      "createdAt": "2021-12-11T16:21:08.204Z",
      "updatedAt": "2021-12-14T20:04:12.329Z",
      "teamId": {
        "_id": "61b4f968d4a853fa5546dbb7",
        "name": "selamlar1",
        "playersId": [
          {"_id": "61b4cff4a3b665dec3b8bb6f", "name": "omer3434"}
        ]
      }
    });

    expect(u.teamId?.playerIds[0].id, "61b4cff4a3b665dec3b8bb6f");
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
}
