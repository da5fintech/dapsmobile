// import 'package:flutter_test/flutter_test.dart';
// import 'package:swipe/common/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/services/da5-service.dart';

void main() {
  test('da5 must return token', () async {
    final da5 = new Da5Service(
        endpoint: API_ENDPOINT,
        username: AUTH_USERNAME,
        merchantId: AUTH_MERCHANT_ID,
        networkId: AUTH_NETWORK_ID,
        signature: AUTH_SIGNATURE);

    String token = await da5.getToken();
    expect(token, isNot(null));
  });
}
