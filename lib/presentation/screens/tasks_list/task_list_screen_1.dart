import 'package:flutter/material.dart';
import 'package:memofy/presentation/screens/add_task/add_task_screen.dart';
import 'package:memofy/presentation/widgets/tasks_list/tasks_list_widget.dart';

class TaskListScreen extends StatefulWidget {
  static const String id = 'Main_screen';

  const TaskListScreen({Key? key}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
 /* int _selectedTab = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    Text(
      'News',
    ),
    // Text(
    //   'Index 1: Movies',
    // ),
    TaskListWidget(),
    Text(
      'TV Shows',
    ),
  ];

  void onSelectedTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LISTS'),
        centerTitle: true,
      ),
      body: TasksListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddTaskScreen.id);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
