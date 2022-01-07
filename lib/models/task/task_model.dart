import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String date;

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
      required this.date,
      required this.note,
      required this.orderby,
      required this.id,
      this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }

  @override
  String toString() {
    //return 'TaskModel{title: $title, data: $data, note: $note, isDone: $isDone, subtasks: $subtasks}';
    return 'TaskModel{title: $title, data: $date';
  }

}
