import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:memofy/data/dataproviders/subtask_configuration.dart';
import 'package:memofy/models/subtask/subtask_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../box_manager.dart';

// logic
class SubtaskDataModel extends ChangeNotifier {

  //String taskKey;
  SubtaskConfiguration subtaskConfiguration;
  late final Future<Box<SubtaskModel>> _box;
  ValueListenable<Object>? _listenableBox;

  SubtaskDataModel({required this.subtaskConfiguration}) {
    load();
  }

  var _subtasks = <SubtaskModel>[];

  List<SubtaskModel> get subtasks => _subtasks;

  _readSubtasksFromHive() async{
    _subtasks = (await _box).values.toList();
    _subtasks.sort((a, b) => a.orderby.compareTo(b.orderby));
    notifyListeners();
  }

  void load() async {
     final taskKey = subtaskConfiguration.taskKey;
    _box = BoxManager().openSubtaskBox(taskKey);
   // print("load() -> $taskKey box - $_box");

    await _readSubtasksFromHive();
     _listenableBox = (await _box).listenable();
     //(await _box).listenable().addListener(() => _readSubtasksFromHive());
     _listenableBox?.addListener(() => _readSubtasksFromHive());
  }


  Future<void> addSubtask(String description) async {

    int l = _subtasks.length;
    final subtask = SubtaskModel(
        description: description, orderby: l + 1, isDone: false);

    // final box = await _box;
    // final index = await box.add(subtask);

    final index = (await _box).add(subtask);
    print("Added subtask to index: $index");
    //await BoxManager().closeBox(box); // TODO delete
    notifyListeners();
  }

  Future<void> removeSubtask(SubtaskModel subtask) async {
    subtask.delete();
    notifyListeners();
  }
  //
  void searchTask() {
    notifyListeners();
  }

  void updateSubtask(SubtaskModel subtask) {
    //code
    subtask.save();
    notifyListeners();
  }

  void toggleSubtaskStatus(SubtaskModel subtask) {
    subtask.toggleDone();
    subtask.save();
    notifyListeners();
  }

  // @override
  // void dispose() async{
  //   _listenableBox?.removeListener(_readSubtasksFromHive);
  //   await BoxManager().closeBox((await _box));
  //   super.dispose();
  // }

  @override
  Future<void> dispose() async{
    _listenableBox?.removeListener(_readSubtasksFromHive);
    await BoxManager().closeBox((await _box));
    super.dispose();
  }



}
