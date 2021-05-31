import 'dart:async';

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
            endpoint: BILLS_PAYMENT_API_ENDPOINT,
            merchantId: BILLS_PAYMENT_AUTH_MERCHANT_ID,
            networkId: BILLS_PAYMENT_AUTH_NETWORK_ID,
            signature: BILLS_PAYMENT_AUTH_SIGNATURE,
            username: BILLS_PAYMENT_AUTH_USERNAME);

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
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<BillsPaymentProcessResponse> process(BillerProduct product) async {
    try {
      Map<String, String> params = {
        "Scope": BILLS_PAYMENT_SCOPE,
        "Biller": product.code,
        "fee": formatterWithoutPHP.format(product.fee).replaceFirst(" ", ""),
        "category": product.category,
        "name": product.name,
        "type": product.type,
      };
      product.fields.forEach((field) {
        if (field.field != 'amount') {
          params[field.field] = "${field.value}";
        }
      });

      double total =
          double.parse(product.getFieldValue('amount')) + product.fee;

      params['amount'] = "$total";
      var response = await post("/API_billspayment/process", params);
      return BillsPaymentProcessResponse.fromMap(response);
    } on ApiResponseError catch (e) {
      return BillsPaymentProcessResponse(
        status: false,
        reference: "",
        message: "Failed processing. \ncode: ${e.code} \nreason: ${e.message}",
        result: "",
      );
    } on BillsPaymentProcessingError catch (e) {
      return BillsPaymentProcessResponse(
        status: false,
        reference: "",
        message: "Failed processing. \ncode: ${e.code}, \nreason: ${e.message}",
        result: "",
      );
    } on TimeoutException catch (e) {
      print('Caught time out exception');
      return BillsPaymentProcessResponse(
        status: false,
        reference: "",
        message: "Failed processing. \nreason: ${e.message}",
        result: "",
      );
    } catch (e) {
      return BillsPaymentProcessResponse(
        status: false,
        reference: "",
        message: "Failed processing. \nreason: UNKOWN",
        result: "",
      );
    }
  }
}
