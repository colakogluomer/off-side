import 'package:flutter/material.dart';
import 'package:frontend/models/team/team.dart';
import 'package:frontend/services/team_service.dart';

class TeamCard extends StatelessWidget {
  const TeamCard({
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
              onPressed: () async => await TeamService.join(team.id ?? ""),
            ),
          ),
        ],
      ),
    );
  }
}
