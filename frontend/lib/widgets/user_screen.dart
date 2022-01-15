import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/settings.dart' as settings;
import 'package:frontend/models/team/team.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/widgets/team_card.dart';

class UserProfileScreen extends StatelessWidget {
  static const routeName = '/creations_library/video_meme_creator';

  final User user;

  const UserProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: user.profileImage != null
                      ? Image.network(
                          '${settings.serverUrl}/uploads/users/${user.profileImage}',
                          fit: BoxFit.fitWidth,
                        )
                      : Container()),
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
              // TODO: Use actual user team
              FutureBuilder<Team?>(
                future: UserService.team(),
                builder: (BuildContext context, AsyncSnapshot<Team?> snapshot) {
                  Widget child;
                  Team? userTeam = snapshot.data;
                  debugPrint(snapshot.hasData.toString());
                  if (snapshot.hasData && userTeam != null) {
                    child = TeamCard(team: userTeam);
                  } else {
                    child = Container();
                  }
                  return child;
                },
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => {},
                    child: const Text("Contact"),
                  ),
                  ElevatedButton(
                    onPressed: () => {},
                    child: const Text("Invite"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
