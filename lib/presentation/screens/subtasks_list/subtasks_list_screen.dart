import 'package:flutter/material.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/data/dataproviders/subtask_data/subtask_data_model.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:memofy/presentation/screens/add_subtask/add_subtask_screen.dart';
import 'package:memofy/presentation/widgets/subtasks_list/subtasks_list_widget.dart';
import 'package:provider/provider.dart';

class SubtasksListScreen extends StatefulWidget {
  static const String id = 'subtasks_list_screen';

  TaskModel taskModel;

  SubtasksListScreen({Key? key, required this.taskModel}) : super(key: key);

  @override
  _SubtasksListScreenState createState() => _SubtasksListScreenState();
}

class _SubtasksListScreenState extends State<SubtasksListScreen> {
  SubtaskDataModel? _subtaskDatamodel;

  @override
  void initState() {
    if (_subtaskDatamodel == null) {
      _subtaskDatamodel = SubtaskDataModel(taskModel: widget.taskModel);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.taskModel.title;

    return ChangeNotifierProvider(
      create: (context) => _subtaskDatamodel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Stack(children: [
          SubtasksListWidget(), //TODO
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
              onChanged: (query) {},
            ),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(
              AddSubtaskScreen.id,
              arguments: _subtaskDatamodel,
            );
          },
        ),
      ),
    );
  }
}
