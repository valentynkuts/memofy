import 'package:flutter/material.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/presentation/screens/done_tasks/done_tasks_list_screen.dart';
import 'package:memofy/presentation/screens/tasks_list/tasks_list_screen.dart';

class HomePageScreen extends StatefulWidget {
  static const String id = 'Home_screen';

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TasksListScreen(),
      DoneTasksListScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: appBarColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'ToDo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 28),
            label: 'Done',
          ),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }
}
