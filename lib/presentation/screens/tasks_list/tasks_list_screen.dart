import 'package:flutter/material.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/data/dataproviders/task_data/task_data_model.dart';
import 'package:memofy/presentation/screens/add_task/add_task_screen.dart';
import 'package:memofy/presentation/widgets/tasks_list/tasks_list_widget.dart';
import 'package:provider/provider.dart';


class TasksListScreen extends StatefulWidget {
  static const String id = 'Main_screen';

  //final _task;

  const TasksListScreen({Key? key}) : super(key: key);

  @override
  _TasksListScreenState createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {

/*
  List<TaskModel>getTasks(){
    return Provider.of<TaskDataProvider>(context).get();
  }

  var _fillteredTasks = <TaskModel>[];
  final _searchController = TextEditingController();



  void _searchMovies() {
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
  }

  @override
  void initState() {
    super.initState();
    _fillteredTasks = getTasks();
    _searchController.addListener(_searchMovies);
  }*/

  final _searchController = TextEditingController(); //todo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TASK LIST'),
          centerTitle: true,
        ),
        body: Stack(
            children: [
              TasksListWidget(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    filled: true,
                    fillColor: Colors.white.withAlpha(235),
                    border: OutlineInputBorder(
                      borderRadius: kBorderRadius,
                    ),
                  ),
                  controller: _searchController,  //todo
                  onChanged: (query) {
                    Provider.of<TaskDataModel>(context, listen: false).searchTask(query); //todo
                  },
                ),
              )
              ]


        )

        ,
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(AddTaskScreen.id);
          },

        ),
      );

  }
}
