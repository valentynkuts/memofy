import 'package:flutter/material.dart';
import 'package:memofy/data/dataproviders/task_data/task_data_model.dart';
import 'package:memofy/presentation/widgets/task/task_tile_widget.dart';
import 'package:provider/provider.dart';

class TasksListWidget extends StatelessWidget {

  TasksListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<TaskDataModel>(builder: (context, taskDataModel, child) {
      return taskDataModel.tasks.isEmpty
          ? Container(
              child: Center(
                child: Text(
                  'No tasks',
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            )
          : ReorderableListView.builder(
             // padding: EdgeInsets.only(top: 70.0),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: taskDataModel.tasks.length,
              onReorder: (int oldIndex, int newIndex) async {
                final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
                final task = taskDataModel.tasks.removeAt(oldIndex);
                taskDataModel.tasks.insert(index, task);
              },
              itemBuilder: (BuildContext context, int index) {
                final task = taskDataModel.tasks[index];
                 if(task.orderby != index && taskDataModel.searchingQuery.isEmpty){
                  task.orderby = index;
                  task.save();
                } 
                return TaskTileWidget(
                  key: ValueKey(task),
                  task: task,
                );
              },
            );
    });
  }
}
