import 'package:flutter/material.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/widgets/user_card.dart';

class SearchUserScreen extends StatelessWidget {
  const SearchUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search user'),
      ),
      body: UserListBuilder(UserService.list()),
    );
  }
}

class UserListBuilder extends StatelessWidget {
  const UserListBuilder(
    this.futureList, {
    Key? key,
  }) : super(key: key);

  final Future<List<User>?> futureList;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>?>(
      future: futureList,
      builder: (BuildContext context, AsyncSnapshot<List<User>?> snapshot) {
        Widget child;
        List<User>? users = snapshot.data;
        if (snapshot.hasData && users != null) {
          child = ListView.builder(
            itemCount: users.length,
            itemBuilder: (_, i) => UserHorizontalCard(user: users[i]),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          child = const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          );
        } else {
          child = const Center(child: CircularProgressIndicator());
        }
        return child;
      },
    );
  }
}
