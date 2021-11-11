import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ItemSlidableWidget extends StatelessWidget {
  final actionName;
  final icon;
  final color;
  final actionFunction;

  const ItemSlidableWidget({
    required this.actionName,
    required this.icon,
    required this.color,
    required this.actionFunction,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: IconSlideAction(
        color: color, //Colors.green,
        onTap: () => actionFunction,
        caption: actionName, //'Edit',
        icon: icon, //Icons.edit,
      ),
    );
  }
}