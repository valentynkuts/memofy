import 'package:hive/hive.dart';
import 'package:memofy/models/subtask/subtask_model.dart';

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

  @HiveField(4)
  HiveList<SubtaskModel>? subtasks;

  @HiveField(5)
  int orderby;

  //TaskModel(this.title,this.data,this.note,this.isDone);
  TaskModel(
      {required this.title,
      required this.data,
      required this.note,
      required this.orderby,
      this.isDone = false});

// TaskModel({required this.title,
  //   required this.data,
  //   required this.note,
  //   this.isDone = false, HiveList<SubtaskModel>? subtasks});

  @override
  String toString() {
    //return 'TaskModel{title: $title, data: $data, note: $note, isDone: $isDone, subtasks: $subtasks}';
    return 'TaskModel{title: $title, data: $data';
  }

  void copy(TaskModel t) {
    this.title = t.title;
    this.data = t.data;
    this.note = t.note;
    this.isDone = t.isDone;
  }

  void addSubtask(Box<TaskModel>box, SubtaskModel subtask) {
    subtasks ??= HiveList(box);
    subtasks?.add(subtask);
  }


}
