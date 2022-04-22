import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'box_manager.dart';

class TaskService{

  late final Future<Box<TaskModel>> _box;
  ValueListenable<Object>? _listenableBox;

  Future<Box<TaskModel>> get box{
    return _box;
  }

  Future<void> load(Function f) async {
    _box = BoxManager().openTaskBox();
    await f();
    _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(() => f());

  }

  Future<TaskModel?> getTaskByKey(String key) async {
    return (await _box).get(key);
  }

  Future<List<TaskModel>> getTasks() async {
    return (await _box).values.toList();
  }

  Future<TaskModel> addTask(List tasks, String title, String data, String note, int colorValue) async {
    var uuid = Uuid();
    String key = uuid.v1();
    int l = tasks.length;
    final task = TaskModel(
        title: title, date: data, note: note, orderby: l + 1, id: key, colorValue: colorValue, isDone: false);
    (await _box).put(key, task);

    return task;
  }

  Future<void> removeTask(TaskModel task) async {
    final taskKey = task.id;
    //delete box with all subtasks
    final subtaskBox = BoxManager().makeSubtaskBoxName(taskKey);
    await Hive.deleteBoxFromDisk(subtaskBox);
    //delete task from db (Hive)
    task.delete();
  }

  Future<void> updateTask(TaskModel task, String newTitle, String newNote, String date) async {
    task.title = newTitle;
    task.note = newNote;
    task.date = date;
    task.save();

  }

  Future<void> updateTaskColor(TaskModel task, int colorValue) async {
    task.colorValue = colorValue;
    task.save();
  }

  Future<void> close(Function f) async{
    _listenableBox?.removeListener(() => f());
    await BoxManager().closeBox((await _box));
  }

}