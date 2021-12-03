import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memofy/data/dataproviders/subtask_configuration.dart';
import 'package:memofy/data/dataproviders/subtask_data/subtask_data_model.dart';
import 'package:memofy/presentation/screens/add_subtask/add_subtask_screen.dart';
import 'package:memofy/presentation/screens/add_task/add_task_screen.dart';
import 'package:memofy/presentation/screens/done_tasks/done_tasks_list_screen.dart';
import 'package:memofy/presentation/screens/home/home_page_screen.dart';
import 'package:memofy/presentation/screens/subtasks_list/subtasks_list_screen.dart';
import 'package:memofy/presentation/screens/tasks_list/tasks_list_screen.dart';
import 'package:memofy/validation/add_task_validation.dart';
import 'package:memofy/validation/validation.dart';
import 'package:provider/provider.dart';

import 'auth/auth.dart';
import 'data/dataproviders/done_task_data/done_task_data_model.dart';
import 'data/dataproviders/task_data/task_data_model.dart';
import 'models/subtask/subtask_model.dart';
import 'models/task/task_model.dart';

// https://docs.flutter.dev/cookbook/navigation/passing-data
// https://docs.hivedb.dev/#/basics/read_write
// https://habr.com/ru/post/498070/
// https://dart.dev/codelabs/async-await
// https://docs.flutter.dev/cookbook/forms/validation  // TODO
// https://docs.flutter.dev/development/ui/layout
// https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple
// https://medium.com/flutter-community/a-deep-dive-into-datepicker-in-flutter-37e84f7d8d6c
// https://medium.com/flutter-community/flutter-ide-shortcuts-for-faster-development-2ef45c51085b
// https://habr.com/ru/post/476018/             // Как работает Flutter
// https://www.youtube.com/watch?v=ZZ4VVlggIVk&list=PLptHs0ZDJKt_fLp8ImPQVc1obUJKDSQL7&index=36        //Null safety

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
          ChangeNotifierProvider<DoneTaskDataModel>(
            create: (context) => DoneTaskDataModel(),
          ),
          ChangeNotifierProvider<TextValidation>(
            create: (context) => TextValidation(),
          ),

          // ChangeNotifierProvider<SubtaskDataProvider>(
          //   create: (context) => SubtaskDataProvider(subtaskConfiguration: SubtaskConfiguration(taskKey: "",titleTask: "")),
          // ),
        ],
      child: MaterialApp(
        //title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
          ),
          // bottomNavigationBarTheme: BottomNavigationBarThemeData(
          //   backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
          //   selectedItemColor: Colors.white,
          //   unselectedItemColor: Colors.grey,
          // ),
        ),
        initialRoute: HomePageScreen.id,
        routes: {
          //'/auth': (context) => Auth(),
          HomePageScreen.id: (context) => HomePageScreen(),
          TasksListScreen.id : (context) => TasksListScreen(),
          AddTaskScreen.id : (context) => AddTaskScreen(),
          DoneTasksListScreen.id : (context) => DoneTasksListScreen(),
          SubtasksListScreen.id : (context) {
            // final arguments = ModalRoute.of(context)?.settings.arguments;
            // if (arguments is String) {
            //   return SubtasksListScreen(keyTask: arguments);
            // } else {
            //   return SubtasksListScreen(keyTask: "0");
            // }

            final arguments = ModalRoute.of(context)?.settings.arguments;
             // return SubtasksListScreen(subtaskConfiguration: arguments as SubtaskConfiguration);
              return SubtasksListScreen(taskModel: arguments as TaskModel);

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
