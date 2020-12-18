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

class InstapayService extends Da5Service {
  InstapayService()
      : super(
            endpoint: ELOADING_ENDPOINT,
            merchantId: AUTH_MERCHANT_ID,
            networkId: AUTH_NETWORK_ID,
            signature: AUTH_SIGNATURE,
            username: AUTH_USERNAME);

  Future<List<InstapayBankProduct>> getBanks() async {
    List<InstapayBankProduct> instapayBanks = new List<InstapayBankProduct>();
    try {
      var instapayBanksRaw = await post("/API_instapay/banks", {
        "Scope": INSTAPAY_SCOPE,
      });

      if (instapayBanksRaw['status'] != 200) {
        throw new ApiResponseError(
            code: instapayBanksRaw["code"],
            message: "Unexpected api response: ${instapayBanksRaw['status']}");
      }

      if (!instapayBanksRaw.containsKey("collection")) {
        throw new ApiResponseError(
            code: ErrorCode.MISSING_COLLECTION,
            message: "Expected collection in response but was missing");
      }

      var list = instapayBanksRaw['collection'];

      list.forEach((b) {
        instapayBanks
            .add(InstapayBankProduct(code: b["code"], name: b["bank"]));
      });

      return instapayBanks;
    } on ApiResponseError catch (e) {
      print("Got api error ${e.message}");
      return instapayBanks;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<BillsPaymentProcessResponse> process(BillerProduct product) async {
    try {
      Map<String, String> params = {
        "Scope": BILLS_PAYMENT_SCOPE,
        "Biller": product.code,
        "Channel": BILLS_PAYMENT_CHANNEL,
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
