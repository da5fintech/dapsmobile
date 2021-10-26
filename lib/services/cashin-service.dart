

import 'package:intl/intl.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/errors.dart';
import 'package:daps/common/util.dart';
import 'package:daps/models/transaction-model.dart';
import 'package:daps/models/user-model.dart';
import 'package:daps/services/da5-service.dart';


class CashInResponse extends TransactionProcessingResponse {
  String referenceNumber;
  DateTime timestamp;

  CashInResponse({
    this.referenceNumber,
    this.timestamp,
    status,
    message,
    result,
    reference,
  }) : super(status: status, message: message, result: result, reference: reference);
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


  Future<CashInResponse> addMoney ({UserModel user, double amount}) async {
    var mockResult = {
      "reference_number": _appUtil.generateTransactionNumber(),
      "message": "Success",
      "status": 200,
      "result": "Success",
      "reference": "Success",
    };
    try {
      var cashInRaw = await postCashIn('/api/user/addMoney/create', {
        "user_id": user.id,
        "user_email_address": user.emailAddress,
        "user_name": user.displayName,
        "user_mobile_number": user.mobileNumber,
        "amount": amount.toString(),
        "transaction_number": _appUtil.generateTransactionNumber(),
      });
      return CashInResponse(
        status: true,
        result: cashInRaw['result'],
        referenceNumber: cashInRaw['reference_number'].toString(),
        timestamp: new DateFormat("yyyy-MM-dd hh:mm:ss").parse(cashInRaw['timestamp']),
      );
    } on ApiResponseError catch (e) {
      return CashInResponse(
        status: false,
        result: "",
        message: "Failed processing. \nreason: ",
        // message: "Failed processing. \nreason: ${e.message}",
      );
    } catch(e, stack) {
      print(e);
      print(stack);
      return CashInResponse(
        status: false,
        result: "",
        message: "Failed processing. \nreason: ",
        // message: "Failed processing. \nreason: ${e.message}",
      );
    }

    // print(cashInRaw);
  }



  void testCall () {
    print('test');
  }

}