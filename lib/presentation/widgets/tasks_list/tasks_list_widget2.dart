// import 'package:flutter/material.dart';
// import 'package:memofy/data/dataproviders/task_data/task_data_model.dart';
// import 'package:memofy/presentation/screens/subtasks_list/subtasks_list_screen.dart';
// import 'package:memofy/presentation/widgets/task/task_tile_widget.dart';
// import 'package:provider/provider.dart';
//
// class TasksListWidget extends StatelessWidget {
//   TasksListWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     void _onTaskTap(int index) {
//       Navigator.of(context).pushNamed(
//         SubtasksListScreen.id,
//         arguments: index,
//       );
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
//           : ReorderableListView.builder(
//               padding: EdgeInsets.only(top: 70.0),
//               keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//               itemCount: taskData.tasks.length,
//               onReorder: (int oldIndex, int newIndex) {
//                 //final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
//                 // final task = taskData.tasks.removeAt(oldIndex);
//                 // taskData.tasks.insert(index, task);
//
//
//                 print("oldIndex $oldIndex");
//                 final oldIndexTask = taskData.tasks[oldIndex];
//                 print("oldIndexTask: $oldIndexTask");
//
//                 //taskData.getIndexOfHiveOfTask(oldIndexTask);
//
//                 //final newIndexTask = taskData.tasks[newIndex];
//                 //print("newIndexTask $newIndexTask");
//
//                 print("newIndex $newIndex");
//
//                 //--------------
//
//                 final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
//                 //final task = taskData.tasks.removeAt(oldIndex);
//                 //taskData.tasks.insert(index, task);
//                 final oldtask = taskData.tasks.removeAt(oldIndex);
//                 taskData.tasks.insert(index, oldtask);
//                 //--------------
//                 ////final oldtask = taskData.tasks[oldIndex];
//                 print("old task: $oldtask");
//                 print("-OLD: $oldIndex");
//
//                 final newtask = taskData.tasks[index];
//                 print("new task: $newtask");
//                 print("-NEW: $index");
//                 //taskData.tasks;
//                 taskData.getIndexOfHiveOfTask(newtask);
//                 //------------------
//
//
//               },
//               itemBuilder: (BuildContext context, int index) {
//                 final task = taskData.tasks[index];
//                 return TaskTileWidget(
//                   key: ValueKey(task),
//                   task: task,
//                   index: index,
//                   onTaskTap: _onTaskTap,
//                 );
//               },
//             );
//     });
//   }
// }
