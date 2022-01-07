import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:memofy/validation/text_validation.dart';
import 'package:memofy/validation/validation_item.dart';
import 'package:memofy/view_models/task/task_view_model.dart';
import 'package:provider/provider.dart';

class EditTaskScreen extends StatefulWidget {
  static const String id = 'edit_task_screen';

  TaskModel task;

  EditTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextValidation validationService = TextValidation();

  String title = '';
  String date = '';
  String note = '';
  String tempDate = '';

  @override
  void initState() {
    title = widget.task.title;
    date = widget.task.date;
    note = widget.task.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    validationService = Provider.of<TextValidation>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                EditTitleInput(),
                SizedBox(height: 10.0),
                //datePicker(context),
                Text(
                  date,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  child: Text(date),
                  onPressed: () async {
                    final initialDate = DateTime.now();
                    final newDate = await showDatePicker(
                      context: context,
                      initialDate: initialDate,
                      firstDate: DateTime(DateTime.now().year - 5),
                      lastDate: DateTime(DateTime.now().year + 5),
                    );
                    if (newDate == null) return;
                    setState(
                        () => date = DateFormat('dd-MM-yyyy').format(newDate));
                  },
                ),
                SizedBox(height: 10.0),
                EditNoteInput(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: submitButton(context),
    );
  }

  Widget EditTitleInput() => TextFormField(
        initialValue: title,
        autofocus: true,
        decoration: InputDecoration(
            labelText: 'Title',
            errorText: validationService.text.error,
            border: OutlineInputBorder(
              borderRadius: kBorderRadius,
            ),
            hintText: 'Enter a Title'),
        onChanged: (value) => validationService.changeNewTitle(value),
      );

  Widget EditNoteInput() => TextFormField(
        autofocus: true,
        minLines: 3,
        maxLines: 5,
        initialValue: note,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
            labelText: 'Note',
            hintText: 'Enter a Note',
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: kBorderRadius,
            )),
        onChanged: (newText) {
          note = newText;
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
        onPressed: () {
          if (validationService.isValid) {
            title = validationService.text.value;
          }
          note = note.trim();
          Provider.of<TasksViewModel>(context, listen: false)
              .updateTask(widget.task, title, note, date);
          validationService.text = ValidationItem('', null);
          Navigator.pop(context);
        },
      );
}
