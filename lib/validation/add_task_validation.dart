import 'package:flutter/material.dart';
import 'package:memofy/validation/validation_item.dart';



class TextValidation with ChangeNotifier {
   ValidationItem _text = ValidationItem('', null);

  ValidationItem get text => _text;

   set text(ValidationItem item){
     _text = item;
   }

   // set newTitle(String value){
   //   if(_newTitle.error!= null && _newTitle.value!.trim().isNotEmpty){
   //     _newTitle.error = null;
   //     notifyListeners();
   //   }
   //   _newTitle.value = value;
   // }

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
      //_newTitle = ValidationItem(value, null);
     _text = ValidationItem(value, null);
    } else {
      //_newTitle = ValidationItem('', "Title can't be empty");
      _text = ValidationItem('', "Title can't be empty");
    }

     notifyListeners();




    // if(_newTitle.error!= null && _newTitle.value!.trim().isNotEmpty){
    //   //_newTitle.error = null;
    //   _newTitle = ValidationItem(value, null);
    //   //notifyListeners();
    // }
    // _newTitle = ValidationItem(null, "Title can't be empty");
    // //_newTitle.value = value;
    //
    // notifyListeners();
  }

  void submit(){}

}

