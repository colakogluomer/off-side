import 'package:flutter/material.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/provider/user_change_notifier.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/utils/snackbar_service.dart';
import 'package:frontend/widgets/user_card.dart';
import 'package:provider/src/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfilePage'),
      ),
      body: const ProfilePageBody(),
    );
  }
}

class ProfilePageBody extends StatefulWidget {
  const ProfilePageBody({Key? key}) : super(key: key);

  @override
  _ProfilePageBodyState createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<ProfilePageBody> {
  @override
  void initState() {
    context.read<CurrentUser>().updateUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<CurrentUser>().user != null
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                UserStackedCard(user: context.watch<CurrentUser>().user!),
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await UserService.logout();
                          context.read<CurrentUser>().updateUser();
                        },
                        child: const Text("Logout")),
                    context.watch<CurrentUser>().user?.team != null
                        ? ElevatedButton(
                            onPressed: () async {
                              String? message = await UserService.leaveTeam();
                              message ??= "You left the team.";
                              showSnackBar(context, message);

                              context.read<CurrentUser>().updateUser();
                            },
                            child: const Text("Leave team"),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          )
        : Center(
            child: ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
                context.read<CurrentUser>().updateUser();
              },
              child: const Text("Log in"),
            ),
          );
  }
}
