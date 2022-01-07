import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:memofy/data/subtask_service.dart';
import 'package:memofy/models/subtask/subtask_model.dart';
import 'package:memofy/models/task/task_model.dart';

class SubtasksViewModel extends ChangeNotifier {
  TaskModel taskModel;

  final subtaskService = SubtaskService();

  SubtasksViewModel({required this.taskModel}) {
    load();
  }

  var _subtasks = <SubtaskModel>[];

  List<SubtaskModel> get subtasks => _subtasks;

  _readSubtasksFromHive() async {
    _subtasks = await subtaskService.getSubtasks();
    _subtasks.sort((a, b) => a.orderby.compareTo(b.orderby));
    notifyListeners();
  }

  void load() async {
    await subtaskService.load(taskModel.id, _readSubtasksFromHive);
  }

  Future<void> addSubtask(String description) async {
    await subtaskService.addSubtask(subtasks.length, description);

    notifyListeners();
  }

  Future<void> removeSubtask(SubtaskModel subtask) async {
    await subtaskService.removeSubtask(subtask);
    notifyListeners();
  }

  Future<void> updateSubtask(SubtaskModel subtask, String description) async {
    await subtaskService.updateSubtask(subtask, description);
    notifyListeners();
  }

  void toggleSubtaskStatus(SubtaskModel subtask) {
    subtaskService.toggleSubtaskStatus(subtask);
    notifyListeners();
  }

  bool _isAllSubtaskDone() {
    // every(): Returns true if all elements satisfy the condition.
    return _subtasks.every((el) => el.isDone == true);
  }

  Future<void> isTaskDone(BuildContext context) async {
    TaskModel? task = await subtaskService.getTaskByKey(taskModel.id);
    _isAllSubtaskDone() ? task!.isDone = true : task!.isDone = false;
    task.save();
  }

  @override
  void dispose() async {
    await subtaskService.close(_readSubtasksFromHive);
    super.dispose();
  }
}
