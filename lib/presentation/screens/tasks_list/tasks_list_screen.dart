import 'package:flutter/material.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/data/dataproviders/task_data/task_data_model.dart';
import 'package:memofy/presentation/screens/add_task/add_task_screen.dart';
import 'package:memofy/presentation/widgets/tasks_list/tasks_list_widget.dart';
import 'package:provider/provider.dart';

class TasksListScreen extends StatefulWidget {
  static const String id = 'Main_screen';

  const TasksListScreen({Key? key}) : super(key: key);

  @override
  _TasksListScreenState createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  final _searchController = TextEditingController(); //todo
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching ? Text('TASK LIST') : searchField(),
        //centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSearching = !isSearching;
                  });
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            tooltip: 'Filter',
            onPressed: () {
              // do something
              print("app bar icon");
            },
          )
        ],
      ),
      body: TasksListWidget(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddTaskScreen.id);
        },
      ),
    );
  }

  Widget searchField() => TextField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        controller: _searchController,
        //todo
        onChanged: (query) {
          Provider.of<TaskDataModel>(context, listen: false)
              .searchTask(query); //todo
        },
      );
}
