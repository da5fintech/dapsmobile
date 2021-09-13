import 'dart:async';

import 'package:flavor/flavor.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/errors.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/models/transaction-model.dart';
import 'package:swipe/services/da5-service.dart';

class PesonetProcessingResponse extends TransactionProcessingResponse {
  PesonetProcessingResponse({status, reference, message, result})
      : super(
      status: status,
      reference: reference,
      message: message,
      result: result);

  factory PesonetProcessingResponse.fromMap(Map<String, dynamic> map) {
    if (map.containsKey("status") && map["status"] == 200) {
      var ref = map["trans_status"]["senderRefId"];
      return PesonetProcessingResponse(
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
    return PesonetProcessingResponse(
        message: message, result: message, reference: "", status: false);
  }
}


class PesonetService extends Da5Service {
  PesonetService() :
        super(
        endpoint: Flavor.instance.properties['dapsUrl'],
        merchantId: PESONET_PAY_AUTH_MERCHANT_ID,
        networkId: PESONET_PAY_AUTH_NETWORK_ID,
        signature: PESONET_PAY_AUTH_SIGNATURE,
        username: PESONET_PAY_AUTH_USERNAME,
      );

  Future<List<PesonetBankProduct>> getBanks() async {
    List<PesonetBankProduct> pesonetBanks = new List<PesonetBankProduct>();
    try {
      var pesonetBankRaw = await post("/API_pesonet/banks", {
        "Scope": PESONET_PAY_SCOPE,
      });

      if (pesonetBankRaw['status'] != 200) {
        throw new ApiResponseError(
            code: pesonetBankRaw["code"],
            message: "Unexpected api response: ${pesonetBankRaw['status']}");
      }

      if (!pesonetBankRaw.containsKey("collection")) {
        throw new ApiResponseError(
            code: ErrorCode.MISSING_COLLECTION,
            message: "Expected collection in response but was missing");
      }

      var list = pesonetBankRaw['collection'];

      list.forEach((b) {
       pesonetBanks
            .add(PesonetBankProduct(code: b["code"], name: b["bank"]));
      });

      return pesonetBanks;
    } on ApiResponseError catch (e) {
      print("Got api error ${e.message}");
      return pesonetBanks;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<PesonetProcessingResponse> process(
      PesonetBankProduct product, double amount) async {
    try {
      double total = amount + PESONET_PAY_FEE;
      Map<String, String> params = {
        "Scope": PESONET_PAY_SCOPE,
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

      ///mock success result
      // await Future.delayed(Duration(seconds: 3));
      // var response = {
      //   "status": 200,
      //   "trans_status": {
      //     "code": "SP",
      //     "senderRefId": "16142215",
      //     "state": "Sent for Processing",
      //     "uuid": "2f3e6c21-bc1e-4dbe-8812-8d4a09bc7c42",
      //     "description": "Transaction is sent for processing",
      //     "type": "PESONET",
      //     "amount": "10.00",
      //     "ubpTranId": "UB66271",
      //     "tranRequestDate": "2021-02-25T10:53:11.000",
      //     "remittanceId": "E90121PWNISIPMSI"
      //   },
      //   "message": "This transaction has been processed successfully",
      //   "result": "successful"
      // };
      var response = await post("/API_pesonet/process", params);
      return PesonetProcessingResponse.fromMap(response);
    } on ApiResponseError catch (e) {
      print("caught2");
      return PesonetProcessingResponse(
        status: false,
        reference: "",
        message: "Failed processing. \ncode: ${e.code} \nreason: ${e.message}",
        result: "",
      );
    } on InstapayProcessingError catch (e) {
      print("caught1");
      return PesonetProcessingResponse(
        status: false,
        reference: "",
        message: "Failed processing. \ncode: ${e.code}, \nreason: ${e.message}",
        result: "",
      );
    } on TimeoutException catch (e) {
      print("Caught timeout exception");
      return PesonetProcessingResponse(
        status: false,
        reference: "",
        message: "Failed processing.\nreason: ${e.message}",
        result: "",
      );
    } catch (e, stack) {
      print("caught ${e}");
      print(stack);

      return PesonetProcessingResponse(
        status: false,
        reference: "",
        message: "Failed processing. \nreason: UNKOWN",
        result: "",
      );
    }
  }


}
