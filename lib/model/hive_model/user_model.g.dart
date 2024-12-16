// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 3;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int?,
      name: fields[1] as String?,
      phone: fields[2] as String?,
      phoneVerifyToken: fields[3] as dynamic,
      isPhoneVerified: fields[4] as int?,
      phoneVerifiedAt: fields[5] as dynamic,
      phoneVerifyExpire: fields[6] as dynamic,
      email: fields[7] as String?,
      emailVerifyToken: fields[8] as dynamic,
      isEmailVerified: fields[9] as int?,
      emailVerifiedAt: fields[10] as dynamic,
      emailVerifyExpire: fields[11] as dynamic,
      avatarId: fields[12] as dynamic,
      type: fields[13] as String?,
      statusId: fields[14] as int?,
      isBanned: fields[15] as int?,
      bannedAt: fields[16] as dynamic,
      unbannedAt: fields[17] as dynamic,
      lastLoginAt: fields[18] as dynamic,
      lastLogoutAt: fields[19] as dynamic,
      lastLoginIp: fields[20] as dynamic,
      loginAccess: fields[21] as int?,
      deletedAt: fields[22] as dynamic,
      createdAt: fields[23] as DateTime?,
      updatedAt: fields[24] as DateTime?,
      avatar: fields[25] as String?,
      accessToken: fields[26] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(27)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.phoneVerifyToken)
      ..writeByte(4)
      ..write(obj.isPhoneVerified)
      ..writeByte(5)
      ..write(obj.phoneVerifiedAt)
      ..writeByte(6)
      ..write(obj.phoneVerifyExpire)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.emailVerifyToken)
      ..writeByte(9)
      ..write(obj.isEmailVerified)
      ..writeByte(10)
      ..write(obj.emailVerifiedAt)
      ..writeByte(11)
      ..write(obj.emailVerifyExpire)
      ..writeByte(12)
      ..write(obj.avatarId)
      ..writeByte(13)
      ..write(obj.type)
      ..writeByte(14)
      ..write(obj.statusId)
      ..writeByte(15)
      ..write(obj.isBanned)
      ..writeByte(16)
      ..write(obj.bannedAt)
      ..writeByte(17)
      ..write(obj.unbannedAt)
      ..writeByte(18)
      ..write(obj.lastLoginAt)
      ..writeByte(19)
      ..write(obj.lastLogoutAt)
      ..writeByte(20)
      ..write(obj.lastLoginIp)
      ..writeByte(21)
      ..write(obj.loginAccess)
      ..writeByte(22)
      ..write(obj.deletedAt)
      ..writeByte(23)
      ..write(obj.createdAt)
      ..writeByte(24)
      ..write(obj.updatedAt)
      ..writeByte(25)
      ..write(obj.avatar)
      ..writeByte(26)
      ..write(obj.accessToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
