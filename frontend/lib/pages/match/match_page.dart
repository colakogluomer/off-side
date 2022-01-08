import 'package:flutter/material.dart';
import 'package:frontend/pages/match/map_test.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match page'),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapTest()),
                );
              },
              child: const Text("Map test"))),
    );
  }
}
