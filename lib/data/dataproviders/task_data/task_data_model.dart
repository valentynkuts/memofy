import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:memofy/data/dataproviders/box_manager.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';


class TaskDataModel extends ChangeNotifier {

  late final Future<Box<TaskModel>> _box;
  ValueListenable<Object>? _listenableBox;
  String searchingQuery = '';
  String date = '';

  TaskDataModel() {
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

  Future<void> _readTasksFromHive() async{
    //_temp = (await _box).values.toList();
   _temp = (await _box).values.where((task) => task.isDone == false).toList();

    //_temp = _temp.where((task) => task.isDone == false).toList();
   if(searchingQuery.isEmpty) {
     _temp.sort((a, b) => a.orderby.compareTo(b.orderby)); ///////
     _tasks = _temp;
   }
    notifyListeners();
  }
  // open box
  void load() async {
    _box = BoxManager().openTaskBox();
    await _readTasksFromHive();
    _listenableBox = (await _box).listenable();

    //_temp = (await _box).values.where((task) => task.isDone == false).toList();

    _listenableBox?.addListener(() => _readTasksFromHive()); //ok

    //_temp.sort((a, b) => a.orderby.compareTo(b.orderby));
    //_tasks = _temp;
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
    int l = _tasks.length;
    final task = TaskModel(
        title: title, date: data, note: note, orderby: l + 1, id: key, isDone: false);
    (await _box).put(key, task);
    _tasks.add(task);

    notifyListeners();
  }

  void searchTask(String query) {
    searchingQuery = query;
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
     //_temp.map((task) => task.save());
     for (final task in _tasks) {
       task.save();
     }
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

  Future<void> updateTask(TaskModel task, String newTitle, String newNote, String date) async {
    task.title = newTitle;
    task.note = newNote;
    task.date = date;
    task.save();

    notifyListeners();
  }

  void updateDate1(String date){
    this.date = date;
    notifyListeners();
  }

  String updateDate(String date){
    this.date = date;
    notifyListeners();
    return date;
  }



  // close box which was open in load()
  @override
  Future<void> dispose() async{
    await saveOrder(); //todo

    _listenableBox?.removeListener(_readTasksFromHive);
    await BoxManager().closeBox((await _box));
    super.dispose();
  }
}
