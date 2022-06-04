import 'package:flutter/material.dart';

// Courgette
// SourceCodePro

const kTasksStyle = TextStyle(
  fontFamily: 'SourceCodePro',
  color: Colors.white,
  fontSize: 25.0,
);

const kTaskTitleStyle = TextStyle(
  fontFamily: 'SourceCodePro',
  fontStyle: FontStyle.normal,
  fontSize: 20.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const kTaskDateStyle = TextStyle(
  fontFamily: 'SourceCodePro',
  color: Colors.indigo,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.bold,
  fontSize: 17.0,
);

const kTaskNoteStyle = TextStyle(
  fontFamily: 'Courgette',
  fontSize: 25.0,
  color: Colors.black87,
);

const kSubtasksTitleStyle = TextStyle(
  fontFamily: 'SourceCodePro',
  fontStyle: FontStyle.normal,
  fontSize: 20.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const kSubtaskDescriptionStyle = TextStyle(
  fontFamily: 'SourceCodePro',
  fontStyle: FontStyle.normal,
  fontSize: 20.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const mic_color = const  Color(0xffffc000);  // amber 	 Color(0xffffc000)
const kBorderRadius = BorderRadius.all(Radius.circular(10.0));
const appBarColor = const Color(
    0xff6c6c6c); //const Color(0xff276359); //0xff94b9a7 //0xff839973 // 0xff3a6c7f  // 0xff08080 (grey)
const String settings_key = '73489djer8887';
const List<DropdownMenuItem<String>> menuItems = [
  DropdownMenuItem(
      child: Text(
        "Polish",
        style: TextStyle(
            color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      value: "pl_PL"),
  DropdownMenuItem(
      child: Text(
        "English",
        style: TextStyle(
            color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      value: "en_US"),
  DropdownMenuItem(
      child: Text(
        "German",
        style: TextStyle(
            color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      value: "de_DE"),
  DropdownMenuItem(
      child: Text(
        "Ukrainian",
        style: TextStyle(
            color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      value: "uk_UA"),
  DropdownMenuItem(
      child: Text(
        "Russian",
        style: TextStyle(
            color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      value: "ru_RU"),
];
