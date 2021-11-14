// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      title: fields[0] as String,
      data: fields[1] as String,
      note: fields[2] as String,
      orderby: fields[5] as int,
      isDone: fields[3] as bool,
    )..subtasks = (fields[4] as HiveList?)?.castHiveList();
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.isDone)
      ..writeByte(4)
      ..write(obj.subtasks)
      ..writeByte(5)
      ..write(obj.orderby);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
