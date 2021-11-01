import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:memofy/models/subtask/subtask_model.dart';
import 'package:memofy/presentation/widgets/slidable/item_slidable_widget.dart';

class SubtaskTileWidget extends StatelessWidget {
  final SubtaskModel subtask;
  final int index;
  final bool isChecked;
  final Function checkboxCallback;
  final Function longPressCallback;

  const SubtaskTileWidget({
    Key? key,
    required this.subtask,
    required this.index,
    required this.isChecked,
    required this.checkboxCallback,
    required this.longPressCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return slidableTile(index, subtask);
  }

  Widget slidableTile(int index, SubtaskModel subtask) => Padding(
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
            ItemSlidableWidget(
              actionName: 'Delete',
              icon: Icons.delete,
              color: Colors.red,
              actionFunction: () {},
            ),
          ],
          child: Container(
            key: ValueKey(subtask),
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
            child: ListTile(
              //onLongPress: () => longPressCallback,
              //key: ValueKey(task),
              //focusColor: Colors.amber,
              //tileColor: Colors.red,
              //leading: const Icon(Icons.subject_rounded),
              //contentPadding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
              title: Text(
                subtask.description,
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: subtask.isDone ? TextDecoration.lineThrough : null),
                maxLines: 10,
              ),
              dense: true,
              //isThreeLine: true,
              trailing: Checkbox(
                activeColor: Colors.lightBlueAccent,
                value: subtask.isDone,
                onChanged: (_) => checkboxCallback,
                //onChanged:(_){ },
              ),
              // onTap: () => print("ListTile"),
            ),
          ),
        ),
      );
}
