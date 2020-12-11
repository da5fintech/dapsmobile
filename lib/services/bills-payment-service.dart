import 'package:swipe/common/constants.dart';
import 'package:swipe/common/errors.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/models/transaction-model.dart';
import 'package:swipe/services/da5-service.dart';

class BillsPaymentProcessResponse extends TransactionProcessingResponse {
  BillsPaymentProcessResponse({status, reference, message, result})
      : super(
            status: status,
            reference: reference,
            message: message,
            result: result);

  factory BillsPaymentProcessResponse.fromMap(Map<String, dynamic> map) {
    var obj = BillsPaymentProcessResponse(
        message: map["message"],
        result: map["result"],
        reference: map["trans_status"],
        status: map["status"]);

    return obj;
  }
}

class BillsPaymentService extends Da5Service {
  BillsPaymentService()
      : super(
            endpoint: ELOADING_ENDPOINT,
            merchantId: AUTH_MERCHANT_ID,
            networkId: AUTH_NETWORK_ID,
            signature: AUTH_SIGNATURE,
            username: AUTH_USERNAME);

  Future<List<BillerProduct>> getBillersByCategory(String category) async {
    List<BillerProduct> billers = new List<BillerProduct>();
    try {
      var billersRaw = await post("/API_billspayment/category",
          {"Scope": BILLS_PAYMENT_SCOPE, "Category": category});

      if (billersRaw['status'] != 200) {
        throw new ApiResponseError(
            "Unexpected api response: ${billersRaw['status']}");
      }

      if (!billersRaw.containsKey("collection")) {
        throw new ApiResponseError(
            "Expected collection in response but was missing");
      }

      var list = billersRaw['collection']['data']['listings']['billers'];

      list.forEach((b) {
        billers.add(BillerProduct.fromMap(b));
      });

      return billers;
    } on ApiResponseError catch (e) {
      print("Got api error ${e.message}");
      return billers;
    } catch (e) {
      throw e;
    }
  }

  // Future<BillsPaymentProcessResponse> process(
  //     String mobile, AirtimeProduct product) async {
  //   List<ProductModel> list = new List<ProductModel>();
  //   try {
  //     var response = await post("/API_eloading/process", {
  //       "Scope": "eloading",
  //       "MobileNumber": mobile,
  //       "Amount": product.amount.toString(),
  //       "Network": fromNetwork(product.network),
  //       "Products": product.name,
  //       "ProductCode": product.code
  //     });

  //     if (response.containsKey("result") &&
  //         response["result"] == 'successful') {
  //       return BillsPaymentProcessResponse.fromMap(response);
  //     } else {
  //       throw EloadProcessingError("Unsuccesfull: ${response["result"]}");
  //     }
  //   } on ApiResponseError catch (e) {
  //     throw EloadProcessingError("Processing failed: ${e.message}");
  //   }
  // }
}
