import 'package:flutter/material.dart';
import 'package:frontend/models/team/team.dart';
import 'package:frontend/services/team_service.dart';
import 'package:frontend/utils/snackbar_service.dart';
import 'package:frontend/widgets/team_card.dart';

class TeamScreen extends StatelessWidget {
  final Team team;

  const TeamScreen({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TeamStackedCard(team: team),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              children: [
                const ElevatedButton(
                  onPressed: null,
                  child: Text("Challenge"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String? message = await TeamService.join(team.id);
                    message ??= "You send request to ${team.name}";
                    showSnackBar(context, message);
                  },
                  child: const Text("Join"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
