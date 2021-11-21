import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/data/dataproviders/subtask_configuration.dart';
import 'package:memofy/data/dataproviders/subtask_data/add_subtask_form_model.dart';
import 'package:memofy/data/dataproviders/subtask_data/subtask_data_model.dart';
import 'package:memofy/data/dataproviders/task_data/task_data_model.dart';
import 'package:memofy/presentation/screens/subtasks_list/subtasks_list_screen.dart';
import 'package:memofy/validation/add_task_validation.dart';
import 'package:provider/provider.dart';

class AddSubtaskScreen extends StatefulWidget {
  static const String id = 'add_subtask_screen';

  SubtaskDataModel subtaskDataProvider;

  //SubtasksListScreenConfig subtasksListScreenConfig;


  //AddSubtaskScreen({Key? key, required this.subtaskConfiguration}) : super(key: key);
  //AddSubtaskScreen({Key? key, required this.subtasksListScreenConfig}) : super(key: key);
  AddSubtaskScreen({Key? key, required this.subtaskDataProvider}) : super(key: key);

  @override
  State<AddSubtaskScreen> createState() => _AddSubtaskScreenState();
}

class _AddSubtaskScreenState extends State<AddSubtaskScreen> {

  SubtaskDataModel? _subtaskDatamodel;

  @override
  void initState() {
    if(_subtaskDatamodel == null){
      _subtaskDatamodel = widget.subtaskDataProvider;
    }
    super.initState();
  }
  String description = "";
 // final model = widget.subtasksListScreenConfig.subtaskDataProvider;
  @override
  Widget build(BuildContext context) {
    //final value = context.watch<SubtaskDataProvider>();

    return ChangeNotifierProvider.value(
      //create: (context) =>AddSubtaskFormModel(taskKey: taskKey),
      //value: SubtaskDataProvider(subtaskConfiguration: widget.subtaskConfiguration),
      value: _subtaskDatamodel,
      //lazy: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Subtask"),
          //title: Text("$taskKey"),
        ),
        body: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  AddDescriptionInput(),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: submitButton(context),
      ),
    );
  }
 // used
  Widget AddDescriptionInput() => TextField(
    //Widget AddTitleInput() =>  TextFormField(
    autofocus: true,
    // validator: (value) {
    //   if (value == null || value.isEmpty) {
    //     return 'Please enter some text';
    //   }
    //   return null;
    // },
    decoration: InputDecoration(
        labelText: 'Title',
        //errorText: validationService.newTitle.error,
        border: OutlineInputBorder(
          borderRadius: kBorderRadius,
        ),
        hintText: 'Enter a Title'),
    onChanged: (value) {
      //validationService.changeNewTitle(value);
      description =  value;
    },
  );

  Widget AddNoteInput() => TextFormField(
    autofocus: true,
    minLines: 3,
    maxLines: 5,
    keyboardType: TextInputType.multiline,
    decoration: InputDecoration(
        labelText: 'Note',
        hintText: 'Enter a Note',
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: kBorderRadius,
        )),
    onChanged: (newText) {
     // newNote = newText;
    },
  );

  Widget submitButton(BuildContext context) => FloatingActionButton.extended(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    foregroundColor: Colors.white,
    backgroundColor: Colors.green,
    icon: Icon(Icons.done),
    label: Text('Submit'),
    //onPressed: () {},
     onPressed: () {
      //context.watch<AddSubtaskFormModel>().addSubtask(description);
      //Provider.of<AddSubtaskFormModel>(context, listen: false).addSubtask(description);
     // Provider.of<SubtaskDataProvider>(context, listen: false).addSubtask(description);
      _subtaskDatamodel!.addSubtask(description);
      Navigator.pop(context);
    },
  );
}
