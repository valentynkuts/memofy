import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memofy/data/dataproviders/subtask_configuration.dart';
import 'package:memofy/data/dataproviders/subtask_data/subtask_data_model.dart';
import 'package:memofy/presentation/screens/add_subtask/add_subtask_screen.dart';
import 'package:memofy/presentation/screens/add_task/add_task_screen.dart';
import 'package:memofy/presentation/screens/subtasks_list/subtasks_list_screen.dart';
import 'package:memofy/presentation/screens/tasks_list/tasks_list_screen.dart';
import 'package:memofy/validation/add_task_validation.dart';
import 'package:provider/provider.dart';

import 'auth/auth.dart';
import 'data/dataproviders/task_data/task_data_model.dart';
import 'models/subtask/subtask_model.dart';
import 'models/task/task_model.dart';

void main() async{
  //if main is async we add WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  //Initializes Hive with a valid directory in your app files.
  await Hive.initFlutter();

  //Hive.deleteFromDisk();

  //Hive.registerAdapter(TaskModelAdapter());
  //Hive.registerAdapter(SubtaskModelAdapter());

  //TODO box  tasks   tasks1 tasks2
  //await Hive.openBox<TaskModel>('tasks3');
 // await Hive.openBox<SubtaskModel>('subtasks');

  runApp(MyApp());

   //https://docs.hivedb.dev/#/advanced/compaction
  //await box.compact();  //delete deleted data
  //await box.close();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
          ChangeNotifierProvider<TaskDataModel>(
            create: (context) => TaskDataModel(),
          ),
          ChangeNotifierProvider<AddTaskValidation>(
            create: (context) => AddTaskValidation(),
          ),
          // ChangeNotifierProvider<SubtaskDataProvider>(
          //   create: (context) => SubtaskDataProvider(subtaskConfiguration: SubtaskConfiguration(taskKey: "",titleTask: "")),
          // ),
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
          SubtasksListScreen.id : (context) {
            // final arguments = ModalRoute.of(context)?.settings.arguments;
            // if (arguments is String) {
            //   return SubtasksListScreen(keyTask: arguments);
            // } else {
            //   return SubtasksListScreen(keyTask: "0");
            // }

            final arguments = ModalRoute.of(context)?.settings.arguments;
              return SubtasksListScreen(subtaskConfiguration: arguments as SubtaskConfiguration);

          },
          AddSubtaskScreen.id : (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments;
            //return AddSubtaskScreen(taskKey: arguments as String,);
            //return AddSubtaskScreen(subtaskConfiguration: arguments as SubtaskConfiguration,);
            return AddSubtaskScreen(subtaskDataProvider: arguments as SubtaskDataModel,);
          },
        },
      ),
    );
  }
}
