

import 'package:swipe/common/constants.dart';
import 'package:swipe/common/errors.dart';
import 'package:swipe/common/util.dart';
import 'package:swipe/models/transaction-model.dart';
import 'package:swipe/models/user-model.dart';
import 'package:swipe/services/da5-service.dart';


class CashInResponse extends TransactionProcessingResponse {
  String referenceNumber;

  CashInResponse({
    this.referenceNumber,
    status,
    message,
    result,
    reference,
  }) : super(status: status, message: message, result: result, reference: reference);

  factory CashInResponse.fromMap(Map<String, dynamic> map) {
    if (map.containsKey("status") && map["status"] == 200) {
      return CashInResponse(
          message: map["message"],
          result: map["result"],
          reference: map['reference'],
          referenceNumber: map['reference_number'],
          status: true);
    }

    var errors = map["message"]["errors"];
    String message = "UNKNOWN ERROR";
    if (errors.length > 0) {
      message = map["message"]["errors"][0]["description"];
    }
    return CashInResponse(
        message: message, result: message, status: false);
  }
}


class CashInService extends Da5Service {
  AppUtil _appUtil = AppUtil();

  CashInService() : super(
    merchantId: CASHIN_MERCHANT_ID,
    networkId: CASHIN_NETWORK_ID,
    signature: CASHIN_SIGNATURE,
    username: CASHIN_USERNAME,
    endpoint: CASHIN_ENDPOINT,
  );


  Future<CashInResponse> addMoney ({UserModel user, String amount}) async {
    try {
      await Future.delayed(Duration(seconds: 3));
      var cashInRaw;
      var mockResult = {
        "reference_number": _appUtil.generateTransactionNumber(),
        "message": "Success",
        "status": 200,
        "result": "Success",
        "reference": "Success",
      };

     //  if (cashInRaw['status'] != 200) {
     //    throw new ApiResponseError(
     //        message: "Unexpected api response: ${cashInRaw['status']}");
     // }


      // var cashInRaw = await postCashIn('/api/user/addMoney/create', {
      //   "user_id": user.id,
      //   "user_email_address": user.email,
      //   "user_name": user.displayName,
      //   "user_mobile_number": user.mobileNumber,
      //   "amount": amount,
      //   "transaction_number": _appUtil.generateTransactionNumber(),
      // });
      return CashInResponse.fromMap(mockResult);
    } on ApiResponseError catch (e) {
      return CashInResponse(
        status: false,
        result: "",
        message: "Failed processing. \nreason: ",
      );
    } catch(e, stack) {
      print(e);
      print(stack);
      return CashInResponse(
        status: false,
        result: "",
        message: "Failed processing. \nreason: ",
      );
    }

    // print(cashInRaw);
  }



  void testCall () {
    print('test');
  }

}