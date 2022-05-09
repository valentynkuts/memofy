import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/speech_api/speech_api.dart';
import 'package:memofy/view_models/speech/speech_view_model.dart';
import 'package:provider/provider.dart';

class AddByMic extends StatefulWidget {
  String info;
  bool isListening = false;

  AddByMic({required this.info, Key? key}) : super(key: key);

  @override
  _AddByMicState createState() => _AddByMicState();
}

class _AddByMicState extends State<AddByMic> {
  @override
  Widget build(BuildContext context) {
    String text = Provider.of<SpeechViewModel>(context, listen: true)
        .getData(widget.info);

    return Container(
      padding: EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        children: [
          Text(
            text,
            style: kTaskTitleStyle,
            // style: TextStyle(
            //   fontSize: 25.0,
            //   color: Colors.black,
            //   fontWeight: FontWeight.w400,
            // ),
          ),
          AvatarGlow(
            animate: widget.isListening,
            endRadius: 65,
            glowColor: Theme.of(context).primaryColor,
            child: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: mic_color,
              heroTag: widget.info,
              icon: Icon(widget.isListening ? Icons.mic : Icons.mic_none,
                  size: 36),
              onPressed: toggleRecording,
              label: Text(widget.info),
            ),
          ),
        ],
      ),
    );
  }

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() =>
            Provider.of<SpeechViewModel>(context, listen: false)
                .setData(widget.info, text)),
        onListening: (isListening) {
          setState(() => widget.isListening = isListening);
        },
        context: context,
      );
}
