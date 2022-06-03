import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/presentation/widgets/mic/add_by_mic.dart';
import 'package:memofy/speech_api/speech_api.dart';
import 'package:memofy/view_models/settings/settings_view_model.dart';
import 'package:memofy/view_models/speech/speech_view_model.dart';
import 'package:memofy/view_models/task/task_view_model.dart';
import 'package:provider/provider.dart';

class MicAddTaskScreen extends StatefulWidget {
  static const String id = 'mic_add_task_screen';
  String info = 'Press the button and start speaking';

  MicAddTaskScreen({Key? key}) : super(key: key);

  @override
  _MicAddTaskScreenState createState() => _MicAddTaskScreenState();
}

class _MicAddTaskScreenState extends State<MicAddTaskScreen> {
  String? selectedItem = '';
  //---todo---------
  String dateDo = "";
  List dateTimeDo = [];

  @override
  void initState() {
    super.initState();
    Provider.of<SettingsViewModel>(context, listen: false).getSettings();
    Provider.of<SpeechViewModel>(context, listen: false).title = '';
    Provider.of<SpeechViewModel>(context, listen: false).note = '';
    selectedItem = "pl_PL";
    dateDo = DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now());
    dateTimeDo = dateDo.split(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add by Mic', style: kTasksStyle,),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            tooltip: 'Setting to choose language',
            onPressed: () {
              selectedItem =
                  Provider.of<SettingsViewModel>(context, listen: false)
                      .getSettings()
                      .lang;
              // print(Provider.of<SettingsViewModel>(context, listen: false)
              //     .getSettings()
              //     .lang);
              showSettingDialog(context);
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0), //todo
        children: [
          Container(
            //padding: EdgeInsets.all(10.0),
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
          //---------------------
          SizedBox(height: 5.0),
          Container(
            //padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text('To: ',
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),),
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
          ),
          //------------------------------------------
          SizedBox(height: 15.0),
          ElevatedButton(
            child: Text('Submit'),
            onPressed:() {
              String title =
                      Provider.of<SpeechViewModel>(context, listen: false).title;
                  String note =
                      Provider.of<SpeechViewModel>(context, listen: false).note;

                  if (title.isNotEmpty) {
                    dateDo = dateTimeDo[0] + ' ' + dateTimeDo[1];
                    Provider.of<TasksViewModel>(context, listen: false).addTask(title,
                        dateDo,
                        DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now()), note);  // todo
                    Provider.of<SpeechViewModel>(context, listen: false).title = '';
                    Provider.of<SpeechViewModel>(context, listen: false).note = '';

                    Navigator.pop(context);
                  } else {
                    showErrorDialog(context);
                  }
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(130, 50),
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          //----------------
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(10),
      //   ),
      //   backgroundColor: Colors.green,
      //   onPressed: () {
      //     String title =
      //         Provider.of<SpeechViewModel>(context, listen: false).title;
      //     String note =
      //         Provider.of<SpeechViewModel>(context, listen: false).note;
      //
      //     if (title.isNotEmpty) {
      //       dateDo = dateTimeDo[0] + ' ' + dateTimeDo[1];
      //       Provider.of<TasksViewModel>(context, listen: false).addTask(title,
      //           dateDo,
      //           DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now()), note);  // todo
      //       Provider.of<SpeechViewModel>(context, listen: false).title = '';
      //       Provider.of<SpeechViewModel>(context, listen: false).note = '';
      //
      //       Navigator.pop(context);
      //     } else {
      //       showErrorDialog(context);
      //     }
      //   },
      //   label: Text('ADD'),
      // ),
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
                        'CHOOSE LANGUAGE', //'CHOOSE LANGUAGE'
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.only(
                          left: 5.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: kBorderRadius,
                          border: Border.all(color: Colors.grey, width: 3),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              value: this.selectedItem,
                              isExpanded: true,
                              items: menuItems,
                              onChanged: (item) {
                                setState(() {
                                  this.selectedItem = item;
                                });
                                Provider.of<SettingsViewModel>(context,
                                        listen: false)
                                    .updateSettingsLang(this.selectedItem!);
                              }),
                        ),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.close),
                        label: Text("CLOSE"),
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(250, 45),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            primary: Colors.grey,
                            //padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            textStyle:
                            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ]),
              ),
            );
          });
        },
      );
}
