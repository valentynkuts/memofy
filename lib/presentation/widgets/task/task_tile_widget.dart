import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:memofy/presentation/screens/edit_task/edit_task_screen.dart';
import 'package:memofy/presentation/screens/subtasks_list/subtasks_list_screen.dart';
import 'package:memofy/view_models/task/task_view_model.dart';
import 'package:provider/provider.dart';

class TaskTileWidget extends StatelessWidget {
  final TaskModel task;

  const TaskTileWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onTaskTap(TaskModel task) {
      Navigator.of(context).pushNamed(
        SubtasksListScreen.id,
        arguments: task,
      );
    }

    return slidableTile(context, task, onTaskTap);
  }

  Widget slidableTile(
          BuildContext context, TaskModel task, Function onTaskTap) =>
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Slidable(
          key: ValueKey(task),
          actionPane: SlidableBehindActionPane(),
          actions: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: IconSlideAction(
                color: Colors.green,
                onTap: () => editTask(context),
                caption: 'Edit',
                icon: Icons.edit,
              ),
            ),
          ],
          secondaryActions: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: IconSlideAction(
                color: Colors.red, //Colors.green,
                onTap: () {
                  final provider =
                      Provider.of<TasksViewModel>(context, listen: false);
                  provider.removeTask(task);
                },
                caption: 'Delete', //'Edit',
                icon: Icons.delete, //Icons.edit,
              ),
            ),
          ],
          child: InkWell(
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: task.isDone ? Colors.grey : Colors.white,
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    )
                  ]),
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 5,
                    ),
                    subtitle: Text(
                      task.date,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    dense: true,
                    isThreeLine: true,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      task.note,
                      style: TextStyle(
                        //fontFamily: 'Pacifico',
                        fontSize: 20.0,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 7,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => onTaskTap(task),
          ),
        ),
      );

  void editTask(BuildContext context) => Navigator.of(context).pushNamed(
        EditTaskScreen.id,
        arguments: task,
      );
}
