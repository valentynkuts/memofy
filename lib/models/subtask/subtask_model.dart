import 'package:hive/hive.dart';

part 'subtask_model.g.dart';

@HiveType(typeId: 1)
class SubtaskModel extends HiveObject {
  @HiveField(0)
  String description;

  @HiveField(1)
  bool isDone;

  @HiveField(2)
  int orderby;

  SubtaskModel({required this.description, required this.orderby, this.isDone = false});

  @override
  String toString() {
    return 'SubtaskModel{title: $description, orderby: $orderby';
  }

  void toggleDone() {
    isDone = !isDone;
  }
}
