// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'themebox.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeBoxAdapter extends TypeAdapter<ThemeBox> {
  @override
  final int typeId = 1;

  @override
  ThemeBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThemeBox(
      id: fields[0] as String,
      name: fields[1] as String,
      icon: fields[2] as int,
      brightness: fields[3] as String,
      titleTextFontSize: fields[4] as double,
      subtitleTextFontSize: fields[5] as double,
      textFontSize: fields[6] as double,
      buttonTextFontSize: fields[7] as double,
      cardBorderRadius: fields[8] as double,
      inputBorderRadius: fields[9] as double,
      navbarBorderRadius: fields[10] as double,
      buttonBorderRadius: fields[11] as double,
      textFieldBackgroundColor: fields[12] as String,
      cardBackgroundColor: fields[13] as String,
      overlayBackgroundColor: fields[14] as String,
      backgroundColor: fields[15] as String,
      highlightColor: fields[16] as String,
      overlayForgroundColor: fields[17] as String,
      iconColor: fields[18] as String,
      titleTextColor: fields[19] as String,
      subtitleTextColor: fields[20] as String,
      textColor: fields[21] as String,
      buttonTextColor: fields[22] as String,
      errorColor: fields[23] as String,
      accentColor: fields[24] as String,
      innerHorizontalPadding: fields[26] as double,
      innerVerticalPadding: fields[25] as double,
      outerHorizontalPadding: fields[28] as double,
      outerVerticalPadding: fields[27] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ThemeBox obj) {
    writer
      ..writeByte(29)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.icon)
      ..writeByte(3)
      ..write(obj.brightness)
      ..writeByte(4)
      ..write(obj.titleTextFontSize)
      ..writeByte(5)
      ..write(obj.subtitleTextFontSize)
      ..writeByte(6)
      ..write(obj.textFontSize)
      ..writeByte(7)
      ..write(obj.buttonTextFontSize)
      ..writeByte(8)
      ..write(obj.cardBorderRadius)
      ..writeByte(9)
      ..write(obj.inputBorderRadius)
      ..writeByte(10)
      ..write(obj.navbarBorderRadius)
      ..writeByte(11)
      ..write(obj.buttonBorderRadius)
      ..writeByte(12)
      ..write(obj.textFieldBackgroundColor)
      ..writeByte(13)
      ..write(obj.cardBackgroundColor)
      ..writeByte(14)
      ..write(obj.overlayBackgroundColor)
      ..writeByte(15)
      ..write(obj.backgroundColor)
      ..writeByte(16)
      ..write(obj.highlightColor)
      ..writeByte(17)
      ..write(obj.overlayForgroundColor)
      ..writeByte(18)
      ..write(obj.iconColor)
      ..writeByte(19)
      ..write(obj.titleTextColor)
      ..writeByte(20)
      ..write(obj.subtitleTextColor)
      ..writeByte(21)
      ..write(obj.textColor)
      ..writeByte(22)
      ..write(obj.buttonTextColor)
      ..writeByte(23)
      ..write(obj.errorColor)
      ..writeByte(24)
      ..write(obj.accentColor)
      ..writeByte(25)
      ..write(obj.innerVerticalPadding)
      ..writeByte(26)
      ..write(obj.innerHorizontalPadding)
      ..writeByte(27)
      ..write(obj.outerVerticalPadding)
      ..writeByte(28)
      ..write(obj.outerHorizontalPadding);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
