import 'package:flutter/material.dart';
import 'package:memofy/constants/constants.dart';
//import 'package:provider/provider.dart';

class AddTaskScreen extends StatelessWidget {
  static const String id = 'add_list_screen';

  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? newTitle;   // field for input

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
                //TitleFormWidget(newTitle: newTitle)
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                        borderRadius: kBorderRadius,
                      ),
                      hintText: 'Enter a Title'),
                  onChanged: (newText) {
                    newTitle = newText;
                  },
                ),
                SizedBox(height: 10.0),
                MultiLineFormWidget(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        icon: Icon(Icons.done),
        label: Text('Submit'),
        onPressed: () {
          print(newTitle);
        },
      ),
    );
  }
}

class TitleFormWidget extends StatelessWidget {
  String? newTitle;

  TitleFormWidget({required this.newTitle});

  //const TitleFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
          labelText: 'Title',
          border: OutlineInputBorder(
            borderRadius: kBorderRadius,
          ),
          hintText: 'Enter a Title'),
      onChanged: (newText) {
        newTitle = newText;
      },
    );
  }
}

class MultiLineFormWidget extends StatelessWidget {
  const MultiLineFormWidget({Key? key}) : super(key: key);

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
    );
  }
}

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
