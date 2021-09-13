import 'package:swipe/common/errors.dart';
import 'package:swipe/models/bpi-account-model.dart';
import 'package:swipe/services/da5-service.dart';
import 'package:swipe/models/transaction-model.dart';
import 'package:swipe/common/constants.dart';
import 'package:flavor/flavor.dart';

const accessToken = "AAEkNzE5MzliNzYtZWM2Mi00M2M4LTk0YjMtNWM4MWM5MzcyMmUyVXCGzpN6ershJ7rlNFfNtVd4d284i0jNh7h7FNyvqL2NBSqifSVaVQ5kaJGnIl31rn7gC_4pldDAxBKc1j5nAnCHdWEq026M-jUM-DNo9v0fe5J9Q1e6rSFT8Se7CJ3GNIFtYYeyO2gMHZrcX09E5g";

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
    } on ApiResponseError catch (e) {
      print('API Reponse Error ${e.message}');
      return BpiTransactionProcessingResponse(status: false, message: 'Please re-login your Bpi Account');
    } catch (e) {
      print('Caught error');
      return BpiTransactionProcessingResponse(status: false, message: "Something went wrong");
    }
  }

  Future<BpiTransactionProcessingResponse> init(BpiAccountModel bpiAccountModel, double amount) async {
    BpiTransactionProcessingResponse response = new BpiTransactionProcessingResponse();
    try {
      Map<String, String> params = {
        'AccessToken': accessToken,
        'Scope': BPI_SCOPE,
        'AccountNumberToken': bpiAccountModel.accountNumberToken,
        'Amount': formatterWithoutPHP.format(amount).replaceFirst(" ", "")
      };
      var request = await post('/API_BPICashin/initiate', params);
      response = BpiTransactionProcessingResponse.fromMap(request);
      return response;
    } on ApiResponseError catch(e) {
      print('API Response Error ${e.message}');
      return BpiTransactionProcessingResponse(status: false, message: 'Please re-login you Bpi Account');
    } catch (e) {
      print('Caught Error');
      print(e);
      return BpiTransactionProcessingResponse(status: false, message: "Something went wrong");
    }
  }

  Future<BpiTransactionProcessingResponse> sendOtp (BpiAccountModel model) async {
    BpiTransactionProcessingResponse response = new BpiTransactionProcessingResponse();
    try {
      Map<String, String> params = {
        'Scope': BPI_SCOPE,
        'AccessToken': accessToken,
        'MobileNumber': model.mobileNumber,
        'MobileNumberToken': model.mobileNumberToken,
        'Amount': formatterWithoutPHP.format(model.amount).replaceFirst(" ", ""),
        'TransactionId': model.transactionId,
      };

      var request = await post('/API_BPICashin/sendOTP', params);
      response = BpiTransactionProcessingResponse.fromMap(request);
      return response;
    } on ApiResponseError catch(e) {
      print('API Response Error ${e.message}');
      return BpiTransactionProcessingResponse(status: false, message: 'Failed to request OTP');
    } catch (e) {
      print('Caught Error');
      print(e);
      return BpiTransactionProcessingResponse(status: false, message: "Something went wrong");
    }
  }

  Future<BpiTransactionProcessingResponse> process (BpiAccountModel model, String otp) async {
    BpiTransactionProcessingResponse response = new BpiTransactionProcessingResponse();
    try {
      Map<String, dynamic> params = {
        'Scope': BPI_SCOPE,
        'AccessToken': accessToken,
        'MobileNumber': model.mobileNumberToken,
        'Amount': formatterWithoutPHP.format(model.amount).replaceFirst(" ", ""),
        'OTP': otp,
        'TransactionId': model.transactionId,
    };
     var request = await post('/API_BPICashin/process', params);
     response = BpiTransactionProcessingResponse.fromMap(request);
     return response;
    } on ApiResponseError catch (e) {
      print('API Response Error ${e.message}');
      return BpiTransactionProcessingResponse(status: false, message: 'Failed to request OTP');
    } catch (e) {
      print('Caught Error');
      print(e);
      return BpiTransactionProcessingResponse(status: false, message: "Something went wrong");
    }
  }
}