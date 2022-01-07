import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/data/dataproviders/task_data/tasks_view_model.dart';
import 'package:memofy/validation/text_validation.dart';
import 'package:memofy/validation/validation_item.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatelessWidget {
  static const String id = 'add_list_screen';

  String newTitle = ""; // field for input
  String date = ""; // field for input
  String newNote = ""; // field for input

  TextValidation validationService = TextValidation(); //TODO

  AddTaskScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    validationService = Provider.of<TextValidation>(context);

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

  Widget AddTitleInput() => TextField(
        autofocus: true,
        decoration: InputDecoration(
            labelText: 'Title',
            errorText: validationService.text.error,
            //errorText: validation.errorText,
            border: OutlineInputBorder(
              borderRadius: kBorderRadius,
            ),
            hintText: 'Enter a Title'),
        onChanged: (value) {
          validationService.changeNewTitle(value);
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
                newTitle = validationService.text.value;
                print("newTitle-$newTitle"); //TODO
                newNote = newNote.trim();
                date = DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now()); // yyyy-MM-dd
               // data = DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now()); // yyyy-MM-dd
                //---ex
                //DateTime dt = DateTime.parse(data);
                DateTime dt = DateFormat('dd-MM-yyyy kk:mm').parse(date);
                print(dt);
                //print(new DateFormat('dd-MM-yyyy kk:mm').parse(data));
                //----
                Provider.of<TasksViewModel>(context, listen: false).addTask(
                    newTitle,
                    date,
                    newNote);
               // todo
                validationService.text = ValidationItem('', null);
                Navigator.pop(context);
              },
      );
}

