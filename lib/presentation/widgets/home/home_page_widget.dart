import 'package:flutter/material.dart';
import 'package:memofy/presentation/screens/tasks_list/tasks_list_screen.dart';
import 'package:memofy/presentation/widgets/done_tasks/DoneListWidget.dart';

class HomePage extends StatefulWidget {
  static const String id = 'Home_screen';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TasksListScreen(),
      DoneListWidget(),
    ];

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("HOME"),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
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
      // floatingActionButton: FloatingActionButton(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      //   backgroundColor: Colors.black,
      //   onPressed: () => showDialog(
      //     context: context,
      //     builder: (context) => AddTodoDialogWidget(),
      //     barrierDismissible: false,
      //   ),
      //   child: Icon(Icons.add),
      // ),
    );
  }
}


// bottomNavigationBarTheme: BottomNavigationBarThemeData(
// backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
// selectedItemColor: Colors.white,
// unselectedItemColor: Colors.grey,
// ),