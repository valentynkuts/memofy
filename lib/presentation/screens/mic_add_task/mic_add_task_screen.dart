import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memofy/data/dataproviders/speech_data/speech_data_model.dart';
import 'package:memofy/data/dataproviders/task_data/task_data_model.dart';
import 'package:memofy/presentation/widgets/mic/add_by_mic.dart';
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
                Provider.of<SpeechDataModel>(context, listen: false).title;
            String note =
                Provider.of<SpeechDataModel>(context, listen: false).note;

            if(title.isNotEmpty) {
              Provider.of<TaskDataModel>(context, listen: false).addTask(title,
                  DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now()), note);
            }

            Provider.of<SpeechDataModel>(context, listen: false).title = '';
            Provider.of<SpeechDataModel>(context, listen: false).note = '';

            Navigator.pop(context);
          },
          icon: Icon(Icons.add),
          label: Text('ADD TASK'),
        ),
      );
}
