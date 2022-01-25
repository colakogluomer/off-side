import 'package:flutter/material.dart';
import 'package:frontend/pages/match/map_test.dart';
import 'package:frontend/pages/match/match_list_screen.dart';
import 'package:frontend/pages/team/search_team_screen.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match page'),
      ),
      body: Center(
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapTest()),
                );
              },
              child: const Text("Map test"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MatchList()),
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
      ),
    );
  }
}
