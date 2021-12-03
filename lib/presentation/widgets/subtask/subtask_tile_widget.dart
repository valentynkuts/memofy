import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:memofy/data/dataproviders/subtask_data/subtask_data_model.dart';
import 'package:memofy/data/dataproviders/task_data/task_data_model.dart';
import 'package:memofy/models/subtask/subtask_model.dart';
import 'package:memofy/presentation/widgets/slidable/item_slidable_widget.dart';
import 'package:provider/provider.dart';

class SubtaskTileWidget extends StatelessWidget {
  final SubtaskModel subtask;
  final SubtaskDataModel subtaskDataProvider;

  const SubtaskTileWidget({
    Key? key,
    required this.subtask,
    required this.subtaskDataProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return slidableTile(context, subtask);
  }

  Widget slidableTile(BuildContext context, SubtaskModel subtask) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Slidable(
          key: ValueKey(subtask),
          actionPane: SlidableBehindActionPane(),
          actions: [
            ItemSlidableWidget(
              actionName: 'Edit',
              icon: Icons.edit,
              color: Colors.green,
              actionFunction: () {},
            ),
          ],
          secondaryActions: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: IconSlideAction(
                color: Colors.red, //Colors.green,
                onTap: () {
                  //final provider = Provider.of<TaskDataProvider>(context, listen: false);

                  subtaskDataProvider.removeSubtask(subtask);
                },
                caption: 'Delete', //'Edit',
                icon: Icons.delete, //Icons.edit,
              ),
            ),

            // ItemSlidableWidget(
            //   actionName: 'Delete',
            //   icon: Icons.delete,
            //   color: Colors.red,
            //   //actionFunction: () => deleteSubtask(context, index, subtask),
            //   actionFunction: () {
            //     final provider = Provider.of<TaskDataProvider>(context, listen: false);
            //
            //     provider.removeSubtask(index, subtask);
            //   },
            // ),
          ],
          child: Container(
            key: ValueKey(subtask),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                //color: Colors.white,
                //color: subtask.isDone ? Colors.white54 : Colors.white,
                color: subtask.isDone ? Colors.green[300] : Colors.white,
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
            child: ListTile(
              //onLongPress: () => longPressCallback,
              //key: ValueKey(task),
              //focusColor: Colors.amber,
              //tileColor: Colors.red,
              //leading: const Icon(Icons.subject_rounded),
              //contentPadding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
              title: Text(
                subtask.description,//'Text',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 22.0,
                    //color: Colors.black,
                    //color: subtask.isDone ? Colors.grey : Colors.black,
                    color: subtask.isDone ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: subtask.isDone ? TextDecoration.lineThrough : null),
                maxLines: 10,
              ),
              dense: true,
              //isThreeLine: true,
              trailing: Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(5.0),),
                  //shape: CircleBorder(),
                  side: BorderSide(width: 3.0, color: Colors.grey),
                  activeColor: Colors.green,
                  value: subtask.isDone,
                  onChanged: (value) {
                    //final provider = Provider.of<TaskDataProvider>(context, listen: false);
                    subtaskDataProvider.toggleSubtaskStatus(subtask);
                    //check whether all subtask done or not, as a  result change task to Done or ToDo
                    subtaskDataProvider.isTaskDone(context);
                  },
                ),
              ),
            ),
          ),
        ),
      );

  // void deleteSubtask(BuildContext context, int index, SubtaskModel subtask) {
  //   final provider = Provider.of<TaskDataProvider>(context, listen: false);
  //
  //   provider.removeSubtask(index, subtask);
  //
  //   //Scaffold.of(context).re
  // }


}
