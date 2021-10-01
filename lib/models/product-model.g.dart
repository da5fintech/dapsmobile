// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product-model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 5;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      code: fields[7] as String,
      name: fields[6] as String,
      amount: fields[8] as double,
      description: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.code)
      ..writeByte(8)
      ..write(obj.amount)
      ..writeByte(9)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class KeyValuePairAdapter extends TypeAdapter<KeyValuePair> {
  @override
  final int typeId = 3;

  @override
  KeyValuePair read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KeyValuePair(
      key: fields[0] as String,
      value: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, KeyValuePair obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KeyValuePairAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BillerFieldAdapter extends TypeAdapter<BillerField> {
  @override
  final int typeId = 2;

  @override
  BillerField read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BillerField(
      label: fields[0] as String,
      field: fields[1] as String,
      fieldType: fields[2] as BillerFieldType,
      isRequired: fields[3] as bool,
      value: fields[4] as dynamic,
      defaultValue: fields[5] as dynamic,
      options: (fields[6] as List)?.cast<KeyValuePair>(),
    );
  }

  @override
  void write(BinaryWriter writer, BillerField obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.field)
      ..writeByte(2)
      ..write(obj.fieldType)
      ..writeByte(3)
      ..write(obj.isRequired)
      ..writeByte(4)
      ..write(obj.value)
      ..writeByte(5)
      ..write(obj.defaultValue)
      ..writeByte(6)
      ..write(obj.options);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillerFieldAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BillerProductAdapter extends TypeAdapter<BillerProduct> {
  @override
  final int typeId = 1;

  @override
  BillerProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BillerProduct(
      enabled: fields[0] as bool,
      code: fields[7] as String,
      name: fields[6] as String,
      amount: fields[8] as double,
      description: fields[9] as String,
    )
      ..type = fields[1] as String
      ..fee = fields[2] as double
      ..logo = fields[3] as String
      ..category = fields[4] as String
      ..fields = (fields[5] as List)?.cast<BillerField>();
  }

  @override
  void write(BinaryWriter writer, BillerProduct obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.enabled)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.fee)
      ..writeByte(3)
      ..write(obj.logo)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.fields)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.code)
      ..writeByte(8)
      ..write(obj.amount)
      ..writeByte(9)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillerProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BillerFieldTypeAdapter extends TypeAdapter<BillerFieldType> {
  @override
  final int typeId = 4;

  @override
  BillerFieldType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BillerFieldType.TEXT;
      case 1:
        return BillerFieldType.NUMBER;
      case 2:
        return BillerFieldType.CALENDAR;
      case 3:
        return BillerFieldType.DROPDOWN;
      default:
        return BillerFieldType.TEXT;
    }
  }

  @override
  void write(BinaryWriter writer, BillerFieldType obj) {
    switch (obj) {
      case BillerFieldType.TEXT:
        writer.writeByte(0);
        break;
      case BillerFieldType.NUMBER:
        writer.writeByte(1);
        break;
      case BillerFieldType.CALENDAR:
        writer.writeByte(2);
        break;
      case BillerFieldType.DROPDOWN:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillerFieldTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
