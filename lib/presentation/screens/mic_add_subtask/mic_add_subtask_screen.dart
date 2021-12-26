import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/data/dataproviders/speech_data/speech_data_model.dart';
import 'package:memofy/data/dataproviders/subtask_data/subtask_data_model.dart';
import 'package:memofy/data/dataproviders/task_data/task_data_model.dart';
import 'package:memofy/presentation/widgets/mic/add_by_mic.dart';
import 'package:provider/provider.dart';

class MicAddSubtaskScreen extends StatefulWidget {
  static const String id = 'mic_add_subtask_screen';
  String info = 'Press the button and start speaking';

  SubtasksViewModel subtasksViewModel;

  MicAddSubtaskScreen({Key? key, required this.subtasksViewModel}) : super(key: key);

  @override
  _MicAddSubtaskScreenState createState() => _MicAddSubtaskScreenState();
}

class _MicAddSubtaskScreenState extends State<MicAddSubtaskScreen> {
  SubtasksViewModel? _subtaskDatamodel;

  @override
  void initState() {
    if (_subtaskDatamodel == null) {
      _subtaskDatamodel = widget.subtasksViewModel;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
    value: _subtaskDatamodel,
    child: Scaffold(
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
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          String title =
              Provider.of<SpeechViewModel>(context, listen: false).title;
          // String note =
          //     Provider.of<SpeechViewModel>(context, listen: false).note;

          if (title.isNotEmpty) {
            _subtaskDatamodel!.addSubtask(title);
            // Provider.of<TasksViewModel>(context, listen: false).addTask(title,
            //     DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now()), note);
            Provider.of<SpeechViewModel>(context, listen: false).title = '';
            //Provider.of<SpeechViewModel>(context, listen: false).note = '';

            Navigator.pop(context);
          } else {
            showErrorDialog(context);
          }
        },
        //icon: Icon(Icons.add),
        //label: Text('ADD TASK'),
        label: Text('ADD'),
      ),
    ),
  );

  void showErrorDialog(BuildContext context) => showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: kBorderRadius),
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
