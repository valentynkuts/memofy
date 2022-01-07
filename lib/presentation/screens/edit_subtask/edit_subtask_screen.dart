import 'package:flutter/material.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/models/subtask/subtask_model.dart';
import 'package:memofy/validation/text_validation.dart';
import 'package:memofy/validation/validation_item.dart';
import 'package:memofy/view_models/subtask/subtask_view_model.dart';
import 'package:provider/provider.dart';

class EditSubtaskScreen extends StatefulWidget {
  static const String id = 'add_subtask_screen';

  SubtaskModel subtask;
  SubtasksViewModel subtasksViewModel;

  EditSubtaskScreen(
      {Key? key, required this.subtask, required this.subtasksViewModel})
      : super(key: key);

  @override
  State<EditSubtaskScreen> createState() => _EditSubtaskScreenState();
}

class _EditSubtaskScreenState extends State<EditSubtaskScreen> {
  String description = '';
  SubtasksViewModel? _subtasksViewModel;

  TextValidation validationService = TextValidation();

  @override
  void initState() {
    if (_subtasksViewModel == null) {
      _subtasksViewModel = widget.subtasksViewModel;
      description = widget.subtask.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    validationService = Provider.of<TextValidation>(context);

    return ChangeNotifierProvider.value(
      value: _subtasksViewModel,
      //lazy: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Subtask"),
        ),
        body: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  EditDescriptionInput(),
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

  Widget EditDescriptionInput() => TextFormField(
        initialValue: description,
        autofocus: true,
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
                description = validationService.text.value;
                _subtasksViewModel!.updateSubtask(widget.subtask, description);
                validationService.text = ValidationItem('', null);
                Navigator.pop(context);
              },
      );
}
