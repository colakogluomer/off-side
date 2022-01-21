import 'package:flutter/material.dart';
import 'package:frontend/models/team/team.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/pages/team/search_player_screen.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/widgets/team_screen.dart';
import 'package:frontend/widgets/user_card.dart';

class TeamHorizontalCard extends StatelessWidget {
  const TeamHorizontalCard({
    required this.team,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final Team team;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap ??
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeamScreen(
                    team: team,
                  ),
                ),
              );
            },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.people),
              title: Text(team.name),
              subtitle: Text("${team.playerIds.length} players"),
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
      child: Flexible(
        child: Column(
          children: [
            const SizedBox(height: 15.0),
            ListTile(title: Text(team.name)),
            const ListTile(
              title: Text("Founder"),
            ),
            FutureBuilder<User>(
                future: team
                    .getFounder(), // a previously-obtained Future<String> or null
                builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final user = snapshot.data;
                    return user != null
                        ? UserHorizontalCard(user: user)
                        : Container();
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 40,
                      ),
                    );
                  } else {
                    return const SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            const ListTile(title: Text("Players")),
            UserListViewBuilder(
              UserService.getUserListFromIds(team.playerIds),
            ),
          ],
        ),
      ),
    );
  }
}
