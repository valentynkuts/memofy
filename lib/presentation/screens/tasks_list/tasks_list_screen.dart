import 'package:flutter/material.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/data/dataproviders/task_data/task_data_model.dart';
import 'package:memofy/presentation/screens/add_task/add_task_screen.dart';
import 'package:memofy/presentation/screens/mic_add_task/mic_add_task_screen.dart';
import 'package:memofy/presentation/widgets/tasks_list/tasks_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:expandable_text/expandable_text.dart';

class TasksListScreen extends StatefulWidget {
  static const String id = 'task_list_screen';

  const TasksListScreen({Key? key}) : super(key: key);

  @override
  _TasksListScreenState createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  final _searchController = TextEditingController(); //todo
  bool isSearching = false;
  String searchingQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching ? Text('TASK LIST') : searchField(),
        actions: <Widget>[
          isSearching
              ? Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isSearching = !isSearching;
                        //searchingQuery = '';
                        //Provider.of<TaskDataModel>(context, listen: false).searchingQuery = '';
                        //print(searchingQuery);
                      });
                    },
                    child: Icon(
                      Icons.cancel,
                      size: 26.0,
                    ),
                  ))
              : Padding(
                  padding: EdgeInsets.only(right: 15.0),
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
      // floatingActionButton: FloatingActionButton(
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      //   backgroundColor: Colors.green,
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.of(context).pushNamed(AddTaskScreen.id);
      //   },
      // ),
      floatingActionButton: SpeedDial(
        shape: RoundedRectangleBorder(
          borderRadius: kBorderRadius,
        ),
        animatedIcon: AnimatedIcons.menu_close,
        //animatedIconTheme: IconThemeData(size: 38.0),
        //icon: Icons.share,
        backgroundColor: Colors.grey,
        overlayColor: Colors.grey,
        overlayOpacity: 0.4,
        spacing: 12,
        spaceBetweenChildren: 12,
        children: [
          SpeedDialChild(
            labelStyle: TextStyle(fontSize: 18.0),
            shape: RoundedRectangleBorder(
              borderRadius: kBorderRadius,
            ),
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            label: 'Add task',
            onTap: () => Navigator.of(context).pushNamed(AddTaskScreen.id),
          ),
          SpeedDialChild(
            labelStyle: TextStyle(fontSize: 18.0),
            shape: RoundedRectangleBorder(
              borderRadius: kBorderRadius,
            ),
            child: Icon(Icons.mic),
            backgroundColor: Colors.amber,
            label: 'Add task by voice',
            onTap: () => Navigator.of(context).pushNamed(MicAddTaskScreen.id),
          ),
        ],
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
        ),
        controller: _searchController,
        //todo
        onChanged: (query) {
          searchingQuery = query;
          Provider.of<TasksViewModel>(context, listen: false)
              .searchTask(searchingQuery); //todo
        },
      );
}
