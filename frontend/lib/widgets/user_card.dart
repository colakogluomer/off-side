import 'package:flutter/material.dart';
import 'package:frontend/models/user/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    required this.user,
    Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: user.profileImage != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(user.profileImage ?? ""),
                  )
                : const Icon(Icons.person),
            title: Text(user.name),
            subtitle: Text(user.email ?? ""),
          ),
        ],
      ),
    );
  }
}
