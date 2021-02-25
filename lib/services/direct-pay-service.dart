import 'dart:math';

import 'package:intl/intl.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/errors.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/models/transaction-model.dart';
import 'package:swipe/models/user-model.dart';
import 'package:swipe/services/da5-service.dart';
import 'package:swipe/store/application-store.dart';

class DirectPayFeeResponse extends TransactionProcessingResponse {
  String amount;
  int fee;
  String dacn;

  DirectPayFeeResponse(
      {code, this.fee, this.amount, this.dacn, status, message, result, reference})
      : super(status: status, message: message, result: result, reference: reference);

  factory DirectPayFeeResponse.fromMap(Map<String, dynamic> map) {
    if (map.containsKey("status") && map["status"] == 200) {
      return DirectPayFeeResponse(
          code: map['code'],
          message: map["message"],
          result: map["result"],
          amount: map['amount'],
          fee: map['fee'],
          dacn: map['DACN'],
          reference: map['reference'],
          status: true);
    }

    var errors = map["message"]["errors"];
    String message = "UNKNOWN ERROR";
    if (errors.length > 0) {
      message = map["message"]["errors"][0]["description"];
    }
    return DirectPayFeeResponse(
        message: message, result: message, status: false);
  }
}

class DirectPayService extends Da5Service {
  DirectPayService()
      : super(
            endpoint: DIRECT_PAY_API_STAGING_ENDPOINT,
            networkId: DIRECT_PAY_AUTH_NETWORK_ID,
            merchantId: DIRECT_PAY_AUTH_MERCHANT_ID,
            username: DIRECT_PAY_AUTH_USERNAME,
            signature: DIRECT_PAY_AUTH_SIGNATURE);

  Future<DirectPayFeeResponse> getFees(String amount, String receiver) async {
    try {
      var directPayFee = await post("/API_directpay/fees", {
        "Amount": amount,
        "Scope": DIRECT_PAY_SCOPE,
      });

      if (directPayFee['status'] != 200) {
        throw new ApiResponseError(
            message: "Unexpected api response: ${directPayFee['status']}");
      }

      return DirectPayFeeResponse.fromMap(directPayFee);
    } on ApiResponseError catch (e) {
      return DirectPayFeeResponse(
        status: false,
        result: "",
        message: "Failed processing. \ncode: ${e.code}, \nreason: ${e.message}",
      );
    } catch (e, stack) {
      print(e);
      print(stack);
      return DirectPayFeeResponse(
        status: false,
        result: "",
        message: "Failed processing. \ncode: ${e.code}, \nreason: ${e.message}",
      );
    }
  }

  Future<DirectPayFeeResponse> process(DirectPayProduct product, amount, UserModel user) async {
    var random = new Random();
    var reference = random.nextInt(10000000).toString();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat.yMd().format(now);
    try {
      double total = amount + product.fee;
      Map<String, String> params = {
        "SenderNameType": 'D',
        "SenderFirstName": user.firstName,
        "SenderMiddleName": "Maniquez",
        "SenderLastName": user.lastName,
        "SenderDOB": formattedDate,
        "SenderAddress": INSTAPAY_ADDRESS1,
        "SenderMunicipality": INSTAPAY_CITY,
        "SenderProvince": INSTAPAY_PROVINCE,
        "SenderMobileNumber": user.mobileNumber,
        "SenderIDType": "",
        "SenderIDNumber": "",
        "Amount": formatterWithoutPHP.format(total).replaceFirst(" ", ""),
        "Fees": formatterWithoutPHP.format(product.fee).replaceFirst(" ", ""),
        "ReceiverFirstName": "Jose Paulo",
        "ReceiverMiddleName": "Maniquez",
        "ReceiverLastName": "Dela Cruz",
        "ReceiverMobileNumber": product.mobileNumber,
        // "ReceiverDOB": "formattedDate",
        // "ReceiverAddress": INSTAPAY_ADDRESS1,
        // "ReceiverMunicipality": INSTAPAY_CITY,
        // "ReceiverProvince": INSTAPAY_PROVINCE,
        "PartnerReferenceNo": reference,
        "Scope": DIRECT_PAY_SCOPE,
        "Type": "Cashin",
        "DeliveryServices": "0000",
        "ProcessingType": "0000"
    };

    var response = await post('/API_directpay/p2p', params);
      return DirectPayFeeResponse(
        fee: product.fee,
        amount: product.amount.toString(),
        reference: reference,
        code: response['code'],
        status: true,
        message: response['message'],
        result: response['result'],
        dacn: response['DACN'],
      );
    } on ApiResponseError catch(e) {
      return DirectPayFeeResponse(
        status: false,
        result: "",
        message: "Failed processing. \ncode: ${e.code}, \nreason: ${e.message}",
      );
    } on DirectPayError catch(e) {
      return DirectPayFeeResponse(
        status: false,
        result: "",
        message: "Failed processing. \ncode: ${e.code}, \nreason: ${e.message}",
      );
    } catch(e, stack) {
      print(e);
      print(stack);
      return DirectPayFeeResponse(
        status: false,
        result: "",
        message: "Failed processing. \ncode: ${e.code}, \nreason: ${e.message}",
      );
    }
  }

  Future testCall() {
    print('TEST API CALL');
  }
}
