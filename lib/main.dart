import 'package:flutter/material.dart';
import 'package:memofy/presentation/screens/add_task/add_task_screen.dart';
import 'package:memofy/presentation/screens/tasks_list/tasks_list_screen.dart';
import 'package:memofy/validation/add_task_validation.dart';
import 'package:provider/provider.dart';

import 'auth/auth.dart';
import 'data/dataproviders/task_data/task_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
          ChangeNotifierProvider<TaskDataProvider>(
            create: (context) => TaskDataProvider(),
          ),
          ChangeNotifierProvider<AddTaskValidation>(
            create: (context) => AddTaskValidation(),
          )
        ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
          ),
        ),
        initialRoute: TasksListScreen.id,
        routes: {
          '/auth': (context) => Auth(),
          TasksListScreen.id : (context) => TasksListScreen(),
          AddTaskScreen.id : (context) => AddTaskScreen(),
        },
      ),
    );
  }
}
