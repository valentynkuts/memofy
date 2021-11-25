import 'package:hive/hive.dart';
//import 'package:memofy/models/subtask/subtask_model.dart';

part 'task_model.g.dart';
//TaskModelAdapter to use TaskModel as type in the Hive

// HiveObject makes easy to use save (update,...), delete
@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String data;

  @HiveField(2)
  String note;

  @HiveField(3)
  bool isDone;

  @HiveField(5)
  int orderby;

  @HiveField(6)
  String id;

  TaskModel(
      {required this.title,
      required this.data,
      required this.note,
      required this.orderby,
      required this.id,
      this.isDone = false});

  @override
  String toString() {
    //return 'TaskModel{title: $title, data: $data, note: $note, isDone: $isDone, subtasks: $subtasks}';
    return 'TaskModel{title: $title, data: $data';
  }

}
