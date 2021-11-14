import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:memofy/models/subtask/subtask_model.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

// logic
class SubtaskDataProvider extends ChangeNotifier {

  int indexTask = 0;
  TaskModel? _task;

  TaskModel? get task => _task;

  // SubtaskDataProvider({required this.indexTask}) {
  //   load();
  // }

  SubtaskDataProvider() {
    load();
  }

  var _subtasks = <SubtaskModel>[];

  List<SubtaskModel> get subtasks => _subtasks;

  void changedIndex(int index){
    this.indexTask = index;
    notifyListeners();
  }



  _readSubtasksFromHive(Box<SubtaskModel> box) {
    _subtasks = box.values.toList();
    _subtasks.sort((a, b) => a.orderby.compareTo(b.orderby));
    //print(_tasks.toString());
    //print(box.values);

    notifyListeners();
  }

  void loadWithIndex(int indexTask) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskModelAdapter());
    }
    final boxTask = await Hive.openBox<TaskModel>('tasks');
    _task = boxTask.get(indexTask);

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(SubtaskModelAdapter());
    }
    final boxSubtask = await Hive.openBox<SubtaskModel>('subtasks');
    // _tasks = box.values.toList();
    // notifyListeners();
    _readSubtasksFromHive(boxSubtask);
    boxSubtask.listenable().addListener(() => _readSubtasksFromHive(boxSubtask));
  }

  void load() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskModelAdapter());
    }
    final boxTask = await Hive.openBox<TaskModel>('tasks');
    _task = boxTask.get(indexTask);

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(SubtaskModelAdapter());
    }
    final boxSubtask = await Hive.openBox<SubtaskModel>('subtasks');
    // _tasks = box.values.toList();
    // notifyListeners();
    _readSubtasksFromHive(boxSubtask);
    boxSubtask.listenable().addListener(() => _readSubtasksFromHive(boxSubtask));
  }

  void addSubtask(String description) async {

    int l = _subtasks.length;
    final subtask = SubtaskModel(
        description: description, orderby: l + 1, isDone: false);
    //_tasks.add(task);

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(SubtaskModelAdapter());
    }
    final box = await Hive.openBox<SubtaskModel>('subtasks');
    final index = await box.add(subtask);
    print("Added task to index: $index");

    // to update
    notifyListeners();
  }

  void searchTask() {
    notifyListeners();
  }

  void updateSubtask(SubtaskModel subtask) {
    subtask.toggleDone();
    print(subtask.isDone);
    notifyListeners();
  }

  bool toggleSubtaskStatus(SubtaskModel subtask) {
    subtask.toggleDone();
    notifyListeners();
    return subtask.isDone;
  }



  void removeSubtask(SubtaskModel subtask) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(SubtaskModelAdapter());
    }
    final box = await Hive.openBox<SubtaskModel>('subtasks');
    //-------------
    final index = await box.get(subtask);
    print("deleted index: $index");
    subtask.delete();

    notifyListeners();
  }


}
