import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:memofy/notification_api/notification_api.dart';
import 'package:memofy/presentation/screens/edit_task/edit_task_screen.dart';
import 'package:memofy/presentation/screens/subtasks_list/subtasks_list_screen.dart';
import 'package:memofy/view_models/task/task_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class TaskTileWidget extends StatefulWidget {
  final TaskModel task;

  TaskTileWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<TaskTileWidget> createState() => _TaskTileWidgetState();
}

class _TaskTileWidgetState extends State<TaskTileWidget> {
  Color pickerColor = Color(0xFFFFFFFF);

  void changeColor(Color color) {
    setState(() {
      pickerColor = color.withOpacity(0.3);
      Provider.of<TasksViewModel>(context, listen: false)
          .updateTaskColor(widget.task, pickerColor_value);
    }); //write color to DB
  }

  @override
  void initState() {
    super.initState();
    NotificationApi.init(initScheduled: true);
    listenNotification();
  }
  void listenNotification() => NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) {
    // Full clean of Navigator's history and navigate to new route
    Navigator.pushNamedAndRemoveUntil(context, SubtasksListScreen.id, (route) => false, arguments: widget.task);
    Provider.of<TasksViewModel>(context, listen: false).switchTaskNotification(widget.task, false);
  }

  int get pickerColor_value => pickerColor.value;

  void set pickerCol(int value) {
    pickerColor = Color(value);
  }

  @override
  Widget build(BuildContext context) {
    void onTaskTap(TaskModel task) {
      Navigator.of(context).pushNamed(
        SubtasksListScreen.id,
        arguments: task,
      );
    }

    return slidableTile(context, widget.task, onTaskTap);
  }

  Widget slidableTile(
          BuildContext context, TaskModel task, Function onTaskTap) =>
      Padding(
        padding: const EdgeInsets.all(3.0),
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
                  //color: task.isDone ? Colors.grey : Colors.white, //colors todo
                  //color: task.isDone ? Colors.grey : pickerColor, //colors todo
                  color: task.isDone ? Colors.grey : Color(task.colorValue),
                  //colors todo
                  border: Border.all(color: Colors.black.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
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
                      style: kTaskTitleStyle,
                      maxLines: 5,
                    ),
                    subtitle: Text(
                      task.date,
                      style: kTaskDateStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    dense: true,
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                      tooltip: 'Setting to choose color',
                      onPressed: () {
                        settingDialog(context);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      task.note,
                      style: kTaskNoteStyle,
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
        arguments: widget.task,
      );

  void showSettingColorDialog(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: MaterialPicker(
                pickerColor: pickerColor,
                onColorChanged: changeColor,
                //showLabel: true, // only on portrait mode
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Got it'),
                onPressed: () {
                  //setState(() => currentColor = pickerColor);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

  void settingDialog(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {

          DateTime dt = DateFormat('dd-MM-yyyy HH:mm').parse(widget.task.date);
          if(dt.isBefore(DateTime.now())){
            Provider.of<TasksViewModel>(context, listen: false).switchTaskNotification(widget.task, false);
          }

          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 5),
                      Row(
                        children: [
                          // Text(
                          //   'Choose color',
                          //   style: TextStyle(
                          //     //fontFamily: 'Pacifico',
                          //     fontSize: 20.0,
                          //     color: Colors.green,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () => showSettingColorDialog(context),
                            child: Text('PRESS to get COLOR'),
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(230, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                primary: Colors.grey,
                                //padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                                textStyle:
                                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Column(
                        children: [
                          Text(
                            'NOTIFICATION',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 15),
                          Transform.scale(
                            scale: 3,
                            child: Switch.adaptive(
                              activeColor: Colors.green,
                              value: widget.task.isNotificationOn,
                              onChanged: (value) {
                                setState(() => widget.task.isNotificationOn = value);
                                Provider.of<TasksViewModel>(context, listen: false).switchTaskNotification(widget.task, value);
                                if(widget.task.isNotificationOn){
                                  //DateTime dt = DateFormat('dd-MM-yyyy HH:mm').parse(widget.task.date);
                                  if(dt.isAfter(DateTime.now())){
                                    int notificationId = intGenerator();
                                    Provider.of<TasksViewModel>(context, listen: false).updateTaskNotificationId(widget.task, notificationId);
                                    NotificationApi.showScheduledNotification(
                                      id: notificationId,
                                      title: widget.task.title,
                                      body: widget.task.note,
                                      scheduledDate: dt,
                                    );
                                  } else{
                                    widget.task.isNotificationOn = false;
                                    notificationWarning(context);
                                  }
                                } else{
                                  NotificationApi.cancel(widget.task.notificationId);
                                }
                              }
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.of(context).pop(),
                          //child: //Text('X'),
                          icon: Icon(Icons.close),  //icon data for elevated button
                          label: Text("CLOSE"),
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(230, 45),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              primary: Colors.grey,
                              //padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                              textStyle:
                              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ]),
              ),
            );
          });
        },
      );
  void notificationWarning(BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please go to EDIT and set up future Date, Time'),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.deepOrangeAccent,
      ),
  );

  int intGenerator() {
    int _randomInt = Random().nextInt(10000)*4 +
        Random().nextInt(1000)*3 +
        Random().nextInt(100)*2;
    return _randomInt;
  }
}
