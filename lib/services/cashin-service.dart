

import 'package:swipe/common/constants.dart';
import 'package:swipe/common/util.dart';
import 'package:swipe/models/user-model.dart';
import 'package:swipe/services/da5-service.dart';

class CashInService extends Da5Service {
  AppUtil _appUtil = AppUtil();

  CashInService() : super(
    merchantId: CASHIN_MERCHANT_ID,
    networkId: CASHIN_NETWORK_ID,
    signature: CASHIN_SIGNATURE,
    username: CASHIN_USERNAME,
    endpoint: CASHIN_ENDPOINT,
  );


  Future addMoney ({UserModel user, String amount}) async {

    var cashInRaw = await postCashIn('/api/user/addMoney/create', {
      "user_id": user.id,
      "user_email_address": user.email,
      "user_name": user.displayName,
      "user_mobile_number": user.mobileNumber,
      "amount": amount,
      "transaction_number": _appUtil.generateTransactionNumber(),
    });
    print(cashInRaw);
  }



  void testCall () {
    print('test');
  }

}