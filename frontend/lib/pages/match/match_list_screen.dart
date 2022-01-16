import 'package:flutter/material.dart';
import 'package:frontend/models/match/match.dart';
import 'package:frontend/services/match_service.dart';
import 'package:frontend/widgets/match_card.dart';

class MatchList extends StatelessWidget {
  const MatchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matches'),
      ),
      body: FutureBuilder<List<MatchDto>?>(
        future: MatchService.list(),
        builder:
            (BuildContext context, AsyncSnapshot<List<MatchDto>?> snapshot) {
          Widget child;
          List<MatchDto>? matches = snapshot.data;
          if (snapshot.hasData && matches != null) {
            child = ListView.builder(
              itemCount: matches.length,
              itemBuilder: (_, i) => MatchHorizontalCard(match: matches[i]),
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
