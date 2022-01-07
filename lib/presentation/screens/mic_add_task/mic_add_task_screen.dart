import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/presentation/widgets/mic/add_by_mic.dart';
import 'package:memofy/view_models/speech/speech_view_model.dart';
import 'package:memofy/view_models/task/task_view_model.dart';
import 'package:provider/provider.dart';

class MicAddTaskScreen extends StatefulWidget {
  static const String id = 'mic_add_task_screen';
  String info = 'Press the button and start speaking';

  MicAddTaskScreen({Key? key}) : super(key: key);

  @override
  _MicAddTaskScreenState createState() => _MicAddTaskScreenState();
}

class _MicAddTaskScreenState extends State<MicAddTaskScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Add by Mic',
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                widget.info,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            AddByMic(info: 'TITLE'),
            AddByMic(info: 'NOTE'),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            String title =
                Provider.of<SpeechViewModel>(context, listen: false).title;
            String note =
                Provider.of<SpeechViewModel>(context, listen: false).note;

            if (title.isNotEmpty) {
              Provider.of<TasksViewModel>(context, listen: false).addTask(title,
                  DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now()), note);
              Provider.of<SpeechViewModel>(context, listen: false).title = '';
              Provider.of<SpeechViewModel>(context, listen: false).note = '';

              Navigator.pop(context);
            } else {
              showErrorDialog(context);
            }
          },
          label: Text('ADD'),
        ),
      );

  void showErrorDialog(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
            content: Text(
              'Title can not be empty',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: [
              OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close')),
            ],
          );
        },
      );
}
