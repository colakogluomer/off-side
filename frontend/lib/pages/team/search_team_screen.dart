import 'package:flutter/material.dart';
import 'package:frontend/models/team/team.dart';
import 'package:frontend/services/team_service.dart';
import 'package:frontend/widgets/team_card.dart';

class SearchTeamScreen extends StatelessWidget {
  static const routeName = '/creations_library/video_meme_creator';

  const SearchTeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search team'),
      ),
      body: FutureBuilder<List<Team>?>(
        future: TeamService.list(),
        builder: (BuildContext context, AsyncSnapshot<List<Team>?> snapshot) {
          Widget child;
          List<Team>? teams = snapshot.data;
          if (snapshot.hasData && teams != null) {
            child = ListView.builder(
              itemCount: teams.length,
              itemBuilder: (_, i) => TeamCard(team: teams[i]),
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
    );
  }
}
