
import 'package:flutter/foundation.dart';
import 'package:memofy/models/subtask/subtask_model.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:intl/intl.dart';

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
  final _tasks = [
    TaskModel(
        title: 'Making Paiment',
        //data: DateTime.parse('07/16/2021'),
        data: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: 'Text confronts the '
            'darker parts of her ledger when a dangerous conspiracy with ties to '
            'her past arises. Pursued by a force that will stop at nothing to bring'
            ' her down, Natasha must deal with her history as a spy and the broken '
            'relationships left in her wake long before she became an Avenger.',
        subtasks:  [
          SubtaskModel(
              description: "1_Subtask A darker parts of her ledger when a dangerous"),
          SubtaskModel(
              description: "1_Subtask B"),
          SubtaskModel(
              description: "1_Subtask C darker parts of her ledger when a dangerous, darker parts of her ledger when a dangerous"),
          SubtaskModel(
              description: "1_Subtask D"),
          SubtaskModel(
              description: "1_Subtask E"),
          SubtaskModel(
              description: "1_Subtask F"),
          SubtaskModel(
              description: "1_Subtask G"),
          SubtaskModel(
              description: "1_Subtask W"),
          SubtaskModel(
              description: "1_Subtask H"),
          SubtaskModel(
              description: "1_Subtask J"),
          SubtaskModel(
              description: "1_Subtask K"),
          SubtaskModel(
              description: "1_Subtask L"),
          SubtaskModel(
              description: "1_Subtask M"),
          SubtaskModel(
              description: "1_Subtask X"),
        ]),
    TaskModel(
        title: 'Go to shop',
       // data:  DateTime.parse('07/16/2021'),
        data:DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: '',
         subtasks: <SubtaskModel>[]),
    TaskModel(
        title: 'To do smth',
        //data:  DateTime.parse('Jun 30, 2021'),
        data:  DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: 'All the rules are broken as a sect of lawless marauders '
            'decides that the annual Purge does not stop at daybreak and instead '
            'should never end as they chase a group of immigrants who they want '
            'to punish because of their harsh historical past.',
        subtasks:  [
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
        ]),
    TaskModel(
        title: 'Took Baby from ...',
        //data:  DateTime.parse('07/02/2021'),
        data:  DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other. But a new '
            'boss baby with a cutting-edge approach and a can-do attitude is about t'
            'o bring them together again … and inspire a new family business.',
        subtasks: <SubtaskModel>[]),
    TaskModel(
        title: 'Bhkjhhkjhkjl kopi kjhiuh ',
        //data:  DateTime.parse('07/16/2021'),
        data:  DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.',
        subtasks: <SubtaskModel>[]),
    TaskModel(
        title: 'Lucauytuyy',
        //data:  DateTime.parse('07/16/2021'),
        data:  DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.',
        subtasks: <SubtaskModel>[]),
    TaskModel(
        title: 'Awake',
        //data:  DateTime.parse('07/16/2021'),
        data:  DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.',
        subtasks: <SubtaskModel>[]),
    TaskModel(
        title: 'Infinite',
        //data:  DateTime.parse('07/16/2021'),
        data:  DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.',
        subtasks: <SubtaskModel>[]),
    TaskModel(
        title: 'Wrauytuyt',
       // data:  DateTime.parse('Apr 22, 2021'),
        data:  DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.',
        subtasks: <SubtaskModel>[]),
  ];

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

  void addTask(String title, String data, String note){
    final task = TaskModel(title: title, data: data, note: note, subtasks: <SubtaskModel>[]);
    _tasks.add(task);
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

  bool updateSubtask1(SubtaskModel subtask){
    subtask.toggleDone();
    notifyListeners();
    return subtask.isDone;
  }


  void deleteSubtask(TaskModel task, SubtaskModel subtask){
    task.subtasks.remove(subtask);
    notifyListeners();
  }

}