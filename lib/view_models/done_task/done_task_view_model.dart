import 'package:flutter/foundation.dart';
import 'package:memofy/data/task_service.dart';
import 'package:memofy/models/task/task_model.dart';

class DoneTasksViewModel extends ChangeNotifier {
  String searchingQuery = '';
  final taskService = TaskService();

  DoneTasksViewModel() {
    load();
  }

  var _doneTasks = <TaskModel>[];
  var _temp = <TaskModel>[];

  List<TaskModel> get doneTasks {
    return _doneTasks;
  }

  List<TaskModel> get() {
    return _doneTasks;
  }

  Future<void> _readDoneTasksFromHive() async {
    _temp = await taskService.getTasks();
    _temp = _temp.where((task) => task.isDone == true).toList();
    if (searchingQuery.isEmpty) {
      _temp.sort((a, b) => a.orderby.compareTo(b.orderby)); ///////
      _doneTasks = _temp;
    }
    notifyListeners();
  }

  // open box
  void load() async {
    await taskService.load(_readDoneTasksFromHive);
  }

  void searchTask(String query) {
    searchingQuery = query; ////todo
    print(query);
    if (query.isNotEmpty) {
      _doneTasks = _temp.where((TaskModel task) {
        return task.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _doneTasks = _temp;
    }
    notifyListeners();
  }

  Future<void> removeTask(TaskModel task) async {
    await taskService.removeTask(task);
    _doneTasks.remove(task);

    notifyListeners();
  }

  // close box which was open in load()
  @override
  void dispose() async {
    await taskService.close(_readDoneTasksFromHive);
    super.dispose();
  }
}
