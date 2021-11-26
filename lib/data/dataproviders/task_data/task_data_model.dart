import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:memofy/data/dataproviders/box_manager.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';


class TaskDataModel extends ChangeNotifier {

  late final Future<Box<TaskModel>> _box;
  ValueListenable<Object>? _listenableBox;

  TaskDataModel() {
    load();
  }

  var _tasks = <TaskModel>[];
  var _temp = <TaskModel>[];

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

  Future<void> _readTasksFromHive() async{
    //(await _box) - waiting for the box to open
    // _tasks = (await _box).values.toList();
    // _tasks.sort((a, b) => a.orderby.compareTo(b.orderby));
    // _temp = _tasks;

    _temp = (await _box).values.toList();
    _temp.sort((a, b) => a.orderby.compareTo(b.orderby));
    _tasks = _temp;
    notifyListeners();
  }
  // open box
  void load() async {
    _box = BoxManager().openTaskBox();
    await _readTasksFromHive();
    _listenableBox = (await _box).listenable();

    /////(await _box).listenable().addListener(() => _readTasksFromHive());

    //_listenableBox?.addListener(() => _readTasksFromHive()); //ok
  }

  Future<int> hiveKeyTaskbyIndex(int index) async {
    final box = await _box;

    //screen synchronized with box,
    // knowing index of element of screen we can get index of element of Hive
    final key = await box.keyAt(index);
    return key;
  }

  Future<void> addTask(String title, String data, String note) async {
    var uuid = Uuid();
    String key = uuid.v1();
    //print(key);
    int l = _tasks.length;
    final task = TaskModel(
        title: title, data: data, note: note, orderby: l + 1, id: key, isDone: false);
    //print(task.id);
    // final box = await _box;
    // box.put(key, task);

    (await _box).put(key, task);

    _tasks.add(task);
    //await BoxManager().closeBox(box); //TODO delete
    notifyListeners();
  }

  void searchTask(String query) {
    print(query);
    if (query.isNotEmpty) {
      _tasks = _temp.where((TaskModel task) {
        return task.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
      print("1- $_tasks");
    } else {
      _tasks = _temp;
     // _tasks.map((task) => task.save());
      print("2 - $_tasks");
    }
    notifyListeners();
  }
 // TODO
  Future<void> saveOrder()async{
     _temp.map((task) => task.save());
  }


  Future<void> removeTask(TaskModel task) async {

    //final box = await _box;

    final taskKey = task.id;
    //delete box with all subtasks
    final subtaskBox = BoxManager().makeSubtaskBoxName(taskKey);
    await Hive.deleteBoxFromDisk(subtaskBox);
    //delete task from db (Hive)
    task.delete();
    //delete task from memory because _listenableBox?.addListener(() => _readTasksFromHive());
    // interferes with search
    _tasks.remove(task);

    notifyListeners();
  }

  // @override
  // void dispose() async{
  //   _listenableBox?.removeListener(_readTasksFromHive);
  //   await BoxManager().closeBox((await _box));
  //   super.dispose();
  // }

  // close box which was open in load()
  @override
  Future<void> dispose() async{
    
    //_temp.map((task) => task.save());
   // _tasks.map((task) => task.save());
    //await saveOrder();
    _listenableBox?.removeListener(_readTasksFromHive);
    await BoxManager().closeBox((await _box));
    super.dispose();
  }
}
