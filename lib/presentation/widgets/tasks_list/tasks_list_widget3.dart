// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:memofy/data/dataproviders/task_data/task_data_model.dart';
// import 'package:memofy/models/task/task_model.dart';
// import 'package:memofy/presentation/screens/subtasks_list/subtasks_list_screen.dart';
// import 'package:memofy/presentation/widgets/task/task_tile_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
// class TasksListWidget extends StatelessWidget {
//   TasksListWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
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
//           : ValueListenableBuilder<Box<TaskModel>>(
//               valueListenable: Hive.box<TaskModel>('tasks').listenable(),
//               builder: (context, box, _) {
//                 //final transactions = box.values.toList().cast<TaskModel>();
//                 //final tasks = box.values.toList().cast<TaskModel>();
//                 final tasks = box.values.toList();
//
//                 return ReorderableListView.builder(
//                   padding: EdgeInsets.only(top: 70.0),
//                   keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//                   //itemCount: tasks.length,
//                   itemCount: box.length,
//                   onReorder: (int oldIndex, int newIndex) {
//                     final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
//                     //final task = box.deleteAt(oldIndex) as TaskModel;
//                     //final task = box.getAt(oldIndex) as TaskModel;
//                     //taskData.getIndexOfHiveOfTask(task);
//                     //print(task);
//                     //task.delete();
//                     //print("oldIndex: $oldIndex");
//                     //box.putAt(index, task);
//                     //print("index: $index");
//
//                     print("OLD: $oldIndex");
//                     final oldKey = box.keyAt(oldIndex) as int;
//                    // taskData.taskAtIndex(oldIndex);
//                    // taskData.taskAtKey(oldKey);
//                     print("oldKey: $oldKey");
//                     final oldTask = box.getAt(oldIndex);
//                     print("old task: $oldTask");
//                     //box.getAt(oldIndex)!.delete();
//
//                    // print("OLD: $oldIndex");
//                     //print("T1:$tasks[oldIndex]");
//                     print("NEW: $index");
//                     final keyNew = box.keyAt(index) as int;
//                     //taskData.taskAtIndex(index);
//                     print("keyNew: $keyNew");
//
//                     final newTask = box.getAt(index);
//                     print("new task: $newTask");
//                     //box.getAt(index)!.delete();
//                     //print(tasks[index]);
//                     //print(box.values.toList());
//
//                     taskData.tasksAtKeys(oldKey, keyNew);
//
//                     /*box.putAt(oldKey, newTask!);
//                     box.putAt(keyNew, oldTask!);*/
//
//                     //box.putAt(oldKey, newTask!);
//                     //box.putAt(keyNew, oldTask!);
//
//                     //final task1 = taskData.tasks.removeAt(oldIndex);
//                     //tasks.insert(index, task1);
//                     print("----------------------------");
//                   },
//                   itemBuilder: (BuildContext context, int index) {
//                    // final task = taskData.tasks[index];
//                     final task = box.getAt(index) as TaskModel;
//                     //print(task);
//                     return TaskTileWidget(
//                       key: ValueKey(task),
//                       task: task,
//                       index: index,
//                       onTaskTap: _onTaskTap,
//                     );
//                   },
//                 );
//               },
//             );
//     });
//   }
// }
