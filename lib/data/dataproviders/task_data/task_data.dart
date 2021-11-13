
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:memofy/models/subtask/subtask_model.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';

// logic
class TaskDataProvider extends ChangeNotifier{
  List<SubtaskModel> subtasks = [
    SubtaskModel(
        description: "Subtask A"),
    SubtaskModel(
        description: "Subtask B"),
    SubtaskModel(
        description: "Subtask C"),
    SubtaskModel(
        description: "Subtask D"),
    SubtaskModel(
        description: "Subtask E"),
    SubtaskModel(
        description: "Subtask F"),
    SubtaskModel(
        description: "Subtask G"),
    SubtaskModel(
        description: "Subtask Q"),
  ];
  /*final _tasks = [
    TaskModel(
        title: 'Making Paiment',
        //data: DateTime.parse('07/16/2021'),
        data: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: 'Text confronts the '
            'darker parts of her ledger when a dangerous conspiracy with ties to '
            'her past arises. Pursued by a force that will stop at nothing to bring'
            ' her down, Natasha must deal with her history as a spy and the broken '
            'relationships left in her wake long before she became an Avenger.',
       isDone:false),
    TaskModel(
        title: 'Go to shop',
       // data:  DateTime.parse('07/16/2021'),
        data:DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: '',),
    TaskModel(
        title: 'To do smth',
        //data:  DateTime.parse('Jun 30, 2021'),
        data:  DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: 'All the rules are broken as a sect of lawless marauders '
            'decides that the annual Purge does not stop at daybreak and instead '
            'should never end as they chase a group of immigrants who they want '
            'to punish because of their harsh historical past.',
        isDone:false),
    TaskModel(
        title: 'Took Baby from ...',
        //data:  DateTime.parse('07/02/2021'),
        data:  DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other. But a new '
            'boss baby with a cutting-edge approach and a can-do attitude is about t'
            'o bring them together again … and inspire a new family business.',
        isDone:false),
    TaskModel(
        title: 'Bhkjhhkjhkjl kopi kjhiuh ',
        //data:  DateTime.parse('07/16/2021'),
        data:  DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.',
        isDone:false),
    TaskModel(
        title: 'Lucauytuyy',
        //data:  DateTime.parse('07/16/2021'),
        data:  DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.',
        isDone:false),
    TaskModel(
        title: 'Awake',
        //data:  DateTime.parse('07/16/2021'),
        data:  DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.',
        isDone:false),
    TaskModel(
        title: 'Infinite',
        //data:  DateTime.parse('07/16/2021'),
        data:  DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.',
        isDone:false),
    TaskModel(
        title: 'Wrauytuyt',
       // data:  DateTime.parse('Apr 22, 2021'),
        data:  DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.',
        isDone:false),
  ];*/

  TaskDataProvider(){
    load();
  }

  var _tasks = <TaskModel>[];

  //final _tasks = <TaskModel>[]; // List.empty()

  // UnmodifiableListView<TaskModel> get tasks{
  //   return UnmodifiableListView(_tasks);
  // }

  List<TaskModel> get tasks{
    return _tasks;
  }

  List<TaskModel> get(){
    return _tasks;
  }

  _readTasksFromHive(Box<TaskModel> box){
    _tasks = box.values.toList();
    _tasks.sort((a,b)=>a.id.compareTo(b.id));
    //print(_tasks.toString());
    //print(box.values);

    notifyListeners();
  }

  void load() async{
    if(!Hive.isAdapterRegistered(0)){
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks');
    // _tasks = box.values.toList();
    // notifyListeners();
    _readTasksFromHive(box);
    box.listenable().addListener(() => _readTasksFromHive(box));
  }


  void getIndexOfHiveOfTask(TaskModel task) async{
    if(!Hive.isAdapterRegistered(0)){
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks');

    final index = await box.get(task);
    //final index = await box.;
    print("Task at index in Hive: $index");
    notifyListeners();
  }

  Future<int> taskKeyAtHive(int index) async{
    if(!Hive.isAdapterRegistered(0)){
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks');

    final key = await box.keyAt(index);
    //final index = await box.;
    print("Task at index $index : key at Hive $key");
    return key;
    notifyListeners();
  }

  void taskAtIndex(int index) async{
    if(!Hive.isAdapterRegistered(0)){
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks');

    final task = await box.getAt(index);
    //final index = await box.;
    print("Task at index $index in Hive: $task");
    notifyListeners();
  }

  void taskAtKey(int key) async{
    if(!Hive.isAdapterRegistered(0)){
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks');

    final task = await box.get(key);
    //final index = await box.;
    print("Task at key $key in Hive: $task");
    notifyListeners();
  }
 //swap
  void tasksAtKeys(int oldKey, int newKey) async{
    if(!Hive.isAdapterRegistered(0)){
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks');

    var taskOld = await box.get(oldKey);
    print("TaskOld at keyOld $oldKey in Hive: $taskOld");

    var taskNew = await box.get(newKey);
    print("TaskNew at newKey $newKey in Hive: $taskNew");

    /*box.putAt(oldKey, newTask!);
                    box.putAt(keyNew, oldTask!);*/

   // String temp = taskOld!.title;
    var temp = TaskModel(title: "title", data: "data", note: "note", id: 0);
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

  void addTask1(String title, String data, String note, int id) async{
    //final task = TaskModel(title: title, data: data, note: note, subtasks: <SubtaskModel>[]);
    final task = TaskModel(title: title, data: data, note: note, id: id, isDone: false);
    //_tasks.add(task);

    if(!Hive.isAdapterRegistered(0)){
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks');
    final index = await box.add(task);
    print("Added task to index: $index");

    // to update
    notifyListeners();
  }

  void addTask(String title, String data, String note) async{
    //final task = TaskModel(title: title, data: data, note: note, subtasks: <SubtaskModel>[]);
    int l = _tasks.length;
    final task = TaskModel(title: title, data: data, note: note, id: l+1, isDone: false);
    //_tasks.add(task);

    if(!Hive.isAdapterRegistered(0)){
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks');
    final index = await box.add(task);
    print("Added task to index: $index");

    // to update
    notifyListeners();
  }

  void searchTask(){
    notifyListeners();
  }

  void updateSubtask(SubtaskModel subtask){
    subtask.toggleDone();
    print(subtask.isDone);
    notifyListeners();
  }

  bool toggleSubtaskStatus(SubtaskModel subtask){
    subtask.toggleDone();
    notifyListeners();
    return subtask.isDone;
  }
 void removeTask1(TaskModel task)async{

   if(!Hive.isAdapterRegistered(1)){
     Hive.registerAdapter(TaskModelAdapter());
   }
   final box = await Hive.openBox<TaskModel>('tasks');

   //await box.deleteAt(index)

    //_tasks.remove(task);
    notifyListeners();
 }

  void removeTask(TaskModel task) async{

    if(!Hive.isAdapterRegistered(0)){
      Hive.registerAdapter(TaskModelAdapter());
    }
    final box = await Hive.openBox<TaskModel>('tasks');
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

  void removeSubtask(int index, SubtaskModel subtask){
    print(index);
    print(subtask.toString());

    //_tasks[index].subtasks.remove(subtask);
    notifyListeners();
  }

}