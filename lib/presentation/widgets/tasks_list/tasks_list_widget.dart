import 'package:flutter/material.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/data/dataproviders/task_data/task_data.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:memofy/presentation/widgets/task/task_widget.dart';
import 'package:provider/provider.dart';

class TasksListWidget extends StatefulWidget {
  TasksListWidget({Key? key}) : super(key: key);

  @override
  _TasksListWidgetState createState() => _TasksListWidgetState();
}

class _TasksListWidgetState extends State<TasksListWidget> {
  /*final _tasks = [
    TaskModel(
        title: 'Making Paiment',
        data: ' 07-09-2021',
        note: 'Text confronts the '
            'darker parts of her ledger when a dangerous conspiracy with ties to '
            'her past arises. Pursued by a force that will stop at nothing to bring'
            ' her down, Natasha must deal with her history as a spy and the broken '
            'relationships left in her wake long before she became an Avenger.'),
    TaskModel(
        title: 'Go to shop',
        data: '07/16/2021 ',
        note: 'Content — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
    TaskModel(
        title: 'To do smth',
        data: 'Jun 30, 2021',
        note: 'All the rules are broken as a sect of lawless marauders '
            'decides that the annual Purge does not stop at daybreak and instead '
            'should never end as they chase a group of immigrants who they want '
            'to punish because of their harsh historical past.'),
    TaskModel(
        title: 'Took Baby from ...',
        data: '07/02/2021',
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other. But a new '
            'boss baby with a cutting-edge approach and a can-do attitude is about t'
            'o bring them together again … and inspire a new family business.'),
    TaskModel(
        title: 'Bhkjhhkjhkjl kopi kjhiuh ',
        data: '07/16/2021 ',
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
    TaskModel(
        title: 'Lucauytuyy',
        data: '07/16/2021 ',
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
    TaskModel(
        title: 'Awake',
        data: '07/16/2021 ',
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
    TaskModel(
        title: 'Infinite',
        data: '07/16/2021 ',
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
    TaskModel(
        title: 'Wrauytuyt',
        data: 'Apr 22, 2021',
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
  ];
*/

  /*List<TaskModel>getTasks(){
    return Provider.of<TaskDataProvider>(context).get();
  }

  var _fillteredTasks = <TaskModel>[];
  final _searchController = TextEditingController();*/

  /*void _searchMovies() {
    final query = _searchController.text;
    print(query);
    if (query.isNotEmpty) {
      _fillteredTasks = getTasks().where((TaskModel movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _fillteredTasks = getTasks();
    }
    setState(() {});
  }*/

  /*void _searchMovies1(String query) {
    // final query = _searchController.text;
    print(query);
    if (query.isNotEmpty) {
      _fillteredTasks = _tasks.where((TaskModel movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _fillteredTasks = _tasks;
    }
    //setState(() {});
  }*/

  /*@override
  void initState() {
    super.initState();
    _fillteredTasks = getTasks();
    _searchController.addListener(_searchMovies);
  }*/

// taskData ~ Provider.of<TaskData>(context)
  //   Consumer<TaskData> to get rid of Provider.of<TaskData>(context)  // 206 → 16:50
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskDataProvider>(builder: (context, taskData, child) {
      return taskData.tasks.isEmpty
          ? Container(
              child: Center(
                child: Text(
                  'No tasks',
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(top: 70.0),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              //itemCount: _fillteredTasks.length,
              itemCount: taskData.tasks.length,
              itemExtent: 163, //height of element
              itemBuilder: (BuildContext context, int index) {
                // final task = _fillteredTasks[index];
                return TaskWidget(task: taskData.tasks[index]);
              },
            );
    });
  }
}
