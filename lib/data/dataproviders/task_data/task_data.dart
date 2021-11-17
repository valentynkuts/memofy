import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:memofy/models/subtask/subtask_model.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';

// logic
class TaskDataProvider extends ChangeNotifier {

  TaskDataProvider() {
    load();
  }

  var _tasks = <TaskModel>[];

  //final _tasks = <TaskModel>[]; // List.empty()

  // UnmodifiableListView<TaskModel> get tasks{
  //   return UnmodifiableListView(_tasks);
  // }

  List<TaskModel> get tasks {
    return _tasks;
  }

  List<TaskModel> get() {
    return _tasks;
  }

  _readTasksFromHive(Box<TaskModel> box) {
    _tasks = box.values.toList();
    _tasks.sort((a, b) => a.orderby.compareTo(b.orderby));
    //print(_tasks.toString());
    //print(box.values);

    notifyListeners();
  }

  void load() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks2');
    // _tasks = box.values.toList();
    // notifyListeners();
    _readTasksFromHive(box);
    box.listenable().addListener(() => _readTasksFromHive(box));
  }

  void subtaskload(int indexTask) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks2');
    // _tasks = box.values.toList();
    // notifyListeners();
    _readTasksFromHive(box);
    box.listenable().addListener(() => _readTasksFromHive(box));
  }

  void getIndexOfHiveOfTask(TaskModel task) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks2');

    final index = await box.get(task);
    //final index = await box.;
    print("Task at index in Hive: $index");
    notifyListeners();
  }

  Future<int> hiveKeyTaskbyIndex(int index) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks2');

    //screen synchronized with box,
    // knowing index of element of screen we can get index of element of Hive
    final key = await box.keyAt(index);
    //print("hiveKeyTaskbyIndex: $key");

    //print("Task at index $index : key at Hive $key");
    //notifyListeners();
    return key;
  }

  void taskAtIndex(int index) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks2');

    final task = await box.getAt(index);
    //final index = await box.;
    print("Task at index $index in Hive: $task");
    notifyListeners();
  }

  void taskAtKey(int key) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks2');

    final task = await box.get(key);
    //final index = await box.;
    print("Task at key $key in Hive: $task");
    notifyListeners();
  }

  //swap
  void tasksAtKeys(int oldKey, int newKey) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks2');

    var taskOld = await box.get(oldKey);
    print("TaskOld at keyOld $oldKey in Hive: $taskOld");

    var taskNew = await box.get(newKey);
    print("TaskNew at newKey $newKey in Hive: $taskNew");

    /*box.putAt(oldKey, newTask!);
                    box.putAt(keyNew, oldTask!);*/

    // String temp = taskOld!.title;
    var temp =
        TaskModel(title: "title", data: "data", note: "note", id: 0, orderby: 0);
    temp.copy(taskOld!);
    print("taskOld: $taskOld");
    //taskOld.title = taskNew!.title;
    taskOld.copy(taskNew!);
    //box.putAt(oldKey, taskNew!);
    // taskOld!.title = "New title";
    taskOld.save();
    //taskNew.title = temp;
    taskNew.copy(temp);
    print("taskNew: $taskNew");
    //box.putAt(newKey, taskNew);
    taskNew.save();

    notifyListeners();
  }

  // void addTask1(String title, String data, String note, int id) async {
  //   //final task = TaskModel(title: title, data: data, note: note, subtasks: <SubtaskModel>[]);
  //   final task = TaskModel(
  //       title: title, data: data, note: note, orderby: id, isDone: false);
  //   //_tasks.add(task);
  //
  //   if (!Hive.isAdapterRegistered(0)) {
  //     Hive.registerAdapter(TaskModelAdapter());
  //   }
  //   final box = await Hive.openBox<TaskModel>('tasks1');
  //   final index = await box.add(task);
  //   print("Added task to index: $index");
  //
  //   // to update
  //   notifyListeners();
  // }

  void addTask(String title, String data, String note) async {
    //final task = TaskModel(title: title, data: data, note: note, subtasks: <SubtaskModel>[]);
    int l = _tasks.length;
    final task = TaskModel(
        title: title, data: data, note: note, orderby: l + 1, id: 0, isDone: false);
    //_tasks.add(task);

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks2');
    final index = await box.add(task);
    print("Added task to index: $index");
    //TODO
    box.compact();
    TaskModel? taskModel = box.get(index);
    taskModel!.id = index;
    taskModel.save();

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

  void removeTask1(TaskModel task) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks2');

    //await box.deleteAt(index)

    //_tasks.remove(task);
    notifyListeners();
  }

  void removeTask(TaskModel task) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks2');
    //-------------
    final index = await box.get(task);
    print("deleted index: $index");
    //---------
    //await box.deleteAt(index);
    task.delete();

    print("Deleted task: $task");

    //_tasks.remove(task);
    notifyListeners();
  }

  void removeSubtask(int index, SubtaskModel subtask) {
    print(index);
    print(subtask.toString());

    //_tasks[index].subtasks.remove(subtask);
    notifyListeners();
  }
}
