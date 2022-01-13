import 'package:flutter/material.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/services/team_service.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/widgets/user_card.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({Key? key}) : super(key: key);

  Future<String> getUsers() async {
    return UserService.list().then((users) => users.toString());
  }

  Future<String> getTeams() async {
    return TeamService.list().then((teams) => teams.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team page'),
      ),
      body: Column(
        children: [
          FutureBuilder<String>(
            future: getTeams(), // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Result: ${snapshot.data}'),
                  )
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              } else {
                children = const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
          FutureBuilder<List<User>?>(
              future: UserService.list(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<User>?> snapshot) {
                Widget child;
                List<User>? users = snapshot.data;
                if (snapshot.hasData && users != null) {
                  child = SizedBox(
                    height: 300.0,
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (_, i) => UserCard(user: users[i]),
                    ),
                  );
                } else {
                  child = const Center(child: CircularProgressIndicator());
                }
                return child;
              }),
        ],
      ),
    );
  }
}
