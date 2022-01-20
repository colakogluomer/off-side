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
      "teamRequests": [],
      "_id": "61b4cff4a3b665dec3b8bb6f",
      "name": "omer3434",
      "password":
          "bdbcbc97008bba7bb43115696cb2699baf2ff38998230f2b84cb84915a428fc2",
      "email": "omercolakoglu52@gmail.com",
      "createdAt": "2021-12-11T16:21:08.204Z",
      "updatedAt": "2021-12-14T20:04:12.329Z",
      "teamId": {
        "matches": [],
        "userRequests": [],
        "matchRequests": [],
        "_id": "61b4f968d4a853fa5546dbb7",
        "name": "selamlar1",
        "playersId": ["61b4cff4a3b665dec3b8bb6f"],
        "founder": "61b4cff4a3b665dec3b8bb6f",
        "createdAt": "2021-12-11T19:18:00.733Z",
        "updatedAt": "2021-12-11T19:18:00.733Z"
      }
    });

    expect(u.team?.playerIds[0], "61b4cff4a3b665dec3b8bb6f");
  });

  test('Deserialize team', () async {
    final t = Team.fromJson(
      {
        "_id": "61e859b80905d7e5bfa7e58e",
        "name": "onurun",
        "playersId": ["61e859310905d7e5bfa7e55b"],
        "founder": "61e859310905d7e5bfa7e55b",
        "matches": [],
        "userRequests": [],
        "matchRequests": [],
        "createdAt": "2022-01-19T18:34:32.019Z",
        "updatedAt": "2022-01-19T18:34:32.136Z"
      },
    );

    expect(t.playerIds[0], "61e859310905d7e5bfa7e55b");
    expect(t.founderId, "61e859310905d7e5bfa7e55b");
  });

  test('Deserialize match', () async {
    final m = MatchDto.fromJson({
      "_id": "61e1a9efd1d2b97af500961e",
      "teamsId": [
        {
          "userRequests": [],
          "matchRequests": [],
          "_id": "61e009f07348d78a4cae2d25",
          "name": "mistikteam",
          "playersId": ["61e008ae7348d78a4cae2d1d"],
          "founder": "61e008ae7348d78a4cae2d1d",
          "matches": [
            "61e00aa07348d78a4cae2d33",
            "61e1a93bd1d2b97af5009610",
            "61e1a9d5d1d2b97af5009617",
            "61e1a9efd1d2b97af500961e"
          ],
          "createdAt": "2022-01-13T11:16:00.982Z",
          "updatedAt": "2022-01-14T16:50:55.764Z"
        },
        {
          "userRequests": [],
          "matchRequests": [],
          "_id": "61defa280317404cdaa0d202",
          "name": "musti1",
          "playersId": ["61ddf5d87ca4f079fb9bc468"],
          "founder": "61ddf5d87ca4f079fb9bc468",
          "createdAt": "2022-01-12T15:56:24.928Z",
          "updatedAt": "2022-01-14T16:50:55.845Z",
          "matches": [
            "61e00aa07348d78a4cae2d33",
            "61e1a93bd1d2b97af5009610",
            "61e1a9d5d1d2b97af5009617",
            "61e1a9efd1d2b97af500961e"
          ]
        }
      ],
      "adress": "Mickewicza",
      "date": "2022-01-18T20:00:00.000Z",
      "createdAt": "2022-01-14T16:50:55.530Z",
      "updatedAt": "2022-01-14T16:50:55.530Z"
    });

    expect(m.teams[1].name, "musti1");
  });
}
