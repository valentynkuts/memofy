import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:memofy/api/speech_api.dart';
import 'package:memofy/utils/substring_highlighted.dart';
import 'package:memofy/utils/utils.dart';


class MicAddTaskScreen extends StatefulWidget {
  static const String id = 'mic_add_task_screen';

  const MicAddTaskScreen({Key? key}) : super(key: key);

  @override
  _MicAddTaskScreenState createState() => _MicAddTaskScreenState();
}

class _MicAddTaskScreenState extends State<MicAddTaskScreen> {
  String text = 'Press the button and start speaking';
  bool isListening = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Add by Mic'),
      centerTitle: true,

    ),
    body: SingleChildScrollView(
      reverse: true,
      padding: const EdgeInsets.all(30).copyWith(bottom: 150),
      child: SubstringHighlight(
        text: text,
        terms: Command.all,
        textStyle: TextStyle(
          fontSize: 32.0,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        textStyleHighlight: TextStyle(
          fontSize: 32.0,
          color: Colors.red,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: AvatarGlow(
      animate: isListening,
      endRadius: 75,
      glowColor: Theme.of(context).primaryColor,
      child: FloatingActionButton(
        child: Icon(isListening ? Icons.mic : Icons.mic_none, size: 36),
        onPressed: toggleRecording,
      ),
    ),
  );

  Future toggleRecording() => SpeechApi.toggleRecording(
    onResult: (text) => setState(() => this.text = text),
    onListening: (isListening) {
      setState(() => this.isListening = isListening);

      if (!isListening) {
        Future.delayed(Duration(seconds: 1), () {
          Utils.scanText(text, context);
        });
      }
    },
  );
}
