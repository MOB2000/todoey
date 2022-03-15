import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/constants/strings.dart';
import 'package:todoey/providers/tasks_provider.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TasksProvider>(context);
    final mediaQuery = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(mediaQuery * .05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: mediaQuery * .04,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.list,
              size: mediaQuery * .05,
              color: Colors.lightBlueAccent,
            ),
          ),
          SizedBox(height: mediaQuery * .02),
          const Text(
            kTodoey,
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
          ),
          FutureBuilder<int>(
            future: provider.tasksCount,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final tasksCount = snapshot.data!;
                return Text(
                  '$tasksCount $kTasks',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
          ),
        ],
      ),
    );
  }
}
