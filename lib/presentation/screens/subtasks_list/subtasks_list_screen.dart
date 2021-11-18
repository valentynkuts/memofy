import 'package:flutter/material.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/data/dataproviders/subtask_data/subtask_data.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:memofy/presentation/screens/add_subtask/add_subtask_screen.dart';
import 'package:memofy/presentation/widgets/subtasks_list/subtasks_list_widget.dart';


class SubtasksListScreen extends StatefulWidget {
  static const String id = 'subtasks_list_screen';

  final String keyTask;

  //TaskModel taskModel;



  SubtasksListScreen({Key? key, required this.keyTask}) : super(key: key);
  //SubtasksListScreen({Key? key, required this.taskModel}) : super(key: key);

  @override
  _SubtasksListScreenState createState() => _SubtasksListScreenState();
}

class _SubtasksListScreenState extends State<SubtasksListScreen> {


  //SubtaskDataProvider? _subtaskDataProvider;
  //Provider.of<SubtaskDataProvider>(context).;

  @override
  void initState() {
    // if(_subtaskDataProvider == null){
    //   //_subtaskDataProvider = SubtaskDataProvider(indexTask: widget.index);
    // }
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    // if(_subtaskDataProvider == null){
    //   _subtaskDataProvider = SubtaskDataProvider(indexTask: widget.index);
    // }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('${widget.taskModel.title}'),
        title: Text(widget.keyTask),
       // title: Text(_subtaskDataProvider == null ? "Ooops":'${_subtaskDataProvider!.task!.title}'),
        centerTitle: true,
      ),
      body: Stack(
          children: [
            //SubtasksListWidget(index: widget.index), //TODO
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
                //controller: _searchController,
                onChanged: (query) {
                  //_searchMovies1(query);

                  // if (query.isNotEmpty) {
                  //   _fillteredMovies = _movies.where((Movie movie) {
                  //     return movie.title.toLowerCase().contains(query.toLowerCase());
                  //   }).toList();
                  // } else {
                  //   _fillteredMovies = _movies;
                  // }
                  // print(query);
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
          print("Add subtask");
          Navigator.of(context).pushNamed(AddSubtaskScreen.id);
        },

      ),
    );

  }
}
