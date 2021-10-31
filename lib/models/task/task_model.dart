import 'package:memofy/models/subtask/subtask_model.dart';

class TaskModel {
  //String id;
  final String title;
  final String data;
  //final DateTime data;
  final String note;
  //bool isDone;

  final List<SubtaskModel> subtasks;

  TaskModel(
      {required this.title,
        required this.data,
        required this.note,
        required this.subtasks,
      });

}