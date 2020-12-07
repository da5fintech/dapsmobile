import 'package:swipe/common/constants.dart';
import 'package:swipe/common/errors.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/models/transaction-model.dart';
import 'package:swipe/services/da5-service.dart';

class EloadProcessResponse extends TransactionProcessingResponse {
  EloadProcessResponse({status, reference, message, result})
      : super(
            status: status,
            reference: reference,
            message: message,
            result: result);

  factory EloadProcessResponse.fromMap(Map<String, dynamic> map) {
    var obj = EloadProcessResponse(
        message: map["message"],
        result: map["result"],
        reference: map["trans_status"],
        status: map["status"]);

    return obj;
  }
}

class EloadingService extends Da5Service {
  EloadingService()
      : super(
            endpoint: ELOADING_ENDPOINT,
            merchantId: AUTH_MERCHANT_ID,
            networkId: AUTH_NETWORK_ID,
            signature: AUTH_SIGNATURE,
            username: AUTH_USERNAME);

  Future<List<ProductModel>> getProducts(String mobile) async {
    List<ProductModel> list = new List<ProductModel>();
    try {
      var products = await post("/API_eloading/products",
          {"Scope": "eloading", "MobileNumber": mobile});

      if (!products.containsKey("collection")) {
        throw new ApiResponseError(
            "Expected collection in response but was missing");
      }
      (products["collection"]["data"]).forEach((p) {
        var product = AirtimeProduct(
            network: toNetwork(p["Network"]),
            code: p["ProductCode"],
            name: p["ProductName"],
            amount: double.parse(p["MinAmount"]));
        print("product: ${product.name}");
        list.add(product);
      });
      print("got list ${list.length}");
      return list;
    } on ApiResponseError catch (e) {
      print("Got api error ${e.message}");
      return list;
    }
  }

  Future<EloadProcessResponse> process(
      String mobile, AirtimeProduct product) async {
    List<ProductModel> list = new List<ProductModel>();
    try {
      var response = await post("/API_eloading/process", {
        "Scope": "eloading",
        "MobileNumber": mobile,
        "Amount": product.amount.toString(),
        "Network": fromNetwork(product.network),
        "Products": product.name,
        "ProductCode": product.code
      });

      if (response.containsKey("result") &&
          response["result"] == 'successful') {
        return EloadProcessResponse.fromMap(response);
      } else {
        throw EloadProcessingError("Unsuccesfull: ${response["result"]}");
      }
    } on ApiResponseError catch (e) {
      throw EloadProcessingError("Processing failed: ${e.message}");
    }
  }
}
