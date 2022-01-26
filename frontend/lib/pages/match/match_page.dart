import 'package:flutter/material.dart';
import 'package:frontend/models/match/match.dart';
import 'package:frontend/pages/match/match_list_screen.dart';
import 'package:frontend/pages/team/search_team_screen.dart';
import 'package:frontend/provider/user_change_notifier.dart';
import 'package:frontend/services/match_service.dart';
import 'package:frontend/services/team_service.dart';
import 'package:frontend/widgets/match_card.dart';
import 'package:provider/src/provider.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match page'),
      ),
      body: Center(
        child: Column(
          children: [
            if (context
                    .watch<CurrentUser>()
                    .user
                    ?.team
                    ?.matchRequests
                    .isNotEmpty ??
                false)
              Column(
                children: [
                  const ListTile(
                    title: Text("Match requests"),
                  ),
                  SizedBox(
                    height: 200.0,
                    width: 300.0,
                    child: MatchRequestsListView(
                        TeamService.getTeamsListFromIds(context
                                .watch<CurrentUser>()
                                .user
                                ?.team
                                ?.matchRequests ??
                            [])),
                  ),
                ],
              ),
            if (context.watch<CurrentUser>().user?.team?.matches.isNotEmpty ??
                false)
              Column(
                children: [
                  const ListTile(
                    title: Text("Matches"),
                  ),
                  SizedBox(
                    height: 200.0,
                    width: 350.0,
                    child: FutureBuilder<List<MatchDto>?>(
                      future: MatchService.getTeamMatches(
                          context.watch<CurrentUser>().user?.team?.id ?? ""),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<MatchDto>?> snapshot) {
                        Widget child;
                        List<MatchDto>? matches = snapshot.data;
                        if (snapshot.hasData && matches != null) {
                          child = ListView.builder(
                            itemCount: matches.length,
                            itemBuilder: (_, i) =>
                                MatchHorizontalCard(match: matches[i]),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          child = const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          );
                        } else {
                          child =
                              const Center(child: CircularProgressIndicator());
                        }
                        return child;
                      },
                    ),
                  ),
                ],
              ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MatchList()),
                    );
                  },
                  child: const Text("Matches nearby"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchTeamScreen()),
                    );
                  },
                  child: const Text('Search Team for a match'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
