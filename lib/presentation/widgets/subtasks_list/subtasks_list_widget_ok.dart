/*
import 'package:flutter/material.dart';
import 'package:memofy/data/dataproviders/task_data/task_data_model.dart';
import 'package:memofy/presentation/widgets/subtask/subtask_tile_widget.dart';
import 'package:provider/provider.dart';

class SubtasksListWidget extends StatefulWidget {
  int index;

  SubtasksListWidget({Key? key, required this.index}) : super(key: key);

  @override
  _SubtasksListWidgetState createState() => _SubtasksListWidgetState();
}

class _SubtasksListWidgetState extends State<SubtasksListWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskDataProvider>(builder: (context, taskData, child) {
      return taskData.tasks[widget.index].subtasks.isEmpty
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
              itemCount: taskData.tasks[widget.index].subtasks.length,
              onReorder: (int oldIndex, int newIndex) => setState(() {
                final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
                final subtask =
                    taskData.tasks[widget.index].subtasks.removeAt(oldIndex);
                taskData.tasks[widget.index].subtasks.insert(index, subtask);
              }),
              // itemExtent: 163, //height of element
              itemBuilder: (BuildContext context, int index) {
                //final task = taskData.tasks[widget.index];
                final subtask = taskData.tasks[widget.index].subtasks[index];
                return SubtaskTileWidget(
                  key: ValueKey(subtask),
                  subtask: subtask,
                  index: index,
                  //isChecked: subtask.isDone,
                  checkboxCallback: (checkBoxState) {
                    taskData.updateSubtask(subtask);
                  },
                  longPressCallback: () {},
                );

              },
            );
    });
  }
}
*/
