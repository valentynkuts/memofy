import 'package:flutter/cupertino.dart';
import 'package:memofy/view_models/settings/settings_view_model.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:provider/provider.dart';

class SpeechApi {
  static String _langId = '';
  static final _speech = SpeechToText();

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
      _langId = Provider.of<SettingsViewModel>(context, listen: false).getSettings().lang;
      _speech.listen(
          onResult: (value) => onResult(value.recognizedWords),
          localeId: _langId);
    }
    return isAvailable;
  }
}
