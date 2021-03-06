import 'package:flutter/material.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/presentation/widgets/mic/add_by_mic.dart';
import 'package:memofy/view_models/speech/speech_view_model.dart';
import 'package:memofy/view_models/subtask/subtask_view_model.dart';
import 'package:provider/provider.dart';

class MicAddSubtaskScreen extends StatefulWidget {
  static const String id = 'mic_add_subtask_screen';
  String info = 'Press the button and start speaking';

  SubtasksViewModel subtasksViewModel;

  MicAddSubtaskScreen({Key? key, required this.subtasksViewModel})
      : super(key: key);

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
    Provider.of<SpeechViewModel>(context, listen: false).title = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
        value: _subtaskDatamodel,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Add by Mic',
              style: kTasksStyle,
            ),
            centerTitle: true,
          ),
          body: ListView(
            padding: EdgeInsets.all(10.0),
            children: [
              Container(
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
              SizedBox(height: 15.0),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  String title =
                      Provider.of<SpeechViewModel>(context, listen: false)
                          .title;
                  if (title.isNotEmpty) {
                    _subtaskDatamodel!.addSubtask(title);
                    Provider.of<SpeechViewModel>(context, listen: false).title =
                        '';
                    Navigator.pop(context);
                  } else {
                    showErrorDialog(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(130, 50),
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ],
          ),
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
