import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/constants/strings.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/providers/tasks_provider.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  final taskTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TasksProvider>(context);
    return SafeArea(
      child: Container(
        color: const Color(0xff757575),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  kAddTask,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: taskTitleController,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlueAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.lightBlueAccent, padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    kAdd,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  onPressed: () async {
                    if (taskTitleController.text.trim().isEmpty) {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(kMustEnterName),
                          actions: [
                            TextButton(
                              child: const Text(kOk),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                      );
                      return;
                    }
                    await provider
                        .addTask(Task(title: taskTitleController.text));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
