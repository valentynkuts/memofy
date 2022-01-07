import 'package:flutter/material.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:memofy/presentation/widgets/task/task_tile_widget.dart';
import 'package:memofy/view_models/done_task/done_task_view_model.dart';
import 'package:provider/provider.dart';

class DoneTasksListWidget extends StatelessWidget {
  const DoneTasksListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskModel doneTask;

    return Consumer<DoneTasksViewModel>(
        builder: (context, doneTaskDataModel, child) {
      return doneTaskDataModel.doneTasks.isEmpty
          ? Container(
              child: Center(
                child: Text(
                  'No tasks',
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            )
          : ReorderableListView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: doneTaskDataModel.doneTasks.length,
              onReorder: (int oldIndex, int newIndex) async {
                final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
                doneTask = doneTaskDataModel.doneTasks.removeAt(oldIndex);
                doneTaskDataModel.doneTasks.insert(index, doneTask);
              },
              itemBuilder: (BuildContext context, int index) {
                doneTask = doneTaskDataModel.doneTasks[index];
                if (doneTask.orderby != index &&
                    doneTaskDataModel.searchingQuery.isEmpty) {
                  doneTask.orderby = index;
                  doneTask.save();
                }
                return TaskTileWidget(
                  key: ValueKey(doneTask),
                  task: doneTask,
                );
              },
            );
    });
  }
}
