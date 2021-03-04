

import 'package:swipe/common/constants.dart';
import 'package:swipe/models/user-model.dart';
import 'package:swipe/services/da5-service.dart';

class CashInService extends Da5Service {

  CashInService() : super(
    merchantId: CASHIN_MERCHANT_ID,
    networkId: CASHIN_NETWORK_ID,
    signature: CASHIN_SIGNATURE,
    username: CASHIN_USERNAME,
    endpoint: CASHIN_ENDPOINT,
  );


  Future addMoney ({UserModel user, String amount}) async {
    var token = await getPostToken();
    print(token);

    // var cashInRaw = await postCashIn('/api/addMoney', {
    //
    // });


  }



  void testCall () {
    print('test');
  }

}