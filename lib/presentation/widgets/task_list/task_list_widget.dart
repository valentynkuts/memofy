import 'package:flutter/material.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:memofy/presentation/widgets/task/task_widget.dart';

class TaskListWidget extends StatefulWidget {
  TaskListWidget({Key? key}) : super(key: key);

  @override
  _TaskListWidgetState createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  final _tasks = [
    TaskModel(
        title: 'Making Paiment',
        data: ' 07-09-2021',
        note: 'Text confronts the '
            'darker parts of her ledger when a dangerous conspiracy with ties to '
            'her past arises. Pursued by a force that will stop at nothing to bring'
            ' her down, Natasha must deal with her history as a spy and the broken '
            'relationships left in her wake long before she became an Avenger.'),
    TaskModel(
        title: 'Go to shop',
        data: '07/16/2021 ',
        note: 'Content — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
    TaskModel(
        title: 'To do smth',
        data: 'Jun 30, 2021',
        note: 'All the rules are broken as a sect of lawless marauders '
            'decides that the annual Purge does not stop at daybreak and instead '
            'should never end as they chase a group of immigrants who they want '
            'to punish because of their harsh historical past.'),
    TaskModel(
        title: 'Took Baby from ...',
        data: '07/02/2021',
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other. But a new '
            'boss baby with a cutting-edge approach and a can-do attitude is about t'
            'o bring them together again … and inspire a new family business.'),
    TaskModel(
        title: 'Bhkjhhkjhkjl kopi kjhiuh ',
        data: '07/16/2021 ',
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
    TaskModel(
        title: 'Lucauytuyy',
        data: '07/16/2021 ',
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
    TaskModel(
        title: 'Awake',
        data: '07/16/2021 ',
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
    TaskModel(
        title: 'Infinite',
        data: '07/16/2021 ',
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
    TaskModel(
        title: 'Wrauytuyt',
        data: 'Apr 22, 2021',
        note: 'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
  ];

  var _fillteredTasks = <TaskModel>[];
  final _searchController = TextEditingController();

  void _searchMovies() {
    final query = _searchController.text;
    print(query);
    if (query.isNotEmpty) {
      _fillteredTasks = _tasks.where((TaskModel movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _fillteredTasks = _tasks;
    }
    setState(() {});
  }

  void _searchMovies1(String query) {
    // final query = _searchController.text;
    print(query);
    if (query.isNotEmpty) {
      _fillteredTasks = _tasks.where((TaskModel movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _fillteredTasks = _tasks;
    }
    //setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fillteredTasks = _tasks;
    _searchController.addListener(_searchMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(top: 70.0),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: _fillteredTasks.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final task = _fillteredTasks[index];
            return TaskWidget(task: task);
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: OutlineInputBorder(
                borderRadius: kBorderRadius,
              ),
            ),
            controller: _searchController,
            onChanged: (query) {
              //_searchMovies1(query);

              // if (query.isNotEmpty) {
              //   _fillteredMovies = _movies.where((Movie movie) {
              //     return movie.title.toLowerCase().contains(query.toLowerCase());
              //   }).toList();
              // } else {
              //   _fillteredMovies = _movies;
              // }
              // print(query);
            },
          ),
        ),

        // added 16.10 ---------------
        /*Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/list');
            },
            child: const Icon(Icons.add),
          ),
        ),*/
        //---------------
      ],
    );
  }
}

//Item of List to Do something
//
/*class ToDoWidget extends StatelessWidget {
  const ToDoWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Slidable(
        actionPane: SlidableBehindActionPane(),
        actions: [
          ActionSlidable(
            color: Colors.green,
            actionName: 'Edit',
            icon: Icons.edit,
            function: () {},
          )

          */ /*IconSlideAction(
            color: Colors.green,
            onTap: () {},
            caption: 'Edit',
            icon: Icons.edit,
          )*/ /*
        ],
        secondaryActions: [
          // ActionSlidable(color: Colors.red, actionName: 'Delete', icon: Icons.delete, function: (){},)
          IconSlideAction(
            color: Colors.red,
            onTap: () {},
            caption: 'Delete',
            icon: Icons.delete,
          )
        ],
        //was wrapped by Padding
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    )
                  ]),
              clipBehavior: Clip.hardEdge,
              child: Row(
                children: [
                  Image(
                    image: AssetImage('images/movie.jpg'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          movie.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          movie.time,
                          style: TextStyle(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          movie.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
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

class ActionSlidable extends StatelessWidget {
  final color;
  final actionName;
  final icon;
  final function;

  const ActionSlidable({
    required this.color,
    required this.actionName,
    required this.icon,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: IconSlideAction(
        color: color, //Colors.green,
        onTap: function,
        caption: actionName, //'Edit',
        icon: icon, //Icons.edit,
      ),
    );
  }
}*/
