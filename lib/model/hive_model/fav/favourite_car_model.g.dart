// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_car_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteCarAdapter extends TypeAdapter<FavoriteCar> {
  @override
  final int typeId = 4;

  @override
  FavoriteCar read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteCar(
      id: fields[0] as int?,
      brandName: fields[1] as String?,
      location: fields[2] as String?,
      brandingType: fields[3] as String?,
      duration: fields[4] as String?,
      price: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteCar obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.brandName)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.brandingType)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteCarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
