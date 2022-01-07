// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtask_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubtaskModelAdapter extends TypeAdapter<SubtaskModel> {
  @override
  final int typeId = 1;

  @override
  SubtaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubtaskModel(
      description: fields[0] as String,
      orderby: fields[2] as int,
      isDone: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SubtaskModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.isDone)
      ..writeByte(2)
      ..write(obj.orderby);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubtaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
