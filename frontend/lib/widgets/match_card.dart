import 'package:flutter/material.dart';
import 'package:frontend/models/match/match.dart';
import 'package:intl/intl.dart';

class MatchHorizontalCard extends StatelessWidget {
  const MatchHorizontalCard({
    required this.match,
    Key? key,
  }) : super(key: key);

  final MatchDto match;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.sports_soccer),
            title: Text("${match.teams[0].name} - ${match.teams[1].name}"),
            subtitle: Text(DateFormat('yyyy-MM-dd  kk:mm').format(match.date)),
          ),
        ],
      ),
    );
  }
}
