
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memofy/data/dataproviders/subtask_configuration.dart';
import 'package:memofy/data/dataproviders/subtask_data/subtask_data_model.dart';
import 'package:memofy/presentation/screens/add_subtask/add_subtask_screen.dart';
import 'package:memofy/presentation/screens/add_task/add_task_screen.dart';
import 'package:memofy/presentation/screens/done_tasks/done_tasks_list_screen.dart';
import 'package:memofy/presentation/screens/edit_task/edit_task_screen.dart';
import 'package:memofy/presentation/screens/home/home_page_screen.dart';
import 'package:memofy/presentation/screens/mic_add_task/mic_add_task_screen.dart';
import 'package:memofy/presentation/screens/subtasks_list/subtasks_list_screen.dart';
import 'package:memofy/presentation/screens/tasks_list/tasks_list_screen.dart';
import 'package:memofy/validation/add_task_validation.dart';
import 'package:provider/provider.dart';
import 'data/dataproviders/done_task_data/done_task_data_model.dart';
import 'data/dataproviders/task_data/task_data_model.dart';
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
//https://docs.hivedb.dev/#/advanced/compaction

/*
// problem
//task.save();  //TODO не сохраняет порядок
task.save();  // TODO не дает искать
 */

void main() async{
  //if main is async we add WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  //WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //Initializes Hive with a valid directory in your app files.
  await Hive.initFlutter();

  /*// box tasks1 tasks2 ////TODO tasks
  Hive.registerAdapter(TaskModelAdapter());

  var b2 = await Hive.openBox<TaskModel>('tasks'); // TODO
  await b2.deleteFromDisk();*/

  runApp(MyApp());
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
        ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
          ),
        ),
        initialRoute: HomePageScreen.id,
        routes: {
          //'/auth': (context) => Auth(),
          HomePageScreen.id: (context) => HomePageScreen(),
          TasksListScreen.id : (context) => TasksListScreen(),
          AddTaskScreen.id : (context) => AddTaskScreen(),
          DoneTasksListScreen.id : (context) => DoneTasksListScreen(),
          MicAddTaskScreen.id : (context) => MicAddTaskScreen(),
          SubtasksListScreen.id : (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments;
              return SubtasksListScreen(taskModel: arguments as TaskModel);
          },
          AddSubtaskScreen.id : (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments;
            return AddSubtaskScreen(subtaskDataProvider: arguments as SubtaskDataModel,);
          },
          EditTaskScreen.id : (context) {
            final task = ModalRoute.of(context)?.settings.arguments;
           return EditTaskScreen(task: task as TaskModel);
          },
        },
      ),
    );
  }
}
