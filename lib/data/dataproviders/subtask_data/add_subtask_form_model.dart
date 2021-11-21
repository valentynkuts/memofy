// import 'package:flutter/cupertino.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:memofy/models/subtask/subtask_model.dart';
// import '../box_manager.dart';
//
//
// class AddSubtaskFormModel extends ChangeNotifier {
//   String taskKey;
//   late final Future<Box<SubtaskModel>> _box;
//   late int _subtaskLength;
//
//   AddSubtaskFormModel({required this.taskKey}) {
//     load();
//   }
//
//   _readSubtasksFromHive() async {
//     _subtaskLength = (await _box).length;
//     notifyListeners();
//   }
//
//   void load() async {
//     _box = BoxManager().openSubtaskBox(taskKey);
//     print("load() -> $taskKey box - $_box");
//
//     await _readSubtasksFromHive();
//     (await _box).listenable().addListener(() => _readSubtasksFromHive());
//   }
//
//   Future<void> addSubtask(String description) async {
//     int l = _subtaskLength;
//     final subtask =
//         SubtaskModel(description: description, orderby: l + 1, isDone: false);
//
//     final box = await _box;
//     final index = await box.add(subtask);
//     print("Added subtask to index: $index, box - $taskKey");//TODO delete
//     notifyListeners();
//   }
// }
