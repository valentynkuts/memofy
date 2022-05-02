import 'package:flutter/material.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/notification_api/notification_api.dart';
import 'package:memofy/presentation/screens/add_task/add_task_screen.dart';
import 'package:memofy/presentation/screens/mic_add_task/mic_add_task_screen.dart';
import 'package:memofy/presentation/widgets/tasks_list/tasks_list_widget.dart';
import 'package:memofy/view_models/task/task_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class TasksListScreen extends StatefulWidget {
  static const String id = 'task_list_screen';

  const TasksListScreen({Key? key}) : super(key: key);

  @override
  _TasksListScreenState createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  final _searchController = TextEditingController();
  bool isSearching = false;
  String searchingQuery = '';

  @override
  void initState() {
    super.initState();
    NotificationApi.init();
    //listeNotification();
  }
 // void listeNotification() => NotificationApi.onNotifications.stream.listen(onClickedNotification);
  // void onClickedNotification() => ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching ? Text('TASKS', style: kTasksStyle,) : searchField(),
        actions: <Widget>[
          isSearching
              ? Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isSearching = !isSearching;
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
            },
          ),
        ],
      ),
      body: TasksListWidget(),
      floatingActionButton: SpeedDial(
        shape: RoundedRectangleBorder(
          borderRadius: kBorderRadius,
        ),
        animatedIcon: AnimatedIcons.menu_close,
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
        onChanged: (query) {
          searchingQuery = query;
          Provider.of<TasksViewModel>(context, listen: false)
              .searchTask(searchingQuery); //todo
        },
      );
}
