import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/data/dataproviders/subtask_data/subtask_data_model.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:memofy/presentation/screens/add_subtask/add_subtask_screen.dart';
import 'package:memofy/presentation/screens/mic_add_subtask/mic_add_subtask_screen.dart';
import 'package:memofy/presentation/screens/mic_add_task/mic_add_task_screen.dart';
import 'package:memofy/presentation/widgets/subtasks_list/subtasks_list_widget.dart';
import 'package:provider/provider.dart';

//import 'package:expandable/expandable.dart';
import 'package:expandable_text/expandable_text.dart';

class SubtasksListScreen extends StatefulWidget {
  static const String id = 'subtasks_list_screen';

  TaskModel taskModel;

  SubtasksListScreen({Key? key, required this.taskModel}) : super(key: key);

  @override
  _SubtasksListScreenState createState() => _SubtasksListScreenState();
}

class _SubtasksListScreenState extends State<SubtasksListScreen> {
  SubtasksViewModel? _subtaskDatamodel;

  @override
  void initState() {
    if (_subtaskDatamodel == null) {
      _subtaskDatamodel = SubtasksViewModel(taskModel: widget.taskModel);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.taskModel.title;
    final note = widget.taskModel.note;
    // final note = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
    //     "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an "
    //     "unknown printer took a galley of type and scrambled it to make a type specimen book. "
    //     "It has survived not only five centuries, but also the leap into electronic typesetting, "
    //     "remaining essentially unchanged. It was popularised in the 1960s with the release of "
    //     "Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing "
    //     "software like Aldus PageMaker including versions of Lorem Ipsum.";

    return ChangeNotifierProvider(
      create: (context) => _subtaskDatamodel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Stack(children: [
          SubtasksListWidget(), //TODO
          Container(
            width: double.infinity,
            //margin: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.only(
                left: 5.0, top: 5.0, right: 5.0, bottom: 5.0),
            //height: 70.0,
            padding: EdgeInsets.all(10.0),
            //color: Colors.white,
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
        floatingActionButton: SpeedDial(
          shape: RoundedRectangleBorder(
            borderRadius: kBorderRadius,
          ),
          animatedIcon: AnimatedIcons.menu_close,
          //animatedIconTheme: IconThemeData(size: 38.0),
          //icon: Icons.share,
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
              onTap: () =>  Navigator.of(context).pushNamed(
                      AddSubtaskScreen.id,
                      arguments: _subtaskDatamodel,
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
                  arguments: _subtaskDatamodel,), //TODO
            ),
          ],
        ),
        // FloatingActionButton(
        //   shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        //   backgroundColor: Colors.green,
        //   child: const Icon(Icons.add),
        //   onPressed: () {
        //     Navigator.of(context).pushNamed(
        //       AddSubtaskScreen.id,
        //       arguments: _subtaskDatamodel,
        //     );
        //   },
        // ),
      ),
    );
  }
}
