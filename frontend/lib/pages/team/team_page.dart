import 'package:flutter/material.dart';
import 'package:frontend/models/team/team.dart';
import 'package:frontend/pages/team/search_player_screen.dart';
import 'package:frontend/pages/team/search_team_screen.dart';
import 'package:frontend/provider/user_change_notifier.dart';
import 'package:frontend/services/team_service.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/utils/snackbar_service.dart';
import 'package:frontend/widgets/team_card.dart';
import 'package:provider/src/provider.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team page'),
      ),
      body: context.watch<CurrentUser>().user?.team != null
          ? TeamBody(context.watch<CurrentUser>().user!.team!)
          : NoTeamBody(),
    );
  }
}

class TeamBody extends StatelessWidget {
  const TeamBody(
    this.team, {
    Key? key,
  }) : super(key: key);

  final Team team;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchUserScreen()),
          );
        },
        label: const Text("Add player"),
        icon: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          TeamStackedCard(
            team: team,
          ),
          if (team.userRequests.isNotEmpty) const Text("User requests"),
          UserRequestsListViewBuilder(
            UserService.getUserListFromIds(team.userRequests),
          ),
        ],
      ),
    );
  }
}

class NoTeamBody extends StatelessWidget {
  NoTeamBody({
    Key? key,
  }) : super(key: key);

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchTeamScreen()),
            );
          },
          child: const Text('Search Team'),
        ),
        ElevatedButton(
          onPressed: () async {
            String name = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Create team'),
                content: TextField(
                  controller: _controller,
                  decoration:
                      const InputDecoration(hintText: "Enter team name"),
                  autofocus: true,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(_controller.text);
                    },
                    child: const Text("Create"),
                  )
                ],
              ),
            );
            TeamService.create(name);
            String message = await TeamService.create(name);
            showSnackBar(context, message);
          },
          child: const Text('Create team'),
        ),
      ],
    );
  }
}
