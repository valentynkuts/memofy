import 'dart:ffi';

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
  List dateTime = [];
  List dateTimeFrom = [];
  String note = '';
  String tempDate = '';

  @override
  void initState() {
    title = widget.task.title;
    dateTime = widget.task.date.split(' ');
    dateTimeFrom = widget.task.dateFrom.split(' ');
    note = widget.task.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    validationService = Provider.of<TextValidation>(context);

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Edit Task', style: kTasksStyle,),
    //   ),
    //   body: Center(
    //     child: Container(
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Column(
    //           children: [
    //             EditTitleInput(),
    //             SizedBox(height: 15.0),
    //             Row(
    //               children: [
    //                 Text('To: ',
    //                 style: TextStyle(
    //                   fontSize: 23.0,
    //                   color: Colors.grey,
    //                   fontWeight: FontWeight.bold,
    //                 ),),
    //                 Expanded(
    //                   child: ElevatedButton(
    //                     child: Text(dateTime[0]),
    //                     onPressed: () async {
    //                       final initialDate = DateTime.now();
    //                       final newDate = await showDatePicker(
    //                         context: context,
    //                         initialDate: initialDate,
    //                         firstDate: DateTime(DateTime.now().year - 5),
    //                         lastDate: DateTime(DateTime.now().year + 5),
    //                       );
    //                       if (newDate == null) return;
    //                       setState(
    //                           () => dateTime[0] = DateFormat('dd-MM-yyyy').format(newDate));
    //                     },
    //                     style: ElevatedButton.styleFrom(
    //                         fixedSize: const Size(130, 50),
    //                         shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(10))),
    //                   ),
    //                 ),
    //                 SizedBox(width: 15.0),
    //                 Expanded(
    //                   child: ElevatedButton(
    //                     child: Text(dateTime[1]),
    //                     onPressed: () async{
    //                       final initialTime = TimeOfDay.now();
    //                       final newTime = await showTimePicker(
    //                           context: context,
    //                           initialTime: initialTime,
    //                           builder:  (context, childWidget) {
    //                             return MediaQuery(
    //                                 data: MediaQuery.of(context).copyWith(
    //                                   // Using 24-Hour format
    //                                     alwaysUse24HourFormat: true),
    //                                 // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
    //                                 child: childWidget!);
    //                           });
    //                           if (newTime == null) return;
    //                           setState(() => dateTime[1] = newTime.format(context));
    //                     },
    //                     style: ElevatedButton.styleFrom(
    //                         fixedSize: const Size(130, 50),
    //                         shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(10))),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             SizedBox(height: 15.0),
    //             Row(
    //               children: [
    //                 Text('From: ',
    //                   style: TextStyle(
    //                     fontSize: 23.0,
    //                     color: Colors.grey,
    //                     fontWeight: FontWeight.bold,
    //                   ),),
    //                 Expanded(
    //                   child: ElevatedButton(
    //                     child: Text(dateTimeFrom[0]),
    //                     onPressed: () async {
    //                       final initialDate = DateTime.now();
    //                       final newDate = await showDatePicker(
    //                         context: context,
    //                         initialDate: initialDate,
    //                         firstDate: DateTime(DateTime.now().year - 5),
    //                         lastDate: DateTime(DateTime.now().year + 5),
    //                       );
    //                       if (newDate == null) return;
    //                       setState(
    //                               () => dateTimeFrom[0] = DateFormat('dd-MM-yyyy').format(newDate));
    //                     },
    //                     style: ElevatedButton.styleFrom(
    //                         fixedSize: const Size(130, 50),
    //                         shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(10))),
    //                   ),
    //                 ),
    //                 SizedBox(width: 15.0),
    //                 Expanded(
    //                   child: ElevatedButton(
    //                     child: Text(dateTimeFrom[1]),
    //                     onPressed: () async{
    //                       final initialTime = TimeOfDay.now();
    //                       final newTime = await showTimePicker(
    //                           context: context,
    //                           initialTime: initialTime,
    //                           builder:  (context, childWidget) {
    //                             return MediaQuery(
    //                                 data: MediaQuery.of(context).copyWith(
    //                                   // Using 24-Hour format
    //                                     alwaysUse24HourFormat: true),
    //                                 // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
    //                                 child: childWidget!);
    //                           });
    //                       if (newTime == null) return;
    //                       setState(() => dateTimeFrom[1] = newTime.format(context));
    //                     },
    //                     style: ElevatedButton.styleFrom(
    //                         fixedSize: const Size(130, 50),
    //                         shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(10))),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             SizedBox(height: 15.0),
    //             EditNoteInput(),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    //   floatingActionButton: submitButton(context),
    // );
    //----------------------------------------
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task', style: kTasksStyle,),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: [
          Column(
                children: [
                  EditTitleInput(),
                  SizedBox(height: 15.0),
                  Row(
                    children: [
                      Text('To: ',
                        style: TextStyle(
                          fontSize: 23.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),),
                      Expanded(
                        child: ElevatedButton(
                          child: Text(dateTime[0]),
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
                                    () => dateTime[0] = DateFormat('dd-MM-yyyy').format(newDate));
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(130, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      SizedBox(width: 15.0),
                      Expanded(
                        child: ElevatedButton(
                          child: Text(dateTime[1]),
                          onPressed: () async{
                            final initialTime = TimeOfDay.now();
                            final newTime = await showTimePicker(
                                context: context,
                                initialTime: initialTime,
                                builder:  (context, childWidget) {
                                  return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                        // Using 24-Hour format
                                          alwaysUse24HourFormat: true),
                                      // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                                      child: childWidget!);
                                });
                            if (newTime == null) return;
                            setState(() => dateTime[1] = newTime.format(context));
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(130, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    children: [
                      Text('From: ',
                        style: TextStyle(
                          fontSize: 23.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),),
                      Expanded(
                        child: ElevatedButton(
                          child: Text(dateTimeFrom[0]),
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
                                    () => dateTimeFrom[0] = DateFormat('dd-MM-yyyy').format(newDate));
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(130, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      SizedBox(width: 15.0),
                      Expanded(
                        child: ElevatedButton(
                          child: Text(dateTimeFrom[1]),
                          onPressed: () async{
                            final initialTime = TimeOfDay.now();
                            final newTime = await showTimePicker(
                                context: context,
                                initialTime: initialTime,
                                builder:  (context, childWidget) {
                                  return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                        // Using 24-Hour format
                                          alwaysUse24HourFormat: true),
                                      // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                                      child: childWidget!);
                                });
                            if (newTime == null) return;
                            setState(() => dateTimeFrom[1] = newTime.format(context));
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(130, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  EditNoteInput(),
                  //---------added fro test-------
                 // SizedBox(width: 15.0),


                  //---------
                ],
              ),
          SizedBox(height: 15.0),
          ElevatedButton(
            child: Text('Submit'),
            onPressed:() {
              if (validationService.isValid) {
                title = validationService.text.value;
              }
              note = note.trim();
              String date = dateTime[0] + ' ' + dateTime[1];
              String dateFrom = dateTimeFrom[0] + ' ' + dateTimeFrom[1];
              Provider.of<TasksViewModel>(context, listen: false)
                  .updateTask(widget.task, title, note, date, dateFrom);
              validationService.text = ValidationItem('', null);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(130, 50),
              primary: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ],
      ),


     // floatingActionButton: submitButton(context),
    );
    //------------------
  }

  Widget EditTitleInput() => TextFormField(
        initialValue: title,
        maxLines: 5,
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
        //minLines: 3,
        maxLines: 3,
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
          String date = dateTime[0] + ' ' + dateTime[1];
          String dateFrom = dateTimeFrom[0] + ' ' + dateTimeFrom[1];
          Provider.of<TasksViewModel>(context, listen: false)
              .updateTask(widget.task, title, note, date, dateFrom);
          validationService.text = ValidationItem('', null);
          Navigator.pop(context);
        },
      );
}
