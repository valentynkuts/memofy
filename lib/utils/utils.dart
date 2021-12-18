

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memofy/data/dataproviders/task_data/task_data_model.dart';
import 'package:provider/provider.dart';


class Command {
  static final all = [title, note];

  static const title = 'раз';
  static const note = 'привет';
  //static const browser2 = 'go to';
}

class Utils {
  static void scanText(String rawText, BuildContext context) {
    final text = rawText.toLowerCase();

    if (text.contains(Command.title)) {
      var title = '';
      title = _getTextAfterCommand(text: text, command: Command.title)!;

      // TODO
      Provider.of<TaskDataModel>(context, listen: false).addTask(
          title, DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now()), "");

     // openEmail(body: body);
      print(title);
    } else if (text.contains(Command.note)) {
      final note = _getTextAfterCommand(text: text, command: Command.note);


      //openLink(url: url);
      print(note);
    }
  }

  static String? _getTextAfterCommand({
    required String text,
    required String command,
  }) {
    final indexCommand = text.indexOf(command);
    final indexAfter = indexCommand + command.length;

    if (indexCommand == -1) {
      //return null;  //todo
      return null;
    } else {
      return text.substring(indexAfter).trim();
    }
  }

  // static Future openLink({
  //   required String? url,
  // }) async {
  //   if (url!.trim().isEmpty) {
  //     await _launchUrl('https://google.com');
  //   } else {
  //     await _launchUrl('https://$url');
  //   }
  // }

  // static Future openEmail({
  //   required String? body,
  // }) async {
  //   final url = 'mailto: ?body=${Uri.encodeFull(body!)}';
  //   await _launchUrl(url);
  // }

  // static Future _launchUrl(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   }
  // }
}
