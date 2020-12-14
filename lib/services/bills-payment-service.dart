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
    if (map.containsKey("status") && map["status"] == 200) {
      return BillsPaymentProcessResponse(
          message: map["reason"],
          result: map["reason"],
          reference: map["data"]["txnid"],
          status: true);
    }

    return BillsPaymentProcessResponse(
        message: map["code"],
        result: map["code"],
        reference: "",
        status: false);
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
            code: billersRaw["code"],
            message: "Unexpected api response: ${billersRaw['status']}");
      }

      if (!billersRaw.containsKey("collection")) {
        throw new ApiResponseError(
            code: ErrorCode.MISSING_COLLECTION,
            message: "Expected collection in response but was missing");
      }

      var list = billersRaw['collection']['data']['listings']['billers'];

      list.forEach((b) {
        billers.add(BillerProduct.fromMap(b));
      });

      return billers;
    } on ApiResponseError catch (e) {
      print("Got api error ${e.message}");
      return billers;
    } catch (e) {}
  }

  Future<BillsPaymentProcessResponse> process(BillerProduct product) async {
    try {
      Map<String, String> params = {
        "Scope": BILLS_PAYMENT_SCOPE,
        "Biller": product.code,
        "Channel": BILLS_PAYMENT_CHANNEL,
      };

      product.fields.forEach((field) {
        params[field.field] = "${field.value}";
      });

      print("sending params ${params}");

      var response = await post("/API_billspayment/process", params);

      print("response ${response}");

      if (response.containsKey("status") && response["status"] == 200) {
        return BillsPaymentProcessResponse.fromMap(response);
      } else {
        throw BillsPaymentProcessingError(
            code: response["code"],
            message: "Unsuccesfull: ${response["status"]}");
      }
    } on ApiResponseError catch (e) {
      return BillsPaymentProcessResponse(
        status: false,
        reference: "",
        message: "fail processing, reason: ${e.message}",
        result: "",
      );
    } catch (e) {
      return BillsPaymentProcessResponse(
        status: false,
        reference: "",
        message: "fail processing, reason: unknown",
        result: "",
      );
    }
  }
}
