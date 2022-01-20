import 'package:flutter/material.dart';
import 'package:frontend/models/team/team.dart';
import 'package:frontend/services/team_service.dart';
import 'package:frontend/utils/snackbar_service.dart';
import 'package:frontend/widgets/team_screen.dart';
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
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TeamScreen(
                      team: team,
                    )),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.people),
              title: Text(team.name),
              subtitle: Text(team.founder.name),
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
          const SizedBox(height: 15.0),
          ListTile(title: Text(team.name)),
          const ListTile(
            title: Text("Founder"),
          ),
          UserHorizontalCard(user: team.founder),
          ListTile(title: Text("Players")),
          SizedBox(
            height: 300.0,
            child: ListView.builder(
              itemCount: team.playerIds.length,
              itemBuilder: (_, i) =>
                  UserHorizontalCard(user: team.playerIds[i]),
            ),
          ),
        ],
      ),
    );
  }
}
