import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:memofy/models/subtask/subtask_model.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'box_manager.dart';

class SubtaskService {
  late final Future<Box<SubtaskModel>> _box;
  late final Future<Box<TaskModel>> _boxTask;
  ValueListenable<Object>? _listenableBox;

  Future<void> load(String taskKey, Function f) async {
    _box = BoxManager().openSubtaskBox(taskKey);
    _boxTask = BoxManager().openTaskBox();

    await f();
    _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(() => f());
  }

  Future<List<SubtaskModel>> getSubtasks() async {
    return (await _box).values.toList();
  }

  Future<void> addSubtask(int subtaskLength, String description) async {
    final subtask = SubtaskModel(
        description: description, orderby: subtaskLength + 1, isDone: false);
    (await _box).add(subtask);
  }

  Future<void> removeSubtask(SubtaskModel subtask) async {
    subtask.delete();
  }

  Future<void> updateSubtask(SubtaskModel subtask, String description) async {
    subtask.description = description;
    subtask.save();
  }

  Future<void> toggleSubtaskStatus(SubtaskModel subtask) async {
    subtask.toggleDone();
    subtask.save();
  }

  Future<TaskModel?> getTaskByKey(String key) async {
    return (await _boxTask).get(key);
  }

  Future<void> close(Function f) async {
    _listenableBox?.removeListener(() => f());
    await BoxManager().closeBox((await _box));
    await BoxManager().closeBox((await _boxTask));
  }
}
