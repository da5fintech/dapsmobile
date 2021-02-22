// GENERATED CODE - DO NOT MODIFY BY HAND

part of constants;

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SwipeServiceOfferingAdapter extends TypeAdapter<SwipeServiceOffering> {
  @override
  final int typeId = 10;

  @override
  SwipeServiceOffering read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SwipeServiceOffering.BUY_LOAD;
      case 1:
        return SwipeServiceOffering.CASH_IN;
      case 2:
        return SwipeServiceOffering.PAY_QR;
      case 3:
        return SwipeServiceOffering.DIRECT_SEND;
      case 4:
        return SwipeServiceOffering.REMITTANCE;
      case 5:
        return SwipeServiceOffering.REMITTANCE_INSTAPAY;
      case 6:
        return SwipeServiceOffering.BILLS_PAYMENT;
      case 7:
        return SwipeServiceOffering.INSURANCE;
      case 8:
        return SwipeServiceOffering.BANK_TRANSFER;
      case 9:
        return SwipeServiceOffering.REQUEST_MONEY;
      case 10:
        return SwipeServiceOffering.AUTOSWEEP;
      case 11:
        return SwipeServiceOffering.MORE;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, SwipeServiceOffering obj) {
    switch (obj) {
      case SwipeServiceOffering.BUY_LOAD:
        writer.writeByte(0);
        break;
      case SwipeServiceOffering.CASH_IN:
        writer.writeByte(1);
        break;
      case SwipeServiceOffering.PAY_QR:
        writer.writeByte(2);
        break;
      case SwipeServiceOffering.DIRECT_SEND:
        writer.writeByte(3);
        break;
      case SwipeServiceOffering.REMITTANCE:
        writer.writeByte(4);
        break;
      case SwipeServiceOffering.REMITTANCE_INSTAPAY:
        writer.writeByte(5);
        break;
      case SwipeServiceOffering.BILLS_PAYMENT:
        writer.writeByte(6);
        break;
      case SwipeServiceOffering.INSURANCE:
        writer.writeByte(7);
        break;
      case SwipeServiceOffering.BANK_TRANSFER:
        writer.writeByte(8);
        break;
      case SwipeServiceOffering.REQUEST_MONEY:
        writer.writeByte(9);
        break;
      case SwipeServiceOffering.AUTOSWEEP:
        writer.writeByte(10);
        break;
      case SwipeServiceOffering.MORE:
        writer.writeByte(11);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SwipeServiceOfferingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
