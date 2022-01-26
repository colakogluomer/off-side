import 'package:flutter/material.dart';
import 'package:frontend/provider/user_change_notifier.dart';
import 'package:frontend/services/match_service.dart';
import 'package:frontend/utils/snackbar_service.dart';
import 'package:provider/src/provider.dart';

class SetupMatchScreen extends StatefulWidget {
  const SetupMatchScreen(this.teamId, {Key? key}) : super(key: key);

  final String teamId;
  @override
  _SetupMatchScreenState createState() => _SetupMatchScreenState();
}

class _SetupMatchScreenState extends State<SetupMatchScreen> {
  String date = "";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 12, minute: 30);

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set up the match"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: const Text("Choose Date"),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Text(
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _selectTime(context);
                  },
                  child: const Text("Choose Time"),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Text("${selectedTime.hour}:${selectedTime.minute}"),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () async {
                String message = await MatchService.acceptMatchInvitation(
                    widget.teamId,
                    DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    ),
                    _controller.text);
                showSnackBar(context, message);
                if (message == "Match invitation accepted") {
                  context.read<CurrentUser>().updateUser();
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
