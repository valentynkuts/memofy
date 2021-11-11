import 'package:hive/hive.dart';
import 'package:memofy/models/subtask/subtask_model.dart';

part 'task_model.g.dart';

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

  @HiveField(4)
  HiveList<SubtaskModel>? subtasks;

  //TaskModel(this.title,this.data,this.note,this.isDone);
  TaskModel({required this.title,
    required this.data,
    required this.note,
    this.isDone = false});

  // TaskModel({required this.title,
  //   required this.data,
  //   required this.note,
  //   this.isDone = false, HiveList<SubtaskModel>? subtasks});
}
