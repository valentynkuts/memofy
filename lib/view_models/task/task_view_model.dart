import 'package:flutter/foundation.dart';
import 'package:memofy/data/task_service.dart';
import 'package:memofy/models/task/task_model.dart';

class TasksViewModel extends ChangeNotifier {
  String searchingQuery = '';
  final taskService = TaskService();

  TasksViewModel() {
    load();
  }

  var _tasks = <TaskModel>[];
  var _temp = <TaskModel>[];

  List<TaskModel> get tasks {
    return _tasks;
  }

  List<TaskModel> get() {
    return _tasks;
  }

  Future<void> _readTasksFromHive() async {
    _temp = (await taskService.box)
        .values
        .where((task) => task.isDone == false)
        .toList();

    if (searchingQuery.isEmpty) {
      _temp.sort((a, b) => a.orderby.compareTo(b.orderby));
      _tasks = _temp;
    }
    notifyListeners();
  }

  Future<void> load() async {
    await taskService.load(_readTasksFromHive);
  }

  Future<void> addTask(String title, String data, String note) async {
    final task = await taskService.addTask(_tasks, title, data, note);
    _tasks.add(task);
    notifyListeners();
  }

  void searchTask(String query) {
    searchingQuery = query;
    if (query.isNotEmpty) {
      _tasks = _temp.where((TaskModel task) {
        return task.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _tasks = _temp;
    }
    notifyListeners();
  }

  Future<void> removeTask(TaskModel task) async {
    await taskService.removeTask(task);
    _tasks.remove(task);
    notifyListeners();
  }

  Future<void> updateTask(
      TaskModel task, String newTitle, String newNote, String date) async {
    await taskService.updateTask(task, newTitle, newNote, date);
    notifyListeners();
  }

  // close box which was open in load()
  @override
  void dispose() async {
    await taskService.close(_readTasksFromHive);
    super.dispose();
  }
}
