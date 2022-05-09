import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechViewModel extends ChangeNotifier {
  static const String TITLE = 'TITLE';
  static const String NOTE = 'NOTE';
  String _title = '';
  String _note = '';

  static List<LocaleName> _localeNames = []; //
  String _langId = ''; //

  void setData(String info, String data) {
    if (info == TITLE) {
      _title = data;
    } else if (info == NOTE) {
      _note = data;
    }
    notifyListeners();
  }

  String getData(String info) {
    if (info == TITLE) {
      return _title;
    } else if (info == NOTE) {
      return _note;
    }
    return '';
  }

  String get title {
    return _title;
  }

  String get note {
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
//
  void setLocaleNames(List<LocaleName> localNames){
    _localeNames = localNames;
    // print("----------------------------------------");
    // for(var ln in _localeNames){
    //   print(ln.name);
    // }
    notifyListeners();
  }
//
  List<LocaleName> getLocaleNames(){
    return _localeNames;
  }
//
  void setLangId(String _langId){
    this._langId = _langId;

    print(_langId);
    notifyListeners();
  }
  //
  String getLangId(){
    return _langId;
  }
}
