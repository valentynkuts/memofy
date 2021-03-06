import 'package:hive/hive.dart';
import 'package:memofy/models/settings/settings.dart';
import 'package:memofy/models/subtask/subtask_model.dart';
import 'package:memofy/models/task/task_model.dart';

// Automatic Reference Counting (ARC)
// https://en.wikipedia.org/wiki/Automatic_Reference_Counting

class BoxManager {
  // 1 - String - name of box
  // 2 - int - amount of closing and opening box
  final Map<String, int> _counterBox = <String, int>{};

  static final BoxManager _singleton = BoxManager._();

  factory BoxManager() => _singleton;

  // private constructor
  BoxManager._();

  // ARC
  Future<Box<T>> _openBox<T>(
    String name,
    int typeId,
    TypeAdapter<T> adapter,
  ) async {
    // counting how many box is opened
    if (Hive.isBoxOpen(name)) {
      final count = _counterBox[name] ?? 1;
      _counterBox[name] = count + 1;
      return Hive.box(name);
    }
    //if it closed
    _counterBox[name] = 1;
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }
    return Hive.openBox<T>(name);
  }

  Future<Box<TaskModel>> openTaskBox() async {
    return _openBox('tasks7', 0, TaskModelAdapter());
  }

  String makeSubtaskBoxName(String taskKey) => 'subtask_box_$taskKey';

  Future<Box<SubtaskModel>> openSubtaskBox(String taskKey) async {
    return _openBox(makeSubtaskBoxName(taskKey), 1, SubtaskModelAdapter());
  }

  Future<Box<Settings>> openSettingsBox() async {
    return _openBox('settings1', 2, SettingsAdapter());
  }

  // ARC
  Future<void> closeBox<T>(Box<T> box) async {
    if (!box.isOpen) {
      _counterBox.remove(box.name);
      return;
    }
    var count = _counterBox[box.name] ?? 1;
    count -= 1;
    _counterBox[box.name] = count;
    if (count > 0) return;

    // if count == 0
    // amount of opening ang closing is the same, so box will be closed
    _counterBox.remove(box.name);
    //Sooner or later, the box file uses more disk space than it should.
    // Hive may automatically "compact" your box at any time to close the "holes" in the file.
    await box.compact();
    await box.close();
  }
}
