import 'package:swipe/services/da5-service.dart';
import 'package:swipe/models/transaction-model.dart';
import 'package:swipe/common/constants.dart';
import 'package:flavor/flavor.dart';

const accessToken = "AAEkNzE5MzliNzYtZWM2Mi00M2M4LTk0YjMtNWM4MWM5MzcyMmUyx9zNcDOd33S3efqy3SZJ7z2IcK_WLVwKIWS1izXSx93Ce7xiwLgFHOuRyYSMc3YxxiGrEVoObttLVY5YCNha9JHG9jCUg3yYsU-B7ny1GRpQhq_TlV67_AxNj2MTdn66_olQCGhRErLhfeWSRPtfSQ";


class BpiTransactionProcessingResponse extends TransactionProcessingResponse {
  List<dynamic> collections;
  BpiTransactionProcessingResponse({this.collections, status, code, result, message}) :
      super(
        status: status,
        result: result,
        message: message,
        reference: code,
      );

  factory BpiTransactionProcessingResponse.fromMap(Map<String, dynamic> map) {
    if (map.containsKey("status") && map["status"] == 200) {
      return BpiTransactionProcessingResponse(
          message: map["message"],
          result: map["result"],
          code: map['code'],
          collections: map['collection'],
          status: true);
    }

    return BpiTransactionProcessingResponse(
      status: false,
      code: map['code'],
      result: map['result'],
      message: map['messasge'],
    );
  }
}


class BpiService extends Da5Service {

  BpiService() :
      super(
        endpoint: BPI_MAIN_ENDPOINT,
        merchantId: BPI_MERCHANT_ID,
        networkId: BPI_NETWORK_ID,
        signature: BPI_AUTHENTICATION,
        username:  BPI_USERNAME,
      );

  Future<BpiTransactionProcessingResponse> getAccounts () async {
    BpiTransactionProcessingResponse response = new BpiTransactionProcessingResponse();
    Map<String, String> params = {
      'Scope': BPI_SCOPE,
      'AccessToken': accessToken,
    };
    try {
      var request = await post('/API_BPICashin/accounts', params);
      response = BpiTransactionProcessingResponse.fromMap(request);
      return response;
    } catch (e) {
      return BpiTransactionProcessingResponse(status: false);
    }

  }
}