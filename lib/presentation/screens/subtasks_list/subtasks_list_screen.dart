import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:memofy/presentation/screens/add_subtask/add_subtask_screen.dart';
import 'package:memofy/presentation/screens/mic_add_subtask/mic_add_subtask_screen.dart';
import 'package:memofy/presentation/widgets/subtasks_list/subtasks_list_widget.dart';
import 'package:memofy/view_models/subtask/subtask_view_model.dart';
import 'package:provider/provider.dart';
import 'package:expandable_text/expandable_text.dart';

class SubtasksListScreen extends StatefulWidget {
  static const String id = 'subtasks_list_screen';

  TaskModel taskModel;

  SubtasksListScreen({Key? key, required this.taskModel}) : super(key: key);

  @override
  _SubtasksListScreenState createState() => _SubtasksListScreenState();
}

class _SubtasksListScreenState extends State<SubtasksListScreen> {
  SubtasksViewModel? _subtaskViewModel;

  @override
  void initState() {
    if (_subtaskViewModel == null) {
      _subtaskViewModel = SubtasksViewModel(taskModel: widget.taskModel);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.taskModel.title;
    final note = widget.taskModel.note;

    return ChangeNotifierProvider(
      create: (context) => _subtaskViewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Stack(children: [
          SubtasksListWidget(), //TODO
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
                left: 5.0, top: 5.0, right: 5.0, bottom: 5.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: ExpandableText(
              note,
              expandOnTextTap: true,
              collapseOnTextTap: true,
              expandText: ' Tap to see more',
              //collapseText: 'show less',
              maxLines: 2,
              textAlign: TextAlign.center,
              linkColor: Colors.grey,
              style: TextStyle(
                color: Colors.lightGreen,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
          ),
        ]),
        floatingActionButton: (widget.taskModel.isDone)
            ? null
            : SpeedDial(
                shape: RoundedRectangleBorder(
                  borderRadius: kBorderRadius,
                ),
                animatedIcon: AnimatedIcons.menu_close,
                backgroundColor: Colors.grey,
                overlayColor: Colors.grey,
                overlayOpacity: 0.4,
                spacing: 12,
                spaceBetweenChildren: 12,
                children: [
                  SpeedDialChild(
                    labelStyle: TextStyle(fontSize: 18.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: kBorderRadius,
                    ),
                    child: Icon(Icons.add),
                    backgroundColor: Colors.green,
                    label: 'Add subtask',
                    onTap: () => Navigator.of(context).pushNamed(
                      AddSubtaskScreen.id,
                      arguments: _subtaskViewModel,
                    ),
                  ),
                  SpeedDialChild(
                    labelStyle: TextStyle(fontSize: 18.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: kBorderRadius,
                    ),
                    child: Icon(Icons.mic),
                    backgroundColor: Colors.amber,
                    label: 'Add subtask by voice',
                    onTap: () => Navigator.of(context).pushNamed(
                      MicAddSubtaskScreen.id,
                      arguments: _subtaskViewModel,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
