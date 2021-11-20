import 'package:flutter/material.dart';
import 'package:memofy/data/dataproviders/subtask_data/subtask_data.dart';
import 'package:memofy/data/dataproviders/task_data/task_data.dart';
import 'package:memofy/presentation/widgets/subtask/subtask_tile_widget.dart';
import 'package:provider/provider.dart';

class SubtasksListWidget extends StatefulWidget {
  //int index;

  //SubtaskDataProvider subtaskDatamodel;

  //SubtasksListWidget({Key? key, required this.index}) : super(key: key);
  //SubtasksListWidget({Key? key, required this.subtaskDatamodel}) : super(key: key);
  SubtasksListWidget({Key? key}) : super(key: key);

  @override
  _SubtasksListWidgetState createState() => _SubtasksListWidgetState();
}

class _SubtasksListWidgetState extends State<SubtasksListWidget> {
  /*SubtaskDataProvider? _subtaskDataProvider;
  //Provider.of<SubtaskDataProvider>(context).;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // if(_subtaskDataProvider == null){
    //   _subtaskDataProvider = SubtaskDataProvider(indexTask: widget.index);
    // }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Consumer<SubtaskDataProvider>(builder: (context, subtaskData, child) {
      print(subtaskData.subtasks.toString());
      return subtaskData.subtasks.isEmpty
          ? Container(
              child: Center(
                child: Text(
                  'No subtasks',
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            )
          : ReorderableListView.builder(
              padding: EdgeInsets.only(top: 70.0),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              //itemCount: _fillteredTasks.length,
              itemCount: subtaskData.subtasks.length,
              onReorder: (int oldIndex, int newIndex) => setState(() {
                final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
                final subtask =
                subtaskData.subtasks.removeAt(oldIndex);
                subtaskData.subtasks.insert(index, subtask);
              }),
              // itemExtent: 163, //height of element
              itemBuilder: (BuildContext context, int index) {
                //final task = taskData.tasks[widget.index];
                final subtask = subtaskData.subtasks[index];
                return SubtaskTileWidget(
                  key: ValueKey(subtask),
                  subtask: subtask,
                );

              },
            );
    });
  }
}
