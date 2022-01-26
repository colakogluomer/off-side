import 'package:flutter/material.dart';
import 'package:frontend/constants/settings.dart' as settings;
import 'package:frontend/models/user/user.dart';
import 'package:frontend/widgets/team_card.dart';
import 'package:frontend/widgets/user_screen.dart';

class UserHorizontalCard extends StatelessWidget {
  const UserHorizontalCard({
    this.onTap,
    required this.user,
    Key? key,
  }) : super(key: key);

  final User user;
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
              subtitle: Text(user.team?.name ?? "no team"),
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
          ListTile(title: Text(user.name), subtitle: Text(user.email)),
          if (user.team != null) TeamHorizontalCard(team: user.team!)
        ],
      ),
    );
  }
}
