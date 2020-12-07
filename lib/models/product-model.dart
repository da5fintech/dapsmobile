abstract class ProductModel {
  String name;
  String code;
  double amount;
  String description;

  ProductModel({this.code, this.name, this.amount, this.description = ""});
}

enum Network { SMART, GLOBE }

toNetwork(String network) {
  switch (network) {
    case "GLOBE":
      return Network.GLOBE;
    case "SMART":
      return Network.SMART;
    default:
      return "";
  }
}

fromNetwork(Network network) {
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
