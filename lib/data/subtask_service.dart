import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:memofy/models/subtask/subtask_model.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'box_manager.dart';

class SubtaskService{

  //TaskModel taskModel;
  //String taskId;
  late final Future<Box<SubtaskModel>> _box;
  late final Future<Box<TaskModel>> _boxTask;
  ValueListenable<Object>? _listenableBox;

  // Future<Box<TaskModel>> get box{
  //   return _box;
  // }

  // Future<void> load(Function f) async {
  //   _box = BoxManager().openTaskBox();
  //   await f();
  //   _listenableBox = (await _box).listenable();
  //   _listenableBox?.addListener(() => f());
  //
  // }



  Future<void> load(String taskKey, Function f) async {
    //final taskKey = taskModel.id;
    _box = BoxManager().openSubtaskBox(taskKey);
    _boxTask = BoxManager().openTaskBox();

    await f();
    _listenableBox = (await _box).listenable();
    //(await _box).listenable().addListener(() => _readSubtasksFromHive());
    _listenableBox?.addListener(() => f());
  }

  Future<List<SubtaskModel>> getSubtasks() async {
    return (await _box).values.toList();
  }

  Future<void> addSubtask(int subtaskLength,String description) async {
    final subtask = SubtaskModel(
        description: description, orderby: subtaskLength + 1, isDone: false);
    (await _box).add(subtask);

    //notifyListeners();
  }

  Future<void> removeSubtask(SubtaskModel subtask) async {
    subtask.delete();
    //notifyListeners();
  }

  Future<void>  updateSubtask(SubtaskModel subtask, String description) async{
    subtask.description = description;
    subtask.save();
    //notifyListeners();
  }

  Future<void> toggleSubtaskStatus(SubtaskModel subtask) async{
    subtask.toggleDone();
    subtask.save();
    //notifyListeners();
  }

  Future<TaskModel?> getTaskByKey(String key) async {
    return (await _boxTask).get(key);
  }

  Future<void> close(Function f) async{
    _listenableBox?.removeListener(() => f());
    await BoxManager().closeBox((await _box));
    await BoxManager().closeBox((await _boxTask));
  }

}