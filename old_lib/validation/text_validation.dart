import 'package:flutter/material.dart';
import 'package:memofy/validation/validation_item.dart';



class TextValidation with ChangeNotifier {
   ValidationItem _text = ValidationItem('', null);

  ValidationItem get text => _text;

   set text(ValidationItem item){
     _text = item;
   }

  bool get isValid {
    if (_text.error == null && _text.value.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
  
  void changeNewTitle(String value) {
    value = value.trim();
    //if(_newTitle.error!= null && _newTitle.value.isNotEmpty){

    if (value.length >= 1) {
     _text = ValidationItem(value, null);
    } else {
      _text = ValidationItem('', "Title can't be empty");
    }

     notifyListeners();
  }

}

