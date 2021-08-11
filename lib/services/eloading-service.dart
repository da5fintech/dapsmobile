import 'dart:async';

import 'package:flavor/flavor.dart';
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
    if (map.containsKey("result") && map["result"] == 'successful') {
      return EloadProcessResponse(
          message: map["message"],
          result: map["result"],
          reference: map["trans_status"],
          status: true);
    }

    return EloadProcessResponse(
        status: false,
        message: "failed processing, reason: ${map["message"]}",
        reference: "",
        result: "");
  }
}

class EloadingService extends Da5Service {
  EloadingService()
      : super(
            endpoint: Flavor.instance.properties['dapsUrl'],
            merchantId: E_LOADING_AUTH_MERCHANT_ID,
            networkId: E_LOADING_AUTH_NETWORK_ID,
            signature: E_LOADING_AUTH_SIGNATURE,
            username: E_LOADING_AUTH_USERNAME);

  Future<List<ProductModel>> getProducts(String mobile) async {
    List<ProductModel> list = new List<ProductModel>();
    try {
      var products = await post("/API_eloading/products",
          {"Scope": ELOADING_SCOPE, "MobileNumber": mobile});

      if (products['status'] != 200) {
        throw new ApiResponseError(
            code: products['code'],
            message: "Unexpected api response: ${products['status']}");
      }
      if (!products.containsKey("collection")) {
        throw new ApiResponseError(
            code: ErrorCode.MISSING_COLLECTION,
            message: "Expected collection in response but was missing");
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
    } on TimeoutException catch (e) {
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
        "Scope": ELOADING_SCOPE,
        "MobileNumber": mobile,
        "Amount": product.amount.toString(),
        "Network": fromNetwork(product.network),
        "Products": product.name,
        "ProductCode": product.code
      });

      return EloadProcessResponse.fromMap(response);
    } on ApiResponseError catch (e) {
      return EloadProcessResponse(
          status: false,
          message:
              "Failed processing. \ncode: ${e.code} \nreason: ${e.message}",
          reference: "",
          result: "");
    } on EloadProcessingError catch (e) {
      return EloadProcessResponse(
          status: false,
          message:
              "Failed processing. \ncode: ${e.code} \nreason: ${e.message}",
          reference: "",
          result: "");
    } catch (e) {
      return EloadProcessResponse(
          status: false,
          message: "Failed processing. reason: UNKNOWN",
          reference: "",
          result: "");
    }
  }
}
