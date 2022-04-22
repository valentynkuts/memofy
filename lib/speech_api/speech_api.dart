import 'package:flutter/cupertino.dart';
import 'package:memofy/view_models/speech/speech_view_model.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:provider/provider.dart';

// enum lang{
//   poland("pl_PL");
// }
class SpeechApi {
  //static List<LocaleName> _localeNames = [];
  static String _currentLocaleId = '';
  static final _speech = SpeechToText();

 /* void init(BuildContext context) async {
    _localeNames = await _speech.locales();
    for(var ln in _localeNames){
      print(ln.name);
    }

    //print(_localeNames["af_ZA"]);

    Provider.of<SpeechViewModel>(context, listen: false).setLocaleNames(_localeNames);
    // //_localeNames = await _speech.locales();
    // print(_localeNames);
    // var systemLocale = await _speech.systemLocale();
    // _currentLocaleId = systemLocale?.localeId ?? '';
    // print(_currentLocaleId);
  }*/

  static Future<bool> toggleRecording({
    required Function(String text) onResult,
    required ValueChanged<bool> onListening,
    required BuildContext context,
  }) async {

    if (_speech.isListening) {
      _speech.stop();
      return true;
    }

    final isAvailable = await _speech.initialize(
      onStatus: (status) => onListening(_speech.isListening),
      onError: (e) => print('Error : $e'),
    );

    if (isAvailable) {
      _currentLocaleId = Provider.of<SpeechViewModel>(context, listen: false).getLocatedId();
      _speech.listen(
          onResult: (value) => onResult(value.recognizedWords),
          localeId: _currentLocaleId);
    }

    return isAvailable;
  }
}
