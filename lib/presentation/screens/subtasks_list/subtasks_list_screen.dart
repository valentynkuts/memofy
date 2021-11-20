import 'package:flutter/material.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/data/dataproviders/subtask_configuration.dart';
import 'package:memofy/data/dataproviders/subtask_data/subtask_data.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:memofy/presentation/screens/add_subtask/add_subtask_screen.dart';
import 'package:memofy/presentation/widgets/subtasks_list/subtasks_list_widget.dart';
import 'package:provider/provider.dart';

class SubtasksListScreenConfig{

  final SubtaskConfiguration subtaskConfiguration;
  final SubtaskDataProvider? subtaskDataProvider;

  SubtasksListScreenConfig({required this.subtaskDataProvider, required this.subtaskConfiguration});


}

class SubtasksListScreen extends StatefulWidget {
  static const String id = 'subtasks_list_screen';

  //final String keyTask;
  SubtaskConfiguration subtaskConfiguration;

  //TaskModel taskModel;



  SubtasksListScreen({Key? key, required this.subtaskConfiguration}) : super(key: key);
  //SubtasksListScreen({Key? key, required this.taskModel}) : super(key: key);

  @override
  _SubtasksListScreenState createState() => _SubtasksListScreenState();
}

class _SubtasksListScreenState extends State<SubtasksListScreen> {


 // final model = SubtaskDataProvider(subtaskConfiguration: widget.subtaskConfiguration);
  SubtaskDataProvider? _subtaskDatamodel;
  //Provider.of<SubtaskDataProvider>(context).;


  @override
  void initState() {
    if(_subtaskDatamodel == null){
      _subtaskDatamodel = SubtaskDataProvider(subtaskConfiguration: widget.subtaskConfiguration);
    }
    super.initState();
  }
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //
  //   // if(_subtaskDataProvider == null){
  //   //   _subtaskDataProvider = SubtaskDataProvider(indexTask: widget.index);
  //   // }
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {

   // final title = widget.subtaskConfiguration.titleTask ?? 'Subtasks';
    final title = widget.subtaskConfiguration.titleTask;
    //return ChangeNotifierProvider(
    return ChangeNotifierProvider(
      create: (context) => _subtaskDatamodel,
      //create: (context) => _subtaskDataProvider,
      child: Scaffold(
            appBar: AppBar(
              //title: Text('${widget.taskModel.title}'),
              title: Text(title),
             // title: Text(_subtaskDataProvider == null ? "Ooops":'${_subtaskDataProvider!.task!.title}'),
              centerTitle: true,
            ),
            body: Stack(
                children: [
                  SubtasksListWidget(), //TODO
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
               // Navigator.of(context).pushNamed(AddSubtaskScreen.id);
                //final keyTask = widget.subtaskConfiguration.taskKey;
                final subtaskConf = widget.subtaskConfiguration;
                final subtaskListConf = SubtasksListScreenConfig(subtaskConfiguration: subtaskConf, subtaskDataProvider: _subtaskDatamodel);
                Navigator.of(context).pushNamed(
                    AddSubtaskScreen.id,
                    arguments: subtaskListConf,);

                //context.watch<Example>()
              },

            ),
          ),

    );

  }
}
