import 'package:flutter/material.dart';
import 'package:memofy/data/dataproviders/task_data/task_data.dart';
import 'package:memofy/presentation/screens/subtasks_list/subtasks_list_screen.dart';
import 'package:memofy/presentation/widgets/task/task_tile_widget.dart';
import 'package:provider/provider.dart';

class TasksListWidget extends StatelessWidget {
  int hiveIndexTask = 0;
  TasksListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void _onTaskTap(int index) {
      Navigator.of(context).pushNamed(
        SubtasksListScreen.id,
        arguments: index,
      );
    }

    return Consumer<TaskDataProvider>(builder: (context, taskData, child) {
      return taskData.tasks.isEmpty
          ? Container(
              child: Center(
                child: Text(
                  'No tasks',
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            )
          : ReorderableListView.builder(
              padding: EdgeInsets.only(top: 70.0),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: taskData.tasks.length,
              onReorder: (int oldIndex, int newIndex) async {
                final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
                final task = taskData.tasks.removeAt(oldIndex);
                taskData.tasks.insert(index, task);

                //int oldKey = await taskData.taskKeyAtHive(oldIndex);
                //int key = await taskData.taskKeyAtHive(index);
                
                //taskData.tasksAtKeys(oldKey, key);
                //print(task);
                //print("OLD: $oldIndex");
                //print("NEW: $index");
                // print(taskData.tasks[0]);
                // print(taskData.tasks[1]);
                // print(taskData.tasks[2]);
                // print(taskData.tasks[3]);
              },
              itemBuilder: (BuildContext context, int index) {
                final task = taskData.tasks[index];
                task.orderby = index;
                task.save();
                //int hiveIndexTask = 0;
                //final hiveIndexTask = taskData.hiveKeyTaskbyIndex(index) as int;
                //taskData.hiveKeyTaskbyIndex(index).then((value) {hiveIndexTask = value;});
                return TaskTileWidget(
                  key: ValueKey(task),
                  task: task,
                  index: index,
                  onTaskTap: _onTaskTap,
                );
              },
            );
    });
  }
}
