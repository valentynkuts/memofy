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
    return Consumer<SubtasksViewModel>(builder: (context, subtasksViewModel, child) {
      return subtasksViewModel.subtasks.isEmpty
          ? Container(
              child: Center(
                child: Text(
                  'No subtasks',
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            )
          : ReorderableListView.builder(
              padding: EdgeInsets.only(top: 75.0),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: subtasksViewModel.subtasks.length,
              onReorder: (int oldIndex, int newIndex) => setState(() {
                final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
                final subtask = subtasksViewModel.subtasks.removeAt(oldIndex);
                subtasksViewModel.subtasks.insert(index, subtask);
              }),
              itemBuilder: (BuildContext context, int index) {
                final subtask = subtasksViewModel.subtasks[index];
                if (subtask.orderby != index) {
                  subtask.orderby = index;
                  subtask.save();
                }
                return SubtaskTileWidget(
                  key: ValueKey(subtask),
                  subtask: subtask,
                  subtasksViewModel: subtasksViewModel,
                );
              },
            );
    });
  }
}
