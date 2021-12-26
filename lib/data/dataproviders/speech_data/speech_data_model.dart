import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:memofy/data/dataproviders/box_manager.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';


class SpeechViewModel extends ChangeNotifier {

  static const String TITLE = 'TITLE';
  static const String NOTE = 'NOTE';
  String _title = '';
  String _note = '';


  void setData(String info, String data){
    if(info == TITLE ){
       _title = data;
    } else if(info == NOTE){
       _note = data;
    }
    notifyListeners();
  }

  String getData(String info){
    if(info == TITLE ){
      return _title;
    } else if(info == NOTE){
      return _note;
    }
    return '';
    //notifyListeners();
  }

  String get title{
    return _title;
  }

  String get note{
    return _note;
  }

  void set title(String title) {
    _title = title;
    notifyListeners();
  }

  void set note(String note) {
    _note = note;
    notifyListeners();
  }


}
