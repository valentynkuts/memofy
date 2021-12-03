import 'package:flutter/material.dart';

class TaskValidation extends ChangeNotifier {
  var _title = '';
  String? errorText;

  set title(String value){
    if(errorText != null && value.trim().isNotEmpty){
      errorText = null;
      print("errorText = null");
      notifyListeners();
    }
    _title = value;
  }

  String get title {
    return _title;
  }


  bool get isValid{
    final title = _title.trim();
    if(title.isEmpty){
      errorText = "Title can't be empty";
      print(errorText);
      notifyListeners();
      print("false");
      return false;
    }
    print("true");
    return true;
  }
}