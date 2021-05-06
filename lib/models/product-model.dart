import 'package:flavor/flavor.dart';
import 'package:flutter/cupertino.dart';
import 'package:swipe/common/constants.dart';
import 'package:hive/hive.dart';
import 'package:swipe/models/notification-model.dart';

part 'product-model.g.dart';

@HiveType(typeId: 5)
class ProductModel extends HiveObject {
  @HiveField(6)
  String name;
  @HiveField(7)
  String code;
  @HiveField(8)
  double amount;
  @HiveField(9)
  String description;

  ProductModel({this.code, this.name, this.amount, this.description = ""});
}

enum Network { SMART, GLOBE, NONE }

Network toNetwork(String network) {
  switch (network) {
    case "GLOBE":
      return Network.GLOBE;
    case "SMART":
      return Network.SMART;
    default:
      return Network.NONE;
  }
}

String fromNetwork(Network network) {
  switch (network) {
    case Network.GLOBE:
      return "GLOBE";
    case Network.SMART:
      return "SMART";
    default:
      return "";
  }
}

class AirtimeProduct extends ProductModel {
  Network network;
  AirtimeProduct(
      {String code,
      String name,
      double amount,
      String description = "",
      this.network})
      : super(code: code, name: name, amount: amount, description: description);
  test() {
    print(name);
  }
}
@HiveType(typeId: 4)
enum BillerFieldType {
  @HiveField(0)
  TEXT,
  @HiveField(1)
  NUMBER,
  @HiveField(2)
  CALENDAR,
  @HiveField(3)
  DROPDOWN
}

@HiveType(typeId: 3)
class KeyValuePair {
  @HiveField(0)
  String key;
  @HiveField(1)
  String value;
  KeyValuePair({this.key, this.value});
}


@HiveType(typeId: 2)
class BillerField {
  @HiveField(0)
  String label;
  @HiveField(1)
  String field;
  @HiveField(2)
  BillerFieldType fieldType;
  @HiveField(3)
  bool isRequired;
  @HiveField(4)
  dynamic value;
  @HiveField(5)
  dynamic defaultValue;
  @HiveField(6)
  List<KeyValuePair> options;

  BillerField({
    this.label,
    this.field,
    this.fieldType,
    this.isRequired,
    this.value = "",
    this.defaultValue = "",
    this.options,
  });

  factory BillerField.fromMap(Map<String, dynamic> map) {
    var billerField = new BillerField();
    billerField.field = map['field'];
    billerField.label = map["label"];
    if (map["type"] == "Number") {
      billerField.fieldType = BillerFieldType.NUMBER;
    } else if (map['type'] == "Text") {
      billerField.fieldType = BillerFieldType.TEXT;
    } else if (map["type"] == "Calendar") {
      billerField.fieldType = BillerFieldType.CALENDAR;
    } else if (map["type"] == "Dropdown") {
      billerField.fieldType = BillerFieldType.DROPDOWN;
      List<KeyValuePair> options = [];
      map["options"].forEach((opt) {
        options
            .add(KeyValuePair(key: "${opt["key"]}", value: "${opt["value"]}"));
      });
      billerField.options = options;
    } else {
      billerField.fieldType = BillerFieldType.TEXT;
    }
    billerField.isRequired = map['is_required'];

    return billerField;
  }
}

@HiveType(typeId: 1)
class BillerProduct extends ProductModel {
  @HiveField(0)
  bool enabled;
  @HiveField(1)
  String type;
  @HiveField(2)
  double fee;
  @HiveField(3)
  String logo;
  @HiveField(4)
  String category;
  @HiveField(5)
  List<BillerField> fields;

  BillerProduct({
    this.enabled,
    String code,
    String name,
    double amount,
    String description = "",
  }) : super(code: code, name: name, amount: amount, description: description);
  test() {
    print(name);
  }

  factory BillerProduct.fromMap(Map<String, dynamic> map) {
    var biller = BillerProduct();
    biller.code = map["code"];
    biller.name = map["name"];
    biller.type = map["type"];
    biller.logo = map["logo"];
    biller.fee = double.parse(map["fee"]);
    biller.category = map["category"];
    biller.fields = new List<BillerField>();

    map["meta"].forEach((field) {
      biller.fields.add(BillerField.fromMap(field));
    });

    if (Flavor.I.environment == Environment.dev) {
      if (biller.code == "BC_BAYAN") {
        biller.setDefaultFieldValue('account_number', '302293899');
        biller.setDefaultFieldValue('amount', 0.00);
        biller.setDefaultFieldValue('phone_number', '0464508296');
        biller.setDefaultFieldValue('customer_name', 'Test Customer');
      }

      if (biller.code == "BC_MECOA") {
        biller.setDefaultFieldValue(
            'account_number', '00123982449200708420080806');
        biller.setDefaultFieldValue('amount', 20.00);
        biller.setDefaultFieldValue('pay_for', 'T');
        biller.setDefaultFieldValue('customer_name', 'Test Customer');
      }
    }

    if (biller.fields.length == 0) {
      biller.enabled = false;
    } else {
      biller.enabled = true;
    }
    return biller;
  }

  setFieldValue(String field, dynamic value) {
    fields.forEach((element) {
      if (element.field == field) {
        element.value = value;
      }
    });
  }

  setDefaultFieldValue(String field, dynamic value) {
    fields.forEach((element) {
      if (element.field == field) {
        element.defaultValue = value;
      }
    });
  }

  dynamic getFieldValue(String field) {
    dynamic result;
    fields.forEach((element) {
      if (element.field != field) {
        return;
      }

      if (element.fieldType == BillerFieldType.DROPDOWN) {
        var option = element.options
            .singleWhere((option) => option.value == element.value);
        result = option.key;
      } else {
        result = element.value;
      }
    });
    return result;
  }
}

class InstapayBankProduct extends ProductModel {
  String accountNumber;
  String recipientName;

  InstapayBankProduct({String code, String name})
      : super(code: code, name: name, amount: 0.0, description: "");
}

class PesonetBankProduct extends ProductModel {
  String accountNumber;
  String recipientName;

  PesonetBankProduct({String code, String name})
      : super(code: code, name: name, amount: 0.0, description: "");

}

class AutosweepProduct extends ProductModel {
  String plateNumber;

  AutosweepProduct({@required this.plateNumber})
      : super(name: AUTOSWEEP_PRODUCT_NAME);
}

class DirectPayProduct extends ProductModel {
  int fee;
  String message;
  String mobileNumber;
  NotificationModel notification;
  DirectPayProduct({String name, double amount, this.mobileNumber, this.message, this.fee, this.notification = null}) : super(name: name, amount: amount);
}

class CashInProduct extends ProductModel {
  String referenceNumber;
  DateTime timestamp;

  CashInProduct({this.referenceNumber, this.timestamp, double amount, String name}) : super(name: name, amount: amount);
}

