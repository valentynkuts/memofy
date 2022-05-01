import 'package:flutter/material.dart';

// const kTempTextStyle = TextStyle(
//   fontFamily: 'Spartan MB',
//   fontSize: 100.0,
// );

const kBorderRadius = BorderRadius.all(Radius.circular(10.0));
const appBarColor = const Color(0xff6c6c6c);//const Color(0xff276359); //0xff94b9a7 //0xff839973 // 0xff3a6c7f  // 0xff08080 (grey)
const String settings_key = '73489djer8887';
const List<DropdownMenuItem<String>> menuItems = [
  DropdownMenuItem(child: Text("Polish", style: TextStyle(color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.bold),), value: "pl_PL"),
  DropdownMenuItem(child: Text("English", style: TextStyle(color: Colors.grey, fontSize: 20.0,fontWeight: FontWeight.bold),), value: "en_US"),
  DropdownMenuItem(child: Text("German",style: TextStyle(color: Colors.grey, fontSize: 20.0,fontWeight: FontWeight.bold),), value: "de_DE"),
  DropdownMenuItem(child: Text("Ukrainian", style: TextStyle(color: Colors.grey, fontSize: 20.0,fontWeight: FontWeight.bold),), value: "uk_UA"),
  DropdownMenuItem(child: Text("Russian", style: TextStyle(color: Colors.grey, fontSize: 20.0,fontWeight: FontWeight.bold),), value: "ru_RU"),
];
