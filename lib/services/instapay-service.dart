import 'dart:async';

import 'package:flavor/flavor.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/errors.dart';
import 'package:daps/models/product-model.dart';
import 'package:daps/models/transaction-model.dart';
import 'package:daps/services/da5-service.dart';

class InstapayProcessingResponse extends TransactionProcessingResponse {
  InstapayProcessingResponse({status, reference, message, result})
      : super(
            status: status,
            reference: reference,
            message: message,
            result: result);

  factory InstapayProcessingResponse.fromMap(Map<String, dynamic> map) {
    if (map.containsKey("status") && map["status"] == 200) {
      var ref = map["trans_status"]["senderRefId"];
      return InstapayProcessingResponse(
          message: map["message"],
          result: map["message"],
          reference: ref,
          status: true);
    }

    var errors = map["message"]["errors"];
    String message = "UNKNOWN ERROR";
    if (errors.length > 0) {
      message = map["message"]["errors"][0]["description"];
    }
    return InstapayProcessingResponse(
        message: message, result: message, reference: "", status: false);
  }
}

class InstapayService extends Da5Service {
  InstapayService()
      : super(
            endpoint: Flavor.instance.properties['dapsUrl'],
            merchantId: INSTAPAY_AUTH_MERCHANT_ID,
            networkId: INSTAPAY_AUTH_NETWORK_ID,
            signature: INSTAPAY_AUTH_SIGNATURE,
            username: INSTAPAY_AUTH_USERNAME);

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
        instapayBanks.add(InstapayBankProduct(code: b["code"], name: b["bank"]));
      });

      return instapayBanks;
    } on ApiResponseError catch (e) {
      print("Got api error ${e.message}");
      return instapayBanks;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<InstapayProcessingResponse> process(
      InstapayBankProduct product, double amount) async {
    try {
      double total = amount + INSTAPAY_FEE;
      Map<String, String> params = {
        "Scope": INSTAPAY_SCOPE,
        "SenName": INSTAPAY_SENDER_NAME,
        "SenAddress1": INSTAPAY_ADDRESS1,
        "SenAddress2": INSTAPAY_ADDRESS2,
        "SenCity": INSTAPAY_CITY,
        "SenProvince": INSTAPAY_PROVINCE,
        "SenZipCode": INSTAPAY_ZIP,
        "SenCountry": INSTAPAY_COUNTRY,
        "BenAccountNumber": product.accountNumber,
        "BenName": product.recipientName,
        "BenAddress1": INSTAPAY_ADDRESS1,
        "BenAddress2": INSTAPAY_ADDRESS2,
        "BenCity": INSTAPAY_CITY,
        "BenProvince": INSTAPAY_PROVINCE,
        "BenZipCode": INSTAPAY_ZIP,
        "BenCountry": INSTAPAY_COUNTRY,
        "Amount": formatterWithoutPHP.format(total).replaceFirst(" ", ""),
        "Currency": INSTAPAY_CURRENCY,
        "Bank": product.code,
      };

      var response = await post("/API_instapay/process", params);
      return InstapayProcessingResponse.fromMap(response);
    } on TimeoutException catch (e) {
      print("caught timeout exception");
      return InstapayProcessingResponse(
        status: false,
        reference: "",
        message: "Failed processing. \nreason: ${e.message}",
        result: "",
      );
    } on ApiResponseError catch (e) {
      print("caught2");
      return InstapayProcessingResponse(
        status: false,
        reference: "",
        message: "Failed processing. \ncode: ${e.code} \nreason: ${e.message}",
        result: "",
      );
    } on InstapayProcessingError catch (e) {
      print("caught1");
      return InstapayProcessingResponse(
        status: false,
        reference: "",
        message: "Failed processing. \ncode: ${e.code}, \nreason: ${e.message}",
        result: "",
      );
    } catch (e, stack) {
      print("caught ${e}");
      print(stack);

      return InstapayProcessingResponse(
        status: false,
        reference: "",
        message: "Failed processing. \nreason: UNKOWN",
        result: "",
      );
    }
  }
}
