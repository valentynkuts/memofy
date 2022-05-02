import 'package:flutter/material.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/validation/text_validation.dart';
import 'package:memofy/validation/validation_item.dart';
import 'package:memofy/view_models/subtask/subtask_view_model.dart';
import 'package:provider/provider.dart';

class AddSubtaskScreen extends StatefulWidget {
  static const String id = 'add_subtask_screen';

  SubtasksViewModel subtasksViewModel;

  AddSubtaskScreen({Key? key, required this.subtasksViewModel})
      : super(key: key);

  @override
  State<AddSubtaskScreen> createState() => _AddSubtaskScreenState();
}

class _AddSubtaskScreenState extends State<AddSubtaskScreen> {
  String description = "";
  SubtasksViewModel? _subtaskDatamodel;

  TextValidation validationService = TextValidation();

  @override
  void initState() {
    if (_subtaskDatamodel == null) {
      _subtaskDatamodel = widget.subtasksViewModel;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    validationService = Provider.of<TextValidation>(context);

    return ChangeNotifierProvider.value(
      value: _subtaskDatamodel,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Subtask", style: kTasksStyle,),
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

  Widget AddDescriptionInput() => TextField(
        autofocus: true,
        maxLines: 7,
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
                _subtaskDatamodel!.addSubtask(description);
                validationService.text = ValidationItem('', null);
                Navigator.pop(context);
              },
      );
}
