import 'package:flutter/material.dart';
import 'package:frontend/constants/settings.dart' as settings;
import 'package:frontend/models/team/team.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/services/team_service.dart';
import 'package:frontend/widgets/team_card.dart';
import 'package:frontend/widgets/user_screen.dart';

class UserHorizontalCard extends StatelessWidget {
  const UserHorizontalCard({
    required this.user,
    Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserProfileScreen(user: user)),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: user.profileImage != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${settings.serverUrl}/uploads/users/${user.profileImage}'),
                    )
                  : const Icon(Icons.person),
              title: Text(user.name),
              subtitle: Text(user.email ?? ""),
            ),
          ],
        ),
      ),
    );
  }
}

class UserStackedCard extends StatelessWidget {
  const UserStackedCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: user.profileImage != null
                ? Image.network(
                    '${settings.serverUrl}/uploads/users/${user.profileImage}',
                    fit: BoxFit.fitWidth,
                  )
                : Image.asset(
                    'images/avatar_placeholder.png',
                    fit: BoxFit.fitWidth,
                  ),
          ),
          const SizedBox(height: 15.0),
          ListTile(
            title: Text(user.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('position'),
                Text('level'),
              ],
            ),
          ),
          if (user.teamId != null)
            FutureBuilder<Team?>(
              future: TeamService.getById(user.teamId ?? "no team"),
              builder: (BuildContext context, AsyncSnapshot<Team?> snapshot) {
                Widget child;
                Team? userTeam = snapshot.data;
                debugPrint(snapshot.hasData.toString());
                if (snapshot.hasData && userTeam != null) {
                  child = TeamHorizontalCard(team: userTeam);
                } else {
                  child = Container();
                }
                return child;
              },
            ),
        ],
      ),
    );
  }
}
