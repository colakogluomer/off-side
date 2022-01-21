import 'package:flutter/material.dart';
import 'package:frontend/pages/team/search_player_screen.dart';
import 'package:frontend/pages/team/search_team_screen.dart';
import 'package:frontend/provider/user_change_notifier.dart';
import 'package:frontend/services/team_service.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/widgets/team_card.dart';
import 'package:provider/src/provider.dart';

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
          if (context.watch<CurrentUser>().user?.team != null)
            TeamHorizontalCard(team: context.watch<CurrentUser>().user!.team!),
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
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SearchUserScreen()),
              );
            },
            child: const Text('Search Player'),
          ),
        ],
      ),
    );
  }
}
