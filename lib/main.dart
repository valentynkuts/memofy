import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memofy/presentation/screens/add_subtask/add_subtask_screen.dart';
import 'package:memofy/presentation/screens/add_task/add_task_screen.dart';
import 'package:memofy/presentation/screens/done_tasks/done_tasks_list_screen.dart';
import 'package:memofy/presentation/screens/edit_task/edit_task_screen.dart';
import 'package:memofy/presentation/screens/home/home_page_screen.dart';
import 'package:memofy/presentation/screens/mic_add_subtask/mic_add_subtask_screen.dart';
import 'package:memofy/presentation/screens/mic_add_task/mic_add_task_screen.dart';
import 'package:memofy/presentation/screens/subtasks_list/subtasks_list_screen.dart';
import 'package:memofy/presentation/screens/tasks_list/tasks_list_screen.dart';
import 'package:memofy/validation/text_validation.dart';
import 'package:memofy/view_models/done_task/done_task_view_model.dart';
import 'package:memofy/view_models/speech/speech_view_model.dart';
import 'package:memofy/view_models/subtask/subtask_view_model.dart';
import 'package:memofy/view_models/task/task_view_model.dart';
import 'package:provider/provider.dart';
import 'models/task/task_model.dart';

void main() async {
  //if main is async we add WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //Initializes Hive with a valid directory in app files.
  await Hive.initFlutter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TasksViewModel>(
          create: (context) => TasksViewModel(),
        ),
        ChangeNotifierProvider<DoneTasksViewModel>(
          create: (context) => DoneTasksViewModel(),
        ),
        ChangeNotifierProvider<TextValidation>(
          create: (context) => TextValidation(),
        ),
        ChangeNotifierProvider<SpeechViewModel>(
          create: (context) => SpeechViewModel(),
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
          TasksListScreen.id: (context) => TasksListScreen(),
          AddTaskScreen.id: (context) => AddTaskScreen(),
          DoneTasksListScreen.id: (context) => DoneTasksListScreen(),
          MicAddTaskScreen.id: (context) => MicAddTaskScreen(),
          SubtasksListScreen.id: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments;
            return SubtasksListScreen(taskModel: arguments as TaskModel);
          },
          AddSubtaskScreen.id: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments;
            return AddSubtaskScreen(
              subtasksViewModel: arguments as SubtasksViewModel,
            );
          },
          MicAddSubtaskScreen.id: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments;
            return MicAddSubtaskScreen(
              subtasksViewModel: arguments as SubtasksViewModel,
            );
          },
          EditTaskScreen.id: (context) {
            final task = ModalRoute.of(context)?.settings.arguments;
            return EditTaskScreen(task: task as TaskModel);
          },
        },
      ),
    );
  }
}
