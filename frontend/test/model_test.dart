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
  test('Deserialize user with team', () async {
    final u = User.fromJson({
      "_id": "61e6f2e895fbe5eefa3e3f35",
      "name": "seher1",
      "password":
          "29fc2c32ce9ad661fdd5fae179fe138f2d8d4f1ad3cc05d8333ef117ae6d6084",
      "email": "seher1@hotmail.com",
      "teamRequests": [],
      "createdAt": "2022-01-18T17:03:36.841Z",
      "updatedAt": "2022-01-18T17:04:04.975Z",
      "teamId": {
        "_id": "61e6f30495fbe5eefa3e3f39",
        "name": "seherin2",
        "playersId": [
          {
            "_id": "61e6f2e895fbe5eefa3e3f35",
            "name": "seher1",
            "password":
                "29fc2c32ce9ad661fdd5fae179fe138f2d8d4f1ad3cc05d8333ef117ae6d6084",
            "email": "seher1@hotmail.com",
            "teamRequests": [],
            "createdAt": "2022-01-18T17:03:36.841Z",
            "updatedAt": "2022-01-18T17:04:04.975Z",
            "teamId": "61e6f30495fbe5eefa3e3f39"
          },
          {
            "_id": "61e6f1e695fbe5eefa3e3f24",
            "name": "seher2",
            "password":
                "29fc2c32ce9ad661fdd5fae179fe138f2d8d4f1ad3cc05d8333ef117ae6d6084",
            "email": "seher2@hotmail.com",
            "teamRequests": [],
            "createdAt": "2022-01-18T16:59:18.388Z",
            "updatedAt": "2022-01-18T17:05:55.093Z",
            "teamId": "61e6f30495fbe5eefa3e3f39"
          }
        ],
        "founder": {
          "_id": "61e6f2e895fbe5eefa3e3f35",
          "name": "seher1",
          "password":
              "29fc2c32ce9ad661fdd5fae179fe138f2d8d4f1ad3cc05d8333ef117ae6d6084",
          "email": "seher1@hotmail.com",
          "teamRequests": [],
          "createdAt": "2022-01-18T17:03:36.841Z",
          "updatedAt": "2022-01-18T17:04:04.975Z",
          "teamId": "61e6f30495fbe5eefa3e3f39"
        },
        "matches": [],
        "userRequests": [],
        "matchRequests": [],
        "createdAt": "2022-01-18T17:04:04.722Z",
        "updatedAt": "2022-01-18T17:05:55.337Z"
      }
    });

    expect(u.teamId?.playerIds[1].name, "seher2");
  });

  test('Deserialize team', () async {
    final t = Team.fromJson(
      {
        "userRequests": [],
        "matchRequests": [],
        "_id": "61defa39ac926ade7f74fdf9",
        "name": "musti1",
        "playersId": [
          {
            "teamRequests": [],
            "_id": "61ddf5d87ca4f079fb9bc468",
            "name": "mustafa2",
            "password":
                "3ad2ddb2dbf10d159522deeb2b2240d187217b0b46f2b55ba486c61b009fcc55",
            "email": "mustafa123@hotmail.com",
            "createdAt": "2022-01-11T21:25:44.925Z",
            "updatedAt": "2022-01-14T16:23:01.290Z"
          }
        ],
        "founder": {
          "teamRequests": [],
          "_id": "61ddf5d87ca4f079fb9bc468",
          "name": "mustafa2",
          "password":
              "3ad2ddb2dbf10d159522deeb2b2240d187217b0b46f2b55ba486c61b009fcc55",
          "email": "mustafa123@hotmail.com",
          "createdAt": "2022-01-11T21:25:44.925Z",
          "updatedAt": "2022-01-14T16:23:01.290Z"
        },
        "createdAt": "2022-01-12T15:56:41.477Z",
        "updatedAt": "2022-01-13T10:48:16.899Z",
        "matches": [
          {
            "_id": "61e00370691ecc58ee7177ec",
            "teamsId": ["61defa39ac926ade7f74fdf9", "61defabfac5a8929b773e0f8"],
            "adress": "Lodz",
            "createdAt": "2022-01-13T10:48:16.664Z",
            "updatedAt": "2022-01-13T10:48:16.664Z",
            "date": "2022-01-18T11:18:56.424Z",
          }
        ]
      },
    );

    expect(t.playerIds[0].name, "mustafa2");
    expect(t.founder.name, "mustafa2");
  });

  test('Deserialize match', () async {
    final m = MatchDto.fromJson({
      "_id": "61e1a9efd1d2b97af500961e",
      "teamsId": ["61e009f07348d78a4cae2d25", "61defa280317404cdaa0d202"],
      "adress": "Mickewicza",
      "date": "2022-01-18T20:00:00.000Z",
      "createdAt": "2022-01-14T16:50:55.530Z",
      "updatedAt": "2022-01-14T16:50:55.530Z"
    });

    expect(m.teamIds[1], "61defa280317404cdaa0d202");
  });
}
