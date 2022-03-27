import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechApi {
  static List<LocaleName> _localeNames = [];
  static String _currentLocaleId = '';
  static final _speech = SpeechToText();

  static Future<bool> toggleRecording({
    required Function(String text) onResult,
    required ValueChanged<bool> onListening,
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
      //_localeNames = await _speech.locales();
      // Provider.of<SpeechViewModel>(context, listen: false)
      // _localeNames = await _speech.locales();

      // var systemLocale = await _speech.systemLocale();
      // _currentLocaleId = systemLocale?.localeId ?? '';

      _speech.listen(
          onResult: (value) => onResult(value.recognizedWords),
      );  //  localeId:
    }

    return isAvailable;
  }
}
