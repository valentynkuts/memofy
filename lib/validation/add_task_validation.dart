import 'package:flutter/material.dart';
import 'package:memofy/validation/validation_item.dart';



class AddTaskValidation with ChangeNotifier {
   ValidationItem _newTitle = ValidationItem(null, null);

  ValidationItem get newTitle => _newTitle;

  bool get isValid {
    if (_newTitle.value != null) {
      return true;
    } else {
      return false;
    }
  }


  void changeNewTitle(String value) {
    if (value.length >= 1) {
      _newTitle = ValidationItem(value, null);
    } else {
      _newTitle = ValidationItem(null, "Title can't be empty");
    }

     notifyListeners();
  }

  void submit(){}

}

