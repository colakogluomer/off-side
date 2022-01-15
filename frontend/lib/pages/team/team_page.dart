import 'package:flutter/material.dart';
import 'package:frontend/models/team/team.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/pages/team/search_team_screen.dart';
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
          FutureBuilder<Team?>(
            future: UserService.team(),
            builder: (BuildContext context, AsyncSnapshot<Team?> snapshot) {
              Widget child;
              Team? userTeam = snapshot.data;
              debugPrint(snapshot.hasData.toString());
              if (snapshot.hasData && userTeam != null) {
                child = Column(
                  children: [
                    const Text("Your Team"),
                    TeamCard(team: userTeam),
                  ],
                );
              } else {
                child = Container();
              }
              return child;
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SearchTeamScreen()),
              );
            },
            child: const Text('Search Team'),
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
