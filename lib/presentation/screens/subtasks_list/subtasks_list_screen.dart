import 'package:flutter/material.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/presentation/widgets/subtasks_list/subtasks_list_widget.dart';


class SubtasksListScreen extends StatefulWidget {
  static const String id = 'subtasks_list_screen';

  final int index;

  SubtasksListScreen({Key? key, required this.index}) : super(key: key);

  @override
  _SubtasksListScreenState createState() => _SubtasksListScreenState();
}

class _SubtasksListScreenState extends State<SubtasksListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SUBTASKS'),
        centerTitle: true,
      ),
      body: Stack(
          children: [
            SubtasksListWidget(index: widget.index),
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
          //Navigator.of(context).pushNamed(AddSubtaskScreen.id);
        },

      ),
    );

  }
}
