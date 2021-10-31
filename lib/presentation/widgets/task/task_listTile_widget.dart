import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:memofy/presentation/widgets/slidable/item_slidable_widget.dart';

class TaskListTileWidget extends StatelessWidget {
  const TaskListTileWidget({
    Key? key,
    required this.task,
    required this.index,
  }) : super(key: key);

  final TaskModel task;
  final int index;

  @override
  Widget build(BuildContext context) {
    return slidableListTile1(index, task);
      //slidableWidget(index, task);
    /*
      Padding(
      //key: ValueKey(task),
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Slidable(
          key: ValueKey(task),
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
          child: ListTile(
            //key: ValueKey(task),
            title: Text(
              task.title,
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
            subtitle: Text(
              task.data,
              style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15.0,),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            isThreeLine: true,
          )
      ),
    );*/


  }

  Widget slidableListTile1(int index, TaskModel task) =>
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Slidable(
              key: ValueKey(task),
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
                            fontSize: 17.0,),
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
                  onTap: () => print("Listjhjkhkjh"),
              ),
        ),
      );


  Widget slidableWidget(int index, TaskModel task) =>
      Padding(
        key: ValueKey(task),
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
                padding: EdgeInsets.all(10.0),
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      task.note,
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0
                      ),
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

  Widget slidableListTile(int index, TaskModel task) =>
      Card(
        key: ValueKey(task),
        color: Colors.grey,
        elevation: 10,
        shadowColor: Colors.lightBlueAccent,
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Slidable(
          // key: ValueKey(task),
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
            child: ListTile(
              //key: ValueKey(task),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              title: Text(
                task.title,
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              subtitle: Text(
                task.data,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              isThreeLine: true,
            )
        ),
      );
}


/*
Stack
(
children: [
Container
(
padding: EdgeInsets.all(10.0
)
,
decoration: BoxDecoration
(
color: Colors.white,border: Border.all(color: Colors.black.withOpacity(0.2
)
)
,
//const
borderRadius: BorderRadius.all(Radius.circular(10.0
)
)
,
// const  Radius.circular(10.0)
boxShadow: [
BoxShadow
(
color: Colors.black.withOpacity(0.1
)
,
blurRadius: 8
,
offset: Offset
(0,
2
)
,
)
]
)
,
clipBehavior: Clip.hardEdge,child: Column
(
crossAxisAlignment: CrossAxisAlignment.stretch,children: [
Text
(
task.title,style: TextStyle
(
fontFamily: '
Pacifico',
fontSize: 20.0
,
color: Colors.black,fontWeight: FontWeight.bold,)
,
// style: TextStyle(fontWeight: FontWeight.bold),
maxLines: 1
,
overflow: TextOverflow.ellipsis,)
,
SizedBox
(
height: 5
,
)
,
Text
(
task.data,style: TextStyle
(
color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 15.0
,
)
,
maxLines: 1
,
overflow: TextOverflow.ellipsis,)
,
SizedBox
(
height: 10
,
)
,
Text
(
task.note,style: TextStyle
(
color: Colors.green,fontWeight: FontWeight.bold,fontSize: 17.0
)
,
maxLines: 3
,
overflow: TextOverflow.ellipsis,)
,
]
,
)
,
)
,
Material
(
color: Colors.transparent,child: InkWell
(
borderRadius: BorderRadius.circular(10.0
)
,
onTap: () {
print('tap');
},
)
,
)
,
]
,
)
,*/
