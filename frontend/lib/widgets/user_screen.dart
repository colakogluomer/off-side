import 'package:flutter/material.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/utils/snackbar_service.dart';
import 'package:frontend/widgets/user_card.dart';

class UserProfileScreen extends StatelessWidget {
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
        child: Column(
          children: [
            UserStackedCard(user: user),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final message = await UserService.invite(user.id);
                    showSnackBar(context, message);
                  },
                  child: const Text("Invite"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
