// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userbox.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserBoxAdapter extends TypeAdapter<UserBox> {
  @override
  final int typeId = 2;

  @override
  UserBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserBox(
      firstName: fields[0] as String,
      lastName: fields[1] as String,
      email: fields[2] as String,
      shareEmail: fields[3] as bool,
      phoneNumber: fields[4] as int,
      sharePhoneNumber: fields[5] as bool,
      allowNotifications: fields[6] as bool,
      hasEditedFirstName: fields[7] as bool,
      hasEditedLastName: fields[8] as bool,
      hasEditedEmail: fields[9] as bool,
      hasEditedPhoneNumber: fields[10] as bool,
      hasEditedToggleSettings: fields[11] as bool,
      hasFinishedProfileSetup: fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserBox obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.shareEmail)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.sharePhoneNumber)
      ..writeByte(6)
      ..write(obj.allowNotifications)
      ..writeByte(7)
      ..write(obj.hasEditedFirstName)
      ..writeByte(8)
      ..write(obj.hasEditedLastName)
      ..writeByte(9)
      ..write(obj.hasEditedEmail)
      ..writeByte(10)
      ..write(obj.hasEditedPhoneNumber)
      ..writeByte(11)
      ..write(obj.hasEditedToggleSettings)
      ..writeByte(12)
      ..write(obj.hasFinishedProfileSetup);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
