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
    final t = Team.fromJson({
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
    });

    expect(t.playerIds.length, 2);
    expect(t.founder.name, "seher1");
  });

  test('Deserialize match', () async {
    final m = MatchDto.fromJson(
      {
        "_id": "61dedd322fe5a2230f5c7345",
        "teamsId": [
          {
            "matchRequests": [],
            "_id": "61daeb010d81a001a600b621",
            "name": "Daniel test team",
            "playersId": [
              {
                "teamRequests": [],
                "_id": "61d96d1fd32805b9a2727742",
                "name": "Daniel",
                "password":
                    "aded05878c99323a4cad796597ba240c3fa876146a2befe89ffd7f26cda74be1",
                "email": "daniel@email.com",
                "createdAt": "2022-01-08T10:53:19.805Z",
                "updatedAt": "2022-01-09T14:02:41.159Z",
                "teamId": "61daeb010d81a001a600b621"
              },
              {
                "_id": "61df1d401a7499b0c88dab30",
                "name": "emery1",
                "password":
                    "3ab2a04500778313dc9a79b2d436f0a096534664783a83750def6961b520e324",
                "email": "omer1234567891@hotmail.com",
                "createdAt": "2022-01-12T18:26:08.158Z",
                "updatedAt": "2022-01-16T16:59:12.449Z",
                "teamRequests": []
              }
            ],
            "founder": {
              "teamRequests": [],
              "_id": "61d96d1fd32805b9a2727742",
              "name": "Daniel",
              "password":
                  "aded05878c99323a4cad796597ba240c3fa876146a2befe89ffd7f26cda74be1",
              "email": "daniel@email.com",
              "createdAt": "2022-01-08T10:53:19.805Z",
              "updatedAt": "2022-01-09T14:02:41.159Z",
              "teamId": "61daeb010d81a001a600b621"
            },
            "createdAt": "2022-01-09T14:02:41.058Z",
            "updatedAt": "2022-01-13T10:12:06.685Z",
            "matchs": ["61dee8022d65e654b605e9ff"],
            "matches": [],
            "userRequests": []
          }
        ],
        "adress": "sasdas",
        "createdAt": "2022-01-12T13:52:50.467Z",
        "updatedAt": "2022-01-12T13:52:50.467Z"
      },
    );

    expect(m.teamIds[1].playerIds[0], "Daniel");
  });
}
