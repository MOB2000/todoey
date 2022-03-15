import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/constants/strings.dart';
import 'package:todoey/helpers/db_helper.dart';
import 'package:todoey/providers/tasks_provider.dart';
import 'package:todoey/screens/tasks_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.instance.init();
  runApp(const Todoey());
}

class Todoey extends StatelessWidget {
  const Todoey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TasksProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kTodoey,
        home: TasksScreen(),
      ),
    );
  }
}
