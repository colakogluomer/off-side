import 'package:flutter/material.dart';
import 'package:frontend/models/team/team.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/services/team_service.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/utils/snackbar_service.dart';
import 'package:frontend/widgets/user_card.dart';

class TeamHorizontalCard extends StatelessWidget {
  const TeamHorizontalCard({
    required this.team,
    Key? key,
  }) : super(key: key);

  final Team team;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.people),
            title: Text(team.name),
            subtitle: Text(team.founder?.name ?? ""),
            trailing: TextButton(
              child: const Text("Join"),
              onPressed: () async {
                String? message = await TeamService.join(team.id ?? "");
                message ??= "You joined the team: ${team.name}";
                showSnackBar(context, message);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TeamStackedCard extends StatelessWidget {
  const TeamStackedCard({
    Key? key,
    required this.team,
  }) : super(key: key);

  final Team team;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Image.asset(
              'images/avatar_placeholder.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 15.0),
          ListTile(
            title: Text(team.name),
          ),
          const ListTile(
            title: Text("Founder"),
          ),
          if (team.founder != null)
            FutureBuilder<User?>(
              future: UserService.getById(team.founder),
              builder: (BuildContext context, AsyncSnapshot<Team?> snapshot) {
                Widget child;
                Team? userTeam = snapshot.data;
                debugPrint(snapshot.hasData.toString());
                if (snapshot.hasData && userTeam != null) {
                  child = TeamHorizontalCard(team: userTeam);
                } else {
                  child = Container();
                }
                return child;
              },
            ),
          FutureBuilder<List<User>?>(
            future: UserService.getUserListFromIds(team.playerIds),
            builder:
                (BuildContext context, AsyncSnapshot<List<User>?> snapshot) {
              Widget child;
              List<User>? users = snapshot.data;
              if (snapshot.hasData && users != null) {
                child = SizedBox(
                  height: 300.0,
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (_, i) => UserHorizontalCard(user: users[i]),
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
