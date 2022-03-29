import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/presentation/widgets/mic/add_by_mic.dart';
import 'package:memofy/speech_api/speech_api.dart';
import 'package:memofy/view_models/speech/speech_view_model.dart';
import 'package:memofy/view_models/task/task_view_model.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MicAddTaskScreen extends StatefulWidget {
  static const String id = 'mic_add_task_screen';
  String info = 'Press the button and start speaking';
  SpeechApi speechApi = SpeechApi();

  MicAddTaskScreen({Key? key}) : super(key: key);

  @override
  _MicAddTaskScreenState createState() => _MicAddTaskScreenState();
}

class _MicAddTaskScreenState extends State<MicAddTaskScreen> {
  final items = [
    'itemserier1',
    'itererwerms2',
    'itemsere3',
    'items4',
    'itemees5'
  ];
  String? _currentLocaleId = '';
  String? selectedItem;

  int selectedValue = 0;

  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("USA--"), value: "USA"),
    DropdownMenuItem(child: Text("Canada"), value: "Canada"),
    DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
    DropdownMenuItem(child: Text("England"), value: "England"),
  ];

  @override
  Widget build(BuildContext context) {
    widget.speechApi.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add by Mic',
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            tooltip: 'Setting to choose language',
            onPressed: () {
              // do something
              //print("Setting to choose language");
              showSettingDialog(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              widget.info,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          AddByMic(info: 'TITLE'),
          AddByMic(info: 'NOTE'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {
          String title =
              Provider.of<SpeechViewModel>(context, listen: false).title;
          String note =
              Provider.of<SpeechViewModel>(context, listen: false).note;

          if (title.isNotEmpty) {
            Provider.of<TasksViewModel>(context, listen: false).addTask(title,
                DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now()), note);
            Provider.of<SpeechViewModel>(context, listen: false).title = '';
            Provider.of<SpeechViewModel>(context, listen: false).note = '';

            Navigator.pop(context);
          } else {
            showErrorDialog(context);
          }
        },
        label: Text('ADD'),
      ),
    );
  }

  void showErrorDialog(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
            content: Text(
              'Title can not be empty',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: [
              OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close')),
            ],
          );
        },
      );

  void showSettingDialog(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 12),
                      Text(
                        'Setting to choose language',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 12),

                      RadioListTile<int>(
                        value: 0,
                        groupValue: selectedValue,
                        title: Text('Bil'),
                        onChanged: (value) =>
                            setState(() => this.selectedValue = value!),
                      ),

                      RadioListTile<int>(
                        value: 1,
                        groupValue: selectedValue,
                        title: Text('Emmma'),
                        onChanged: (value) =>
                            setState(() => this.selectedValue = value!),
                      ),
                      RadioListTile<int>(
                        value: 2,
                        groupValue: selectedValue,
                        title: Text('Kate'),
                        onChanged: (value) =>
                            setState(() => this.selectedValue = value!),
                      ),

                      Container(
                        padding: EdgeInsets.only(
                          left: 5.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: kBorderRadius,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        //--------------------------------
                        // child: DropdownButton(
                        //   value: _currentLocaleId,
                        //   isExpanded: true,
                        //   // items: Provider.of<SpeechViewModel>(context, listen: false)
                        //   //         .getLocaleNames()
                        //   //         .map(menuItem)
                        //   //         .toList(),
                        //   onChanged: (selectedVal) => _switchLang(selectedVal),
                        //
                        //   items: Provider.of<SpeechViewModel>(context, listen: false).getLocaleNames()
                        //       .map(
                        //         (localeName) => DropdownMenuItem(
                        //       value: localeName.name,
                        //       child: Text(localeName.name),
                        //     ),
                        //   )
                        //       .toList(),
                        // ),
                        //-----------------------------------

                        // child: DropdownButton<String>(
                        //   value: selectedItem,
                        //   isExpanded: true,
                        //   items: items.map(menuItem1).toList(),
                        //   onChanged: (item) => setState(() => this.selectedItem = item),
                        // ),
                        //--------
                        // child: DropdownButton<String>(
                        //   value: selectedItem,
                        //   isExpanded: true,
                        //   items: Provider.of<SpeechViewModel>(context, listen: false).getLocaleNames().map(menuItem).toList(),
                        //   onChanged: (item) => setState(() => this.selectedItem = item),
                        // ),
                        //--------

                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            //value: Provider.of<SpeechViewModel>(context, listen: false).getLocatedId(),//selectedItem,
                            value: selectedItem,
                            isExpanded: true,
                            items: menuItems,
                            onChanged: (value) =>
                                setState(() => this.selectedItem = value),
                            //onChanged: (item) => Provider.of<SpeechViewModel>(context, listen: false).setLocatedId(item!),
                          ),
                        ),

                        //----------------------------------
                        /* child: ListView(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        children: [
                          RadioListTile<int>(
                              value: 1,
                              groupValue: selectedValue,
                              title: Text('Emmma'),
                              onChanged: (value) => setState(() => this.selectedValue = 1),
                          ),
                        ],

                      ),*/
                        //-----------
                        /*child:
                          RadioListTile<int>(
                            value: 1,
                            groupValue: selectedValue,
                            title: Text('Emmma'),
                            onChanged: (value) => setState(() => this.selectedValue = 1),
                          ),*/

                        //-----------------
                      ),

                      //------------------
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Close'),
                      ),
                    ]),
              ),
            );
          });
        },
      );

  DropdownMenuItem<String> menuItem(LocaleName localeName) => DropdownMenuItem(
        value: localeName.name,
        child: Text(
          "${localeName.name}: ${localeName.localeId}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

  DropdownMenuItem<String> menuItem1(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }
}

// onChanged: (selectedVal) => _switchLang(selectedVal),
// value: _currentLocaleId,
// items: _localeNames
//     .map(
// (localeName) => DropdownMenuItem(
// value: localeName.localeId,
// child: Text(localeName.name),
// ),
// )
// .toList(),

// actions: [
// OutlinedButton(
// onPressed: () => Navigator.of(context).pop(),
// child: Text('Close')),
// ],
