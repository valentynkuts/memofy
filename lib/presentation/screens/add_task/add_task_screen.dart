import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/data/dataproviders/task_data/task_data.dart';
import 'package:memofy/validation/add_task_validation.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatelessWidget {
  static const String id = 'add_list_screen';

  String newTitle = ""; // field for input
  String data = ""; // field for input
  String newNote = ""; // field for input

  AddTaskValidation validationService =
      AddTaskValidation(); // = Provider.of<AddTaskValidation>(context);

  AddTaskScreen({Key? key}) : super(key: key);

  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // String newTitle = ""; // field for input
    // String data; // field for input
    // String newNote = ""; // field for input
    //
    validationService = Provider.of<AddTaskValidation>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AddTitleInput(),
                SizedBox(height: 10.0),
                AddNoteInput(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: submitButton(context),
    );
  }

  //ok
  Widget AddTitleInput() => TextField(
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
            errorText: validationService.newTitle.error,
            border: OutlineInputBorder(
              borderRadius: kBorderRadius,
            ),
            hintText: 'Enter a Title'),
        onChanged: (value) {
          validationService.changeNewTitle(value);
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
          newNote = newText;
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
        onPressed: (!validationService.isValid)
            ? null
            : () {
                newTitle = validationService.newTitle.value!;
                Provider.of<TaskDataProvider>(context, listen: false).addTask(
                    newTitle,
                    DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
                    newNote);
                Navigator.pop(context);
              },
        // onPressed: () {
        //   Provider.of<TaskDataProvider>(context, listen: false)
        //       .addTask(newTitle!, DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()), newNote!);
        //   Navigator.pop(context);
        // },
      );
}
////////////////////////////////////////////////
/*
class TitleFormWidget extends StatelessWidget {
  String? newTitle = '';
  ValueChanged<String> onChangedTitle;

  TitleFormWidget({required this.newTitle, required this.onChangedTitle});

  //const TitleFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please enter some text';
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
          labelText: 'Title',
          //errorText: 'No Title',
          border: OutlineInputBorder(
            borderRadius: kBorderRadius,
          ),
          hintText: 'Enter a Title'),
      // onChanged: (newText) {
      //   newTitle = newText;
      // },
      onChanged: onChangedTitle,
    );
  }
}

class MultiLineFormWidget extends StatelessWidget {
  String? newNote = '';
  ValueChanged<String> onChangedNote;

  MultiLineFormWidget({required this.newNote, required this.onChangedNote});

  //const MultiLineFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      onChanged: onChangedNote,
    );
  }
}
*/

/*
Widget buildMessageButton() => FloatingActionButton.extended(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  foregroundColor: Colors.white,
  backgroundColor: Colors.green,
  icon: Icon(Icons.message),
  label: Text('Message'),
  onPressed: () {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NewMessagePage(),
    ));
  },
);
*/
