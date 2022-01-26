import 'package:flutter/material.dart';
import 'package:frontend/models/match/match.dart';
import 'package:frontend/widgets/match_screen.dart';
import 'package:frontend/widgets/team_card.dart';
import 'package:intl/intl.dart';

class MatchHorizontalCard extends StatelessWidget {
  const MatchHorizontalCard({
    this.onTap,
    required this.match,
    Key? key,
  }) : super(key: key);

  final GestureTapCallback? onTap;
  final MatchDto match;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MatchScreen(match: match)),
            );
          },
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.sports_soccer),
              title: Text("${match.teams[0].name} - ${match.teams[1].name}"),
              subtitle:
                  Text(DateFormat('yyyy-MM-dd  kk:mm').format(match.date)),
            ),
          ],
        ),
      ),
    );
  }
}

class MatchStackedCard extends StatelessWidget {
  const MatchStackedCard({
    Key? key,
    required this.match,
  }) : super(key: key);

  final MatchDto match;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Flexible(
        child: Column(
          children: [
            Column(
              children: [
                TeamHorizontalCard(team: match.teams[0]),
                const Text("vs"),
                TeamHorizontalCard(team: match.teams[1]),
              ],
            ),
            ListTile(
              title: const Text("Date"),
              subtitle:
                  Text(DateFormat('yyyy-MM-dd  kk:mm').format(match.date)),
            ),
            ListTile(
              title: const Text("Address"),
              subtitle: Text(match.address),
            ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   height: 300,
            //   child: MapTile(
            //     position: LatLng(52, 21),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
