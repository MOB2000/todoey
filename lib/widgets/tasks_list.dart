import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/constants/strings.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/providers/tasks_provider.dart';
import 'package:todoey/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  Future<bool?> _showDeleteAlert(BuildContext context, Task task) async {
    final provider = Provider.of<TasksProvider>(context, listen: false);
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(kAreYouSure),
        content: const Text(kDoYouWantToDeleteTheTask),
        actions: <Widget>[
          TextButton(
            child: const Text(kYes),
            onPressed: () async {
              await provider.deleteTask(task);
              Navigator.of(context).pop(true);
            },
          ),
          TextButton(
            child: const Text(kNo),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TasksProvider>(context);
    return FutureBuilder<List<Task>>(
      future: provider.tasks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          final tasks = snapshot.data!;
          if (tasks.isEmpty) {
            return const Center(
              child: Text(kStartAddTasks),
            );
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskTile(
                taskTitle: task.title,
                isChecked: task.isDone,
                onChange: (newValue) async {
                  await provider.updateTask(task);
                },
                onLongPress: () => _showDeleteAlert(context, task),
              );
            },
          );
        }
        return const Text(kErrorLoadingData);
      },
    );
  }
}
