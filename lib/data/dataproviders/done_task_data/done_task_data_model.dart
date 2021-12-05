import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:memofy/data/dataproviders/box_manager.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';


class DoneTaskDataModel extends ChangeNotifier {

  late final Future<Box<TaskModel>> _box;
  ValueListenable<Object>? _listenableBox;
  String searchingQuery = '';

  DoneTaskDataModel() {
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

  Future<void> _readDoneTasksFromHive() async{
    //_temp = (await _box).values.toList();
   _temp = (await _box).values.where((task) => task.isDone == true).toList();

    //_temp = _temp.where((task) => task.isDone == false).toList();
   if(searchingQuery.isEmpty) {
     _temp.sort((a, b) => a.orderby.compareTo(b.orderby)); ///////
     _doneTasks = _temp;
   }
    notifyListeners();}
  // open box
  void load() async {
    _box = BoxManager().openTaskBox();
    await _readDoneTasksFromHive();
    _listenableBox = (await _box).listenable();
    //_temp = (await _box).values.toList();

    /////(await _box).listenable().addListener(() => _readTasksFromHive());

    _listenableBox?.addListener(() => _readDoneTasksFromHive()); //ok

    //_temp.sort((a, b) => a.orderby.compareTo(b.orderby));
    //_doneTasks = _temp;
  }



  Future<void> addTask(String title, String data, String note) async {
    var uuid = Uuid();
    String key = uuid.v1();
    int l = _doneTasks.length;
    final task = TaskModel(
        title: title, date: data, note: note, orderby: l + 1, id: key, isDone: false);
    (await _box).put(key, task);
    _doneTasks.add(task);
    notifyListeners();
  }

  void searchTask(String query) {
    searchingQuery = query;  ////todo
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
    final taskKey = task.id;
    //delete box with all subtasks
    final subtaskBox = BoxManager().makeSubtaskBoxName(taskKey);
    await Hive.deleteBoxFromDisk(subtaskBox);
    //delete task from db (Hive)
    task.delete();
    //delete task from memory because _listenableBox?.addListener(() => _readTasksFromHive());
    // interferes with search
    _doneTasks.remove(task);

    notifyListeners();
  }

  // close box which was open in load()
  @override
  Future<void> dispose() async{
    
    //_temp.map((task) => task.save());
   // _tasks.map((task) => task.save());
    //await saveOrder();
    _listenableBox?.removeListener(_readDoneTasksFromHive);
    await BoxManager().closeBox((await _box));
    super.dispose();
  }
}
