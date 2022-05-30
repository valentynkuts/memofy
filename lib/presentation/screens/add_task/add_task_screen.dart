import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/presentation/screens/home/home_page_screen.dart';
import 'package:memofy/presentation/screens/tasks_list/tasks_list_screen.dart';
import 'package:memofy/validation/text_validation.dart';
import 'package:memofy/validation/validation_item.dart';
import 'package:memofy/view_models/task/task_view_model.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  static const String id = 'add_list_screen';

  AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String newTitle = "";
  String date = "";
  String newNote = "";

//--------todo--------
  String dateDo = "";
  List dateTimeDo = [];

  @override
  void initState() {
    dateDo = DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now());
    dateTimeDo = dateDo.split(' ');
    super.initState();
  }

//--------end todo-----

  TextValidation validationService = TextValidation();

  @override
  Widget build(BuildContext context) {
    validationService = Provider.of<TextValidation>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Task',
          style: kTasksStyle,
        ),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AddTitleInput(),
                //------todo------------
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text(dateTimeDo[0]),
                        onPressed: () async {
                          final initialDate = DateTime.now();
                          final newDate = await showDatePicker(
                            context: context,
                            initialDate: initialDate,
                            firstDate: DateTime(DateTime.now().year - 5),
                            lastDate: DateTime(DateTime.now().year + 5),
                          );
                          if (newDate == null) return;
                          setState(() => dateTimeDo[0] =
                              DateFormat('dd-MM-yyyy').format(newDate));
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(130, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ), //buttonDatePicker(context, dateTimeDo[0])),
                    SizedBox(width: 15.0),
                    Expanded(
                      child: ElevatedButton(
                        child: Text(dateTimeDo[1]),
                        onPressed: () async {
                          final initialTime = TimeOfDay.now();
                          final newTime = await showTimePicker(
                              context: context,
                              initialTime: initialTime,
                              builder: (context, childWidget) {
                                return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                        // Using 24-Hour format
                                        alwaysUse24HourFormat: true),
                                    // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                                    child: childWidget!);
                              });
                          if (newTime == null) return;
                          setState(
                              () => dateTimeDo[1] = newTime.format(context));
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(130, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ), //buttonTimePicker(context, dateTimeDo[1])),
                  ],
                ),
                //--------end todo---------
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
        maxLines: 5,
        decoration: InputDecoration(
            labelText: 'Title',
            errorText: validationService.text.error,
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
        //minLines: 3,
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
                newNote = newNote.trim();
                //date = DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now());  //todo
                date = dateTimeDo[0] + ' ' + dateTimeDo[1];

                Provider.of<TasksViewModel>(context, listen: false)
                    .addTask(newTitle, date, newNote);

                validationService.text = ValidationItem('', null);
                Navigator.of(context).pushNamed(HomePageScreen.id);
              },
      );

  Widget buttonDatePicker(BuildContext context, String date_str) =>
      ElevatedButton(
        child: Text(date_str),
        onPressed: () async {
          final initialDate = DateTime.now();
          final newDate = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(DateTime.now().year - 5),
            lastDate: DateTime(DateTime.now().year + 5),
          );
          if (newDate == null) return;
          setState(() => date_str = DateFormat('dd-MM-yyyy').format(newDate));
        },
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(130, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      );

  Widget buttonTimePicker(BuildContext context, String time_str) =>
      ElevatedButton(
        child: Text(time_str),
        onPressed: () async {
          final initialTime = TimeOfDay.now();
          final newTime = await showTimePicker(
              context: context,
              initialTime: initialTime,
              builder: (context, childWidget) {
                return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                        // Using 24-Hour format
                        alwaysUse24HourFormat: true),
                    // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                    child: childWidget!);
              });
          if (newTime == null) return;
          setState(() => time_str = newTime.format(context));
        },
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(130, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      );
}
