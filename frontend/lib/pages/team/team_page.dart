import 'package:flutter/material.dart';
import 'package:frontend/models/team/team.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/services/team_service.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/widgets/team_card.dart';
import 'package:frontend/widgets/user_card.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({Key? key}) : super(key: key);

  Future<String> getUsers() async {
    return UserService.list().then((users) => users.toString());
  }

  Future<String> getTeams() async {
    return TeamService.list().then((teams) => teams.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team page'),
      ),
      body: Column(
        children: [
          FutureBuilder<List<Team>?>(
            future: TeamService.list(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Team>?> snapshot) {
              Widget child;
              List<Team>? teams = snapshot.data;
              if (snapshot.hasData && teams != null) {
                child = SizedBox(
                  height: 300.0,
                  child: ListView.builder(
                    itemCount: teams.length,
                    itemBuilder: (_, i) => TeamCard(team: teams[i]),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                child = const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                );
              } else {
                child = const Center(child: CircularProgressIndicator());
              }
              return child;
            },
          ),
          FutureBuilder<List<User>?>(
            future: UserService.list(),
            builder:
                (BuildContext context, AsyncSnapshot<List<User>?> snapshot) {
              Widget child;
              List<User>? users = snapshot.data;
              if (snapshot.hasData && users != null) {
                child = SizedBox(
                  height: 300.0,
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (_, i) => UserCard(user: users[i]),
                  ),
                );
              } else {
                child = const Center(child: CircularProgressIndicator());
              }
              return child;
            },
          ),
        ],
      ),
    );
  }
}
