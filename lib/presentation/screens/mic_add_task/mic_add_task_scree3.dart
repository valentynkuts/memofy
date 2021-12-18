// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:memofy/api/speech_api.dart';
// import 'package:memofy/data/dataproviders/task_data/task_data_model.dart';
// import 'package:memofy/utils/substring_highlighted.dart';
// import 'package:memofy/utils/utils.dart';
// import 'package:provider/provider.dart';
// import 'package:speech_to_text/speech_to_text.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
//
// class MicAddTaskScreen extends StatefulWidget {
//   static const String id = 'mic_add_task_screen';
//
//   MicAddTaskScreen({Key? key}) : super(key: key);
//
//   @override
//   _MicAddTaskScreenState createState() => _MicAddTaskScreenState();
// }
//
// class _MicAddTaskScreenState extends State<MicAddTaskScreen> {
//   //String text = 'Press the button and start speaking';
//   String text0 = 'Former Manchester City defender Micah Richards: '
//       'From the moment he came through the door, you are in awe. You have that feeling of .'
//       ' The only other time I had that was when Robinho came through the door. For us growing up,'
//       ' Shaun Goater or Nicolas Anelka was a big thing - so when Aguero comes, you cant '
//       'believe this is happening.';
//   String text1 = 'Former Manchester City defender Micah Richards: '
//       'From the moment he came through the door, you are in awe. You have that feeling of .'
//       'believe this is happening.';
//
//   String text2 =
//       'Former Manchester City defender Micah Richards efrertre ytyrytry erty wty';
//   String info = 'Press the button and start speaking';
//
//   String title = 'TITLE';
//   String note = 'NOTE';
//
//   String text = 'Press the button and start speaking';
//   bool isListening = false;
//
//   SpeechToText _speechToText = SpeechToText();
//   bool _speechEnabled = false;
//
//   String result_text = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _initSpeech();
//   }
//
//   /// This has to happen only once per app
//   void _initSpeech() async {
//     _speechEnabled = await _speechToText.initialize(
//       onStatus: (status) => print('VK OoooK'),
//       onError: (e) => print('Error VK: $e'),
//     );
//     setState(() {});
//   }
//
//   /// Each time to start a speech recognition session
//   void _startListening() async {
//     await _speechToText.listen(onResult: _onSpeechResult);
//     setState(() {
//       title = result_text;
//     });
//   }
//
//   /// Manually stop the active speech recognition session
//   /// Note that there are also timeouts that each platform enforces
//   /// and the SpeechToText plugin supports setting timeouts on the
//   /// listen method.
//   void _stopListening() async {
//     await _speechToText.stop();
//     setState(() {});
//   }
//
//   /// This is the callback that the SpeechToText plugin calls when
//   /// the platform returns recognized words.
//   void _onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       result_text = result.recognizedWords;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Add by Mic',
//           ),
//           centerTitle: true,
//         ),
//         body: ListView(
//           children: [
//             Container(
//               padding: EdgeInsets.all(10.0),
//               margin: const EdgeInsets.all(10.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.black),
//                 //const
//                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 // const  Radius.circular(10.0)
//               ),
//               child: Text(
//                 info,
//                 style: TextStyle(
//                   fontSize: 25.0,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.all(10.0),
//               margin: const EdgeInsets.all(10.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.black),
//                 //const
//                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 // const  Radius.circular(10.0)
//               ),
//               child: Column(
//                 children: [
//                   Text(text,
//                     style: TextStyle(
//                       fontSize: 25.0,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   SizedBox(height: 25.0),
//
//                   AvatarGlow(
//                     animate: isListening,
//                     endRadius: 75,
//                     glowColor: Theme.of(context).primaryColor,
//                     child: FloatingActionButton.extended(
//                       icon:Icon(isListening ? Icons.mic : Icons.mic_none, size: 36),
//                       onPressed: toggleRecording,
//                       label: Text('TITLE'),
//                     ),
//                   ),
//
//
//
//
//
//                   // onPressed: () {
//                   //   // _speechToText.isNotListening ? _startListening : _stopListening;
//                   //   // print("mic is pressed");
//                   //   // print(_speechToText.isNotListening);
//                   //   toggleRecording;
//                   // },
//                   // //icon: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
//                   // icon:Icon(isListening ? Icons.mic : Icons.mic_none, size: 36),
//                   // label: Text(text),
//
//                 ],
//               ),
//             ),
//             //AddByMic(note),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton.extended(
//           onPressed: () {
//             // TODO
//             Provider.of<TaskDataModel>(context, listen: false).addTask(
//                 text, DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now()), "");
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.add),
//           label: Text('ADD TASK'),
//         ),
//       );
//
//   Future toggleRecording() => SpeechApi.toggleRecording(
//         onResult: (text) => setState(() => this.text = text),
//         onListening: (isListening) {
//           setState(() => this.isListening = isListening);
//
//           if (!isListening) {
//             Future.delayed(Duration(seconds: 1), () {
//               Utils.scanText(text, context);
//             });
//           }
//         },
//       );
//
//   Widget AddByMic(String text) => Container(
//         padding: EdgeInsets.all(10.0),
//         margin: const EdgeInsets.all(10.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: Colors.black),
//           //const
//           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//           // const  Radius.circular(10.0)
//         ),
//         child: Column(
//           children: [
//             Text(
//               //text,
//               // If listening is active show the recognized words
//               _speechToText.isListening
//                   ? text
//                   // If listening isn't active but could be tell the user
//                   // how to start it, otherwise indicate that speech
//                   // recognition is not yet ready or not supported on
//                   // the target device
//                   : _speechEnabled
//                       ? 'Tap the microphone to start listening...'
//                       : 'Speech not available',
//               style: TextStyle(
//                 fontSize: 25.0,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             SizedBox(height: 25.0),
//
//               AvatarGlow(
//                 animate: isListening,
//                 endRadius: 75,
//                 glowColor: Theme.of(context).primaryColor,
//                 child: FloatingActionButton.extended(
//                   icon:Icon(isListening ? Icons.mic : Icons.mic_none, size: 36),
//                   onPressed: toggleRecording,
//                   label: Text(text),
//                 ),
//               ),
//
//
//
//
//
//               // onPressed: () {
//               //   // _speechToText.isNotListening ? _startListening : _stopListening;
//               //   // print("mic is pressed");
//               //   // print(_speechToText.isNotListening);
//               //   toggleRecording;
//               // },
//               // //icon: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
//               // icon:Icon(isListening ? Icons.mic : Icons.mic_none, size: 36),
//               // label: Text(text),
//
//           ],
//         ),
//       );
// }
//
// // class AddByMic extends StatelessWidget {
// //   final String text;
// //   SpeechToText speechToText;
// //
// //   AddByMic({required this.text, required this.speechToText, Key? key})
// //       : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: EdgeInsets.all(10.0),
// //       margin: const EdgeInsets.all(10.0),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         border: Border.all(color: Colors.black),
// //         //const
// //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
// //         // const  Radius.circular(10.0)
// //       ),
// //       child: Column(
// //         children: [
// //           Text(
// //             //text,
// //             // If listening is active show the recognized words
// //             speechToText.isListening
// //                 ? '$text'
// //                 // If listening isn't active but could be tell the user
// //                 // how to start it, otherwise indicate that speech
// //                 // recognition is not yet ready or not supported on
// //                 // the target device
// //                 : _speechEnabled
// //                     ? 'Tap the microphone to start listening...'
// //                     : 'Speech not available',
// //             style: TextStyle(
// //               fontSize: 25.0,
// //               color: Colors.black,
// //               fontWeight: FontWeight.w400,
// //             ),
// //           ),
// //           SizedBox(height: 25.0),
// //           FloatingActionButton.extended(
// //             onPressed: () {
// //               print("Mic title pressed");
// //             },
// //             icon: Icon(Icons.mic),
// //             label: Text(text),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //}
