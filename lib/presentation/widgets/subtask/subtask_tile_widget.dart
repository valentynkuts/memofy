import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:memofy/models/subtask/subtask_model.dart';
import 'package:memofy/presentation/screens/edit_subtask/edit_subtask_screen.dart';
import 'package:memofy/view_models/subtask/subtask_view_model.dart';

class SubtaskTileWidget extends StatelessWidget {
  final SubtaskModel subtask;
  final SubtasksViewModel subtasksViewModel;

  const SubtaskTileWidget({
    Key? key,
    required this.subtask,
    required this.subtasksViewModel,
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
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: IconSlideAction(
                color: Colors.green,
                onTap: () => editSubtask(context),
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
                onTap: () => subtasksViewModel.removeSubtask(subtask),
                caption: 'Delete', //'Edit',
                icon: Icons.delete, //Icons.edit,
              ),
            ),
          ],
          child: Container(
            key: ValueKey(subtask),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: subtask.isDone ? Colors.grey : Colors.white,
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
            child: ListTile(
              title: Text(
                subtask.description, //'Text',
                style: TextStyle(
                    fontFamily: 'SourceCodePro',
                    fontSize: 22.0,
                    color: subtask.isDone ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration:
                        subtask.isDone ? TextDecoration.lineThrough : null),
                maxLines: 10,
              ),
              dense: true,
              trailing: Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  side: BorderSide(width: 3.0, color: Colors.grey),
                  activeColor: Colors.green,
                  value: subtask.isDone,
                  onChanged: (value) {
                    subtasksViewModel.toggleSubtaskStatus(subtask);
                    //check whether all subtask done or not, as a  result change task to Done or To_Do
                    subtasksViewModel.isTaskDone(context);
                  },
                ),
              ),
            ),
          ),
        ),
      );

  void editSubtask(BuildContext context) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditSubtaskScreen(
              subtask: subtask, subtasksViewModel: subtasksViewModel),
        ),
      );
}
