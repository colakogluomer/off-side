import 'package:flutter/material.dart';
import 'package:frontend/models/team/team.dart';
import 'package:frontend/provider/user_change_notifier.dart';
import 'package:frontend/services/team_service.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/utils/snackbar_service.dart';
import 'package:frontend/widgets/team_card.dart';
import 'package:provider/src/provider.dart';

class SearchTeamScreen extends StatelessWidget {
  const SearchTeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search team'),
      ),
      body: TeamListViewBuilder(TeamService.list()),
    );
  }
}

class TeamListViewBuilder extends StatelessWidget {
  const TeamListViewBuilder(
    this.futureList, {
    this.onTap,
    Key? key,
  }) : super(key: key);

  final Future<List<Team>?> futureList;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Team>?>(
      future: futureList,
      builder: (BuildContext context, AsyncSnapshot<List<Team>?> snapshot) {
        Widget child;
        List<Team>? teams = snapshot.data;
        if (snapshot.hasData && teams != null) {
          child = ListView.builder(
            itemCount: teams.length,
            itemBuilder: (_, i) => TeamHorizontalCard(team: teams[i]),
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
    );
  }
}

class TeamRequestsListView extends StatelessWidget {
  const TeamRequestsListView(
    this.teams, {
    this.onTap,
    Key? key,
  }) : super(key: key);

  final List<Team> teams;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: teams.length,
      shrinkWrap: true,
      itemBuilder: (_, i) => TeamHorizontalCard(
        team: teams[i],
        onTap: () async {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Join the team'),
              content: Expanded(child: TeamStackedCard(team: teams[i])),
              actions: [
                TextButton(
                  onPressed: () async {
                    String message = await UserService.rejectTeam(teams[i].id);
                    showSnackBar(context, message);
                    context.read<CurrentUser>().updateUser();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Reject"),
                ),
                TextButton(
                  onPressed: () async {
                    String message = await UserService.acceptTeam(teams[i].id);
                    showSnackBar(context, message);
                    context.read<CurrentUser>().updateUser();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Accept"),
                ),
              ],
            ),
          );
          context.read<CurrentUser>().updateUser();
        },
      ),
    );
  }
}
