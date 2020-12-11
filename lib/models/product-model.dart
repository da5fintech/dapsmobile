abstract class ProductModel {
  String name;
  String code;
  double amount;
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

enum BillerFieldType { TEXT, NUMBER }

class BillerField {
  String label;
  String field;
  BillerFieldType fieldType;
  bool isRequired;

  BillerField({this.label, this.field, this.fieldType, this.isRequired});

  factory BillerField.fromMap(Map<String, dynamic> map) {
    var billerField = new BillerField();
    billerField.field = map['field'];
    billerField.label = map["label"];
    if (map["type"] == "Number") {
      billerField.fieldType = BillerFieldType.NUMBER;
    } else if (map['type'] == "Text") {
      billerField.fieldType = BillerFieldType.TEXT;
    }

    billerField.isRequired = map['is_required'];
    return billerField;
  }
}

class BillerProduct extends ProductModel {
  String type;
  double fee;
  String logo;
  String category;
  List<BillerField> fields;

  BillerProduct({
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
    biller.category = map["category"];
    biller.fields = new List<BillerField>();

    map["meta"].forEach((field) {
      biller.fields.add(BillerField.fromMap(field));
    });

    return biller;
  }
}
