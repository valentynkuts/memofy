import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:memofy/presentation/widgets/slidable/item_slidable_widget.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Slidable(
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
        //was wrapped by Padding
        child: Stack(
          children: [
            Container(
              //width: double.infinity;
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
                  //const
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  // const  Radius.circular(10.0)
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    )
                  ]),
              clipBehavior: Clip.hardEdge,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    task.title,
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    // style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    task.data,
                    style: TextStyle(color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    task.note,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {
                  print('tap');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
