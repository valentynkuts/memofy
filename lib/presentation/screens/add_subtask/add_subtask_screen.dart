import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/data/dataproviders/task_data/task_data.dart';
import 'package:memofy/validation/add_task_validation.dart';
import 'package:provider/provider.dart';

class AddSubtaskScreen extends StatelessWidget {
  static const String id = 'add_subtask_screen';

  String description = ""; // field for input


  AddSubtaskScreen({Key? key}) : super(key: key);

  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Subtask'),
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
    );
  }

  //ok
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
      //newTitle =  value;
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
    onPressed: () {},
    // onPressed: () {
    //   Provider.of<TaskDataProvider>(context, listen: false)
    //       .addTask(newTitle!, DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()), newNote!);
    //   Navigator.pop(context);
    // },
  );
}
