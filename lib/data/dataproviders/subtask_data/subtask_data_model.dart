import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:memofy/data/dataproviders/done_task_data/done_task_data_model.dart';
import 'package:memofy/data/dataproviders/subtask_configuration.dart';
import 'package:memofy/data/dataproviders/task_data/task_data_model.dart';
import 'package:memofy/models/subtask/subtask_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memofy/models/task/task_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import '../box_manager.dart';

// logic
class SubtaskDataModel extends ChangeNotifier {


  //String taskKey;
  //SubtaskConfiguration subtaskConfiguration;
  TaskModel taskModel;
  late final Future<Box<SubtaskModel>> _box;
  late final Future<Box<TaskModel>> _boxTask;
  ValueListenable<Object>? _listenableBox;

  SubtaskDataModel({required this.taskModel}) {
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
     final taskKey = taskModel.id;
    _box = BoxManager().openSubtaskBox(taskKey);
     _boxTask = BoxManager().openTaskBox();

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

  bool _isAllSubtaskDone(){
    // every(): Returns true if all elements satisfy the condition.
    return _subtasks.every((el) => el.isDone == true);
  }
  
  Future<void> isTaskDone(BuildContext context) async {
     //_boxTask = BoxManager().openTaskBox();
    TaskModel? task = (await _boxTask).get(taskModel.id);

    _isAllSubtaskDone() ? task!.isDone = true : task!.isDone = false;
    task.save();

    // if(task.isDone){
    //   Provider.of<TaskDataModel>(context, listen: false).tasks.remove(task);
    //   //Provider.of<DoneTaskDataModel>(context, listen: false).doneTasks.add(task);
    // } else{
    //   Provider.of<DoneTaskDataModel>(context, listen: false).doneTasks.remove(task);
    //   //Provider.of<TaskDataModel>(context, listen: false).tasks.add(task);
    // }

    //
    //

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
    //if(_boxTask.){ //TODO
      await BoxManager().closeBox((await _boxTask));
   // }
    super.dispose();
  }



}
