import 'package:hive/hive.dart';
import 'package:memofy/models/subtask/subtask_model.dart';
import 'package:memofy/models/task/task_model.dart';

class BoxManager{
  static final BoxManager _singleton = BoxManager._();

  factory BoxManager() => _singleton;

  // private constructor
  BoxManager._();

  Future<Box<TaskModel>> openTaskBox() async{
    //return _openBox('tasks_box', 0, TaskModelAdapter());
    return _openBox('tasks3', 0, TaskModelAdapter());
  }

  Future<Box<SubtaskModel>> openSubtaskBox(String taskKey) async{
    return _openBox(makeSubtaskBoxName(taskKey), 1, SubtaskModelAdapter());
  }

  String makeSubtaskBoxName(String taskKey) => 'subtask_box_$taskKey';

  Future<void> closeBox<T>(Box<T> box) async{
    await box.compact();
    await box.close();
  }

  Future<Box<T>>_openBox<T>(
      String name,
      int typeId,
      TypeAdapter<T> adapter,
      ) async{
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }
    print(Hive.openBox<T>(name)); // TODO delete
    return Hive.openBox<T>(name);
  }

}