import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:memofy/data/task_service.dart';
import 'package:memofy/models/task/task_model.dart';

class TasksViewModel extends ChangeNotifier {
  String searchingQuery = '';
  final taskService = TaskService();
  Color tileColor = Color(0xFFFFFFFF);

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

  Future<void> addTask(String title, String data,String dataFrom, String note) async {
    final task = await taskService.addTask(_tasks, title, data, dataFrom, note, tileColor.value);
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
  // true  - ascending  [1 2 3 4]
  // false - descending [4 3 2 1]
  void sortTask(bool order){
    _temp.sort((a, b){
      DateTime dateA = new DateFormat("dd-MM-yyyy hh:mm").parse(a.date);
      DateTime dateB = new DateFormat("dd-MM-yyyy hh:mm").parse(b.date);
      return order ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
    });
    _tasks = _temp;
    notifyListeners();
  }

  //------------
  void sortTaskAsc(){
    _temp.sort((a, b){ //sorting in descending order
      DateTime dateA = new DateFormat("dd-MM-yyyy hh:mm").parse(a.date);
      DateTime dateB = new DateFormat("dd-MM-yyyy hh:mm").parse(b.date);
      return dateA.compareTo(dateB);
    });

    _tasks = _temp;

    for (var i = 0; i < _tasks.length; i++) {
      _tasks[i].orderby = i;
      _tasks[i].save();
    }

    notifyListeners();
  }

  void sortTaskDesc(){
    _temp.sort((a, b){ //sorting in descending order
      DateTime dateA = new DateFormat("dd-MM-yyyy hh:mm").parse(a.date);
      DateTime dateB = new DateFormat("dd-MM-yyyy hh:mm").parse(b.date);
      return dateB.compareTo(dateA);
    });

    _tasks = _temp;

    for (var i = 0; i < _tasks.length; i++) {
      _tasks[i].orderby = i;
      _tasks[i].save();
    }

    notifyListeners();

  }

  //----------

  /*void sortTaskAsc(){
    // var test = <TaskModel>[];
    // test = _temp;
    // test.sort((a, b) => a.date.compareTo(b.date));
    //
    // print(test);
    //------Asc---before---------
    print('----Asc---before---------');
    print(_temp);
    for (final task in _temp) {
      print('orderby - ${task.orderby},  date -  ${task.date}');
    }
    //-----------------------
    _temp.sort((a, b){ //sorting in descending order
      DateTime dateA = new DateFormat("dd-MM-yyyy hh:mm").parse(a.date);
      DateTime dateB = new DateFormat("dd-MM-yyyy hh:mm").parse(b.date);
      return dateA.compareTo(dateB);
    });
    _tasks = _temp;

    //---------after-------------
    print('-----Asc--after---------');
    print(_temp);
    for (final task in _temp) {
      print('orderby - ${task.orderby},  date -  ${task.date}');
    }
    //-----------------------------
    for (var i = 0; i < _tasks.length; i++) {
      _tasks[i].orderby = i;
      _tasks[i].save();
    }
    //---------
    notifyListeners();

    print('----Asc---after-notifyListeners---_tasks------');
    //print(_tasks);
    for (final task in _tasks) {
      print('orderby - ${task.orderby},  date -  ${task.date}');
    }

  }
  void sortTaskDesc(){
    //_temp.sort((b, a) => a.date.compareTo(b.date));
    //------Asc---before---------
    print('----Desc---before---------');
    print(_temp);
    for (final task in _temp) {
      print('orderby - ${task.orderby},  date -  ${task.date}');
    }
    //----------------------
    _temp.sort((a, b){ //sorting in descending order
      DateTime dateA = new DateFormat("dd-MM-yyyy hh:mm").parse(a.date);
      DateTime dateB = new DateFormat("dd-MM-yyyy hh:mm").parse(b.date);
      return dateB.compareTo(dateA);
    });
    _tasks = _temp;
    //print(_temp);

    //---------after-------------
    print('-----Desc--after---------');
    for (final task in _temp) {
      print('orderby - ${task.orderby},  date -  ${task.date}');
      //DateTime dt = DateTime.parse('${task.date}');
      //DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm").parse(task.date);
      //DateTime tempDate = new DateFormat("dd-MM-yyyy hh:mm").parse(task.date);
      //print(tempDate);
    }

    //-------------
    for (var i = 0; i < _tasks.length; i++) {
      _tasks[i].orderby = i;
      _tasks[i].save();
    }
    //-------------
    notifyListeners();
    //-----------
    print('----Desc---after-notifyListeners---_tasks------');
    print(_tasks);
    for (final task in _tasks) {
      print('orderby - ${task.orderby},  date -  ${task.date}');
    }
  }*/

  Future<void> removeTask(TaskModel task) async {
    await taskService.removeTask(task);
    _tasks.remove(task);
    notifyListeners();
  }

  Future<void> updateTask(
      TaskModel task, String newTitle, String newNote, String date, String dateFrom) async {
    await taskService.updateTask(task, newTitle, newNote, date, dateFrom);
    notifyListeners();
  }

  Future<void> updateTaskColor(TaskModel task, int colorValue) async {
    await taskService.updateTaskColor(task, colorValue);
    notifyListeners();
  }

  Future<void> switchTaskNotification(TaskModel task, bool isNotificationOn) async {
    await taskService.switchTaskNotification(task, isNotificationOn);
    notifyListeners();
  }

  Future<void> updateTaskNotificationId(TaskModel task, int notificationId) async {
    await taskService.updateTaskNotificationId(task, notificationId);
    notifyListeners();
  }




  // close box which was open in load()
  @override
  void dispose() async {
    await taskService.close(_readTasksFromHive);
    super.dispose();
  }
}
