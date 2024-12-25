// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarDetailsModelMainAdapter extends TypeAdapter<CarDetailsModelMain> {
  @override
  final int typeId = 6;

  @override
  CarDetailsModelMain read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarDetailsModelMain(
      fields[0] as String?,
      (fields[1] as List?)?.cast<CarDetailsModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CarDetailsModelMain obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.carDetailsModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarDetailsModelMainAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CarDetailsModelAdapter extends TypeAdapter<CarDetailsModel> {
  @override
  final int typeId = 7;

  @override
  CarDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarDetailsModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
      cyrillicName: fields[2] as String?,
      clas: fields[3] as String?,
      yearFrom: fields[4] as num?,
      yearTo: fields[5] as num?,
      path: fields[6] as Path?,
      generations: fields[7] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, CarDetailsModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.cyrillicName)
      ..writeByte(3)
      ..write(obj.clas)
      ..writeByte(4)
      ..write(obj.yearFrom)
      ..writeByte(5)
      ..write(obj.yearTo)
      ..writeByte(6)
      ..write(obj.path)
      ..writeByte(7)
      ..write(obj.generations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PathAdapter extends TypeAdapter<Path> {
  @override
  final int typeId = 8;

  @override
  Path read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Path(
      markId: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Path obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.markId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PathAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
