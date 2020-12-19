import 'package:swipe/common/constants.dart';
import 'package:swipe/common/errors.dart';
import 'package:swipe/services/da5-service.dart';

class AccountService extends Da5Service {
  AccountService()
      : super(
            endpoint: API_ENDPOINT,
            merchantId: AUTH_MERCHANT_ID,
            networkId: AUTH_NETWORK_ID,
            signature: AUTH_SIGNATURE,
            username: AUTH_USERNAME);

  Future<double> getWalletAmount() async {
    try {
      var response = await rawPost("/authtimeout/token");
      return double.parse(response['wallet']);
    } on ApiResponseError catch (e) {
      return 0;
    }
  }
}
