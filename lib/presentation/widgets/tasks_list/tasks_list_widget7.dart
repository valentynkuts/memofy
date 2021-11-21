// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:memofy/data/dataproviders/subtask_data/subtask_data_model.dart';
// import 'package:memofy/data/dataproviders/task_data/task_data_model.dart';
// import 'package:memofy/models/task/task_model.dart';
// import 'package:memofy/presentation/screens/subtasks_list/subtasks_list_screen.dart';
// import 'package:memofy/presentation/widgets/task/task_tile_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
// class TasksListWidget extends StatelessWidget {
//   int hiveIndexTask = 0;
//   TasksListWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // void _onTaskTap(int index) {
//     //   Navigator.of(context).pushNamed(
//     //     SubtasksListScreen.id,
//     //     arguments: index,
//     //   );
//       void _onTaskTap(TaskModel task) {
//         Navigator.of(context).pushNamed(
//           SubtasksListScreen.id,
//           arguments: task,
//         );
//
//     }
//
//     return Consumer<TaskDataProvider>(builder: (context, taskData, child) {
//       return taskData.tasks.isEmpty
//           ? Container(
//               child: Center(
//                 child: Text(
//                   'No tasks',
//                   style: TextStyle(fontSize: 30.0),
//                 ),
//               ),
//             )
//           : ValueListenableBuilder<Box<TaskModel>>(
//               valueListenable: Hive.box<TaskModel>('tasks1').listenable(),
//               builder: (context, box, _) {
//                 //final tasks = box.values.toList();
//                 return ReorderableListView.builder(
//                   padding: EdgeInsets.only(top: 70.0),
//                   keyboardDismissBehavior:
//                       ScrollViewKeyboardDismissBehavior.onDrag,
//                   itemCount: taskData.tasks.length,
//                   //itemCount: tasks.length,
//                   onReorder: (int oldIndex, int newIndex) async {
//                     final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
//                     final task = taskData.tasks.removeAt(oldIndex);
//                     taskData.tasks.insert(index, task);
//                     //final task = tasks.removeAt(oldIndex);
//                     //tasks.insert(index, task);
//                   },
//                   itemBuilder: (BuildContext context, int index) {
//                     final task = taskData.tasks[index];
//                     //final task = tasks[index];
//                     task.orderby = index;
//                     task.save();
//                     hiveIndexTask = box.keyAt(index);
//                     //Provider.of<SubtaskDataProvider>(context, listen: false).changedIndex(hiveIndexTask);
//                     //print("hiveIndexTask : $hiveIndexTask");
//                     //final hiveIndexTask = taskData.hiveKeyTaskbyIndex(index) as int;
//                     //taskData.hiveKeyTaskbyIndex(index).then((value) => hiveIndexTask = value);
//                     return TaskTileWidget(
//                       key: ValueKey(task),
//                       task: task,
//                       index: hiveIndexTask,
//                       onTaskTap: _onTaskTap,
//                     );
//                   },
//                 );
//               },
//             );
//     });
//   }
// }
