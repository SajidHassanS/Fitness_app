// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plansmodelclass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlansmodelclassAdapter extends TypeAdapter<Plansmodelclass> {
  @override
  final int typeId = 0;

  @override
  Plansmodelclass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Plansmodelclass(
      title: fields[0] as String,
      desc: fields[1] as String,
      exercises: (fields[2] as List).cast<Exercises>(),
    );
  }

  @override
  void write(BinaryWriter writer, Plansmodelclass obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.desc)
      ..writeByte(2)
      ..write(obj.exercises);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlansmodelclassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExercisesAdapter extends TypeAdapter<Exercises> {
  @override
  final int typeId = 1;

  @override
  Exercises read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exercises(
      title: fields[0] as dynamic,
      thumbUrl: fields[1] as dynamic,
      imageUrl: fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Exercises obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.thumbUrl)
      ..writeByte(2)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExercisesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeightchartDataAdapter extends TypeAdapter<WeightchartData> {
  @override
  final int typeId = 2;

  @override
  WeightchartData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeightchartData(
      weight: fields[0] as double,
      date: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, WeightchartData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.weight)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeightchartDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
