import 'package:flutter/material.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/provider/user_change_notifier.dart';
import 'package:frontend/services/team_service.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/utils/snackbar_service.dart';
import 'package:frontend/widgets/user_card.dart';
import 'package:provider/src/provider.dart';

class SearchUserScreen extends StatelessWidget {
  const SearchUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search user'),
      ),
      body: UserListViewBuilder(UserService.list()),
    );
  }
}

class UserListViewBuilder extends StatelessWidget {
  const UserListViewBuilder(
    this.futureList, {
    this.onTap,
    this.physics,
    Key? key,
  }) : super(key: key);

  final Future<List<User>?> futureList;
  final GestureTapCallback? onTap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>?>(
      future: futureList,
      builder: (BuildContext context, AsyncSnapshot<List<User>?> snapshot) {
        Widget child;
        List<User>? users = snapshot.data;
        if (snapshot.hasData && users != null) {
          child = ListView.builder(
            physics: physics,
            shrinkWrap: true,
            itemCount: users.length,
            itemBuilder: (_, i) => UserHorizontalCard(
              user: users[i],
              onTap: onTap,
            ),
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

class UserRequestsListViewBuilder extends StatelessWidget {
  const UserRequestsListViewBuilder(
    this.futureList, {
    this.onTap,
    this.physics,
    Key? key,
  }) : super(key: key);

  final Future<List<User>?> futureList;
  final GestureTapCallback? onTap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>?>(
      future: futureList,
      builder: (BuildContext context, AsyncSnapshot<List<User>?> snapshot) {
        Widget child;
        List<User>? users = snapshot.data;
        if (snapshot.hasData && users != null) {
          child = ListView.builder(
            physics: physics,
            shrinkWrap: true,
            itemCount: users.length,
            itemBuilder: (_, i) => UserHorizontalCard(
              user: users[i],
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Accept player'),
                    content: UserStackedCard(user: users[i]),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          String message =
                              await TeamService.rejectPlayer(users[i].id);
                          context.read<CurrentUser>().updateUser();
                          showSnackBar(context, message);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Reject"),
                      ),
                      TextButton(
                        onPressed: () async {
                          String message =
                              await TeamService.acceptPlayer(users[i].id);
                          context.read<CurrentUser>().updateUser();
                          showSnackBar(context, message);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Accept"),
                      ),
                    ],
                  ),
                );
                context.read<CurrentUser>().updateUser();
              },
            ),
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
