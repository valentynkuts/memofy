import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:memofy/data/dataproviders/task_data/task_data.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:memofy/presentation/screens/subtasks_list/subtasks_list_screen.dart';
import 'package:memofy/presentation/widgets/slidable/item_slidable_widget.dart';
import 'package:provider/provider.dart';

class TaskTileWidget extends StatelessWidget {
  const TaskTileWidget({
    Key? key,
    required this.task,
    required this.index,
    //required this.onTaskTap,
  }) : super(key: key);

  final TaskModel task;//????
  final int index;
  //final Function onTaskTap;



  @override
  Widget build(BuildContext context) {

    Future<int> taskKey(BuildContext context, int index){
      final key = Provider.of<TaskDataProvider>(context, listen: false).hiveKeyTaskbyIndex(index);
      return key;
    }

    void onTaskTap(int index) {
      Navigator.of(context).pushNamed(
        SubtasksListScreen.id,
        arguments: index,
      );
    }

    return slidableTile(context, index, task, onTaskTap, taskKey);
  }

  Widget slidableTile(BuildContext context, int index, TaskModel task, Function onTaskTap, Function taskKey) =>
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
                onTap: () {},
                caption: 'Edit',
                icon: Icons.edit,
              ),
            ),


            // ItemSlidableWidget(
            //   actionName: 'Edit',
            //   icon: Icons.edit,
            //   color: Colors.green,
            //   actionFunction: () {},
            // ),
          ],
          secondaryActions: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: IconSlideAction(
                color: Colors.red, //Colors.green,
                onTap: () {
                  final provider =
                  Provider.of<TaskDataProvider>(context, listen: false);

                  provider.removeTask(task);
                  //provider.removeTask(index);
                 //print("TaskTileWidget index: $index");
                 // print(task);
                },
                caption: 'Delete', //'Edit',
                icon: Icons.delete, //Icons.edit,
              ),
            ),

            // ItemSlidableWidget(
            //   actionName: 'Delete',
            //   icon: Icons.delete,
            //   color: Colors.red,
            //   actionFunction: () {
            //     final provider =
            //         Provider.of<TaskDataProvider>(context, listen: false);
            //
            //     provider.removeTask(task);
            //   },
            // ),
          ],
          //was wrapped by Padding
          child: InkWell(
            // borderRadius: BorderRadius.circular(10.0),
            child: Container(
              //color: Colors.white,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
                  //const
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  // const  Radius.circular(10.0)
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    )
                  ]),
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  //SizedBox(height: 10.0,),
                  ListTile(
                    //key: ValueKey(task),
                    //focusColor: Colors.amber,
                    //tileColor: Colors.red,
                    leading: const Icon(Icons.task),
                    //contentPadding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                    subtitle: Text(
                      task.data,
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
                    // onTap: () => print("ListTile"),
                  ),
                  Text(
                    task.note,
                    style: TextStyle(
                      //fontFamily: 'Pacifico',
                      fontSize: 17.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            //onTap: () => onTaskTap(task),
            onTap: () async{
              final keyTask = await taskKey(context, index);
              onTaskTap(keyTask);
             // onTaskTap(index);
            }
          ),
        ),
      );
}
