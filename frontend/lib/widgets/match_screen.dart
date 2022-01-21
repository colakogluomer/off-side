import 'package:flutter/material.dart';
import 'package:frontend/models/match/match.dart';
import 'package:frontend/widgets/match_card.dart';

class MatchScreen extends StatelessWidget {
  final MatchDto match;

  const MatchScreen({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MatchStackedCard(match: match),
          ],
        ),
      ),
    );
  }
}
