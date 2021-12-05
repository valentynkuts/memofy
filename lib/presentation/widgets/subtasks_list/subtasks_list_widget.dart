import 'package:flutter/material.dart';
import 'package:memofy/data/dataproviders/subtask_data/subtask_data_model.dart';
import 'package:memofy/presentation/widgets/subtask/subtask_tile_widget.dart';
import 'package:provider/provider.dart';

class SubtasksListWidget extends StatefulWidget {

  SubtasksListWidget({Key? key}) : super(key: key);

  @override
  _SubtasksListWidgetState createState() => _SubtasksListWidgetState();
}

class _SubtasksListWidgetState extends State<SubtasksListWidget> {

  @override
  Widget build(BuildContext context) {
    return Consumer<SubtaskDataModel>(builder: (context, subtaskData, child) {
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
              itemCount: subtaskData.subtasks.length,
              onReorder: (int oldIndex, int newIndex) => setState(() {
                final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
                final subtask =
                subtaskData.subtasks.removeAt(oldIndex);
                subtaskData.subtasks.insert(index, subtask);
              }),
              // itemExtent: 163, //height of element
              itemBuilder: (BuildContext context, int index) {
                final subtask = subtaskData.subtasks[index];
                if(subtask.orderby != index){
                  subtask.orderby = index;
                  subtask.save();
                }
                return SubtaskTileWidget(
                  key: ValueKey(subtask),
                  subtask: subtask,
                  subtaskDataModel: subtaskData,
                );

              },
            );
    });
  }
}
