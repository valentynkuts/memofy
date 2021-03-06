import 'package:flutter/material.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/presentation/widgets/done_tasks/done_tasks_list_widget.dart';
import 'package:memofy/view_models/done_task/done_task_view_model.dart';
import 'package:provider/provider.dart';

class DoneTasksListScreen extends StatefulWidget {
  static const String id = 'done_task_list_screen';

  const DoneTasksListScreen({Key? key}) : super(key: key);

  @override
  _DoneTasksListScreenState createState() => _DoneTasksListScreenState();
}

class _DoneTasksListScreenState extends State<DoneTasksListScreen> {
  final _searchController = TextEditingController(); //todo
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching ? Text('DONE TASKS', style: kTasksStyle,) : searchField(),
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
              print("app bar icon");
            },
          )
        ],
      ),
      body: DoneTasksListWidget(),
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
          Provider.of<DoneTasksViewModel>(context, listen: false)
              .searchTask(query); //todo
        },
      );
}
