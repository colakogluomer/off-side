import 'package:flutter/material.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/utils/snackbar_service.dart';
import 'package:frontend/widgets/user_card.dart';

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
  User? user;

  Future<void> updateUser() async {
    user = await UserService.getCurrentUser();
  }

  @override
  void initState() {
    updateUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return user != null
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                UserStackedCard(user: user!),
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await UserService.logout();
                          await updateUser();
                          setState(() {
                            user;
                          });
                        },
                        child: const Text("Logout")),
                    user?.team != null
                        ? ElevatedButton(
                            onPressed: () async {
                              String? message = await UserService.leaveTeam();
                              message ??= "You left the team.";
                              showSnackBar(context, message);

                              await updateUser();
                              setState(() {
                                user;
                              });
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
                await updateUser();

                setState(() {
                  user;
                });
              },
              child: const Text("Log in"),
            ),
          );
  }
}
