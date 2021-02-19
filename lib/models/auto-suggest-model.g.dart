// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto-suggest-model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AutoSuggestAdapter extends TypeAdapter<AutoSuggest> {
  @override
  final int typeId = 7;

  @override
  AutoSuggest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AutoSuggest(
      type: fields[0] as SwipeServiceOffering,
    );
  }

  @override
  void write(BinaryWriter writer, AutoSuggest obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AutoSuggestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BuyLoadSuggestAdapter extends TypeAdapter<BuyLoadSuggest> {
  @override
  final int typeId = 8;

  @override
  BuyLoadSuggest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BuyLoadSuggest(
      mobileNumber: fields[1] as String,
      type: fields[0] as SwipeServiceOffering,
    );
  }

  @override
  void write(BinaryWriter writer, BuyLoadSuggest obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.mobileNumber)
      ..writeByte(0)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuyLoadSuggestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AccountRecipientAdapter extends TypeAdapter<AccountRecipient> {
  @override
  final int typeId = 9;

  @override
  AccountRecipient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountRecipient(
      fullname: fields[2] as String,
      accountNumber: fields[3] as String,
      type: fields[0] as SwipeServiceOffering,
    );
  }

  @override
  void write(BinaryWriter writer, AccountRecipient obj) {
    writer
      ..writeByte(3)
      ..writeByte(2)
      ..write(obj.fullname)
      ..writeByte(3)
      ..write(obj.accountNumber)
      ..writeByte(0)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountRecipientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
