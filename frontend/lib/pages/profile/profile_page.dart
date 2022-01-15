import 'package:flutter/material.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/services/user_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfilePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: const Text("Login")),
            ElevatedButton(
                onPressed: () {
                  UserService.logout();
                },
                child: const Text("Logout")),
            ElevatedButton(
                onPressed: () {
                  UserService.leaveTeam();
                },
                child: const Text("Leave team")),
          ],
        ),
      ),
    );
  }
}
