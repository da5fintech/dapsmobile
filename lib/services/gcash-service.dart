import 'dart:async';

import 'package:flavor/flavor.dart';
import 'package:sensitive_http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/errors.dart';
import 'package:swipe/common/util.dart';
import 'package:swipe/models/transaction-model.dart';
import 'package:swipe/services/da5-service.dart';


class GcashResponse extends TransactionProcessingResponse {
  GcashResponse ({status, result, message}) :
      super(status: status, result: result, message: message);

}

class GcashService extends Da5Service {
  AppUtil _appUtil = AppUtil();

  GcashService() :
      super(
        endpoint: Flavor.instance.properties['dapsUrl'],
        networkId: GCASH_NETWORK_ID,
        merchantId: GCASH_MERCHANT_ID,
        username: GCASH_USERNAME,
        signature: GCASH_AUTH_SIGNATURE,
      );

  void test () {
    print('call gcash api');
  }

  Future<GcashResponse> cashIn (String mobileNumber, String amount) async {
    try {
      Map<String, String> params = {
        'transaction_ext_reference': '100035',
        'Scope': GCASH_SCOPE,
        'mobile_number': mobileNumber,
        'amount': amount,
        'fees': GCASH_FEE,
      };

      var response = await post('/API_gcash/cashin', params);

      if(response['status'] != 200) {
        throw new ApiResponseError(message: "Unexpected API response ${response['status']}");
      }

      return GcashResponse(
        status: true,
        message: "Success",
        result: "Success",
      );

    } on ApiResponseError catch (err) {
      return GcashResponse(
        status: false,
        result: "",
        message: "Failed processing. \ncode: ${err.code}, \nmessage: ${err.message}",
      );
    } on TimeoutException catch (e) {
      return GcashResponse(
        status: false,
        result: "",
        message: "Failed processing. \nmessage: ${e.message}",
      );
    } catch (e, stack) {
      print(e);
      print(stack);
      return GcashResponse(
          status: false,
          result: "",
          message: "Failed processing. \ncode: ${e.code}, \nmessage: ${e.message}",
      );
    }
  }

  Future<GcashResponse> cashOut (String mobileNumber, String amount) async {
    try {
      Map<String, String> params = {
        'transaction_ext_reference': '100035',
        'Scope': GCASH_SCOPE,
        'mobile_number': mobileNumber,
        'amount': amount,
        'fees': GCASH_FEE,
      };

      var response = await post('/API_gcash/cashout', params);

      if(response['status'] != 200) {
        throw new ApiResponseError(message: "Unexpected API response ${response['status']}");
      }

      return GcashResponse(
        status: true,
        message: "Success",
        result: "Success",
      );

    } on TimeoutException catch (e) {
      return GcashResponse(
        status: false,
        result: "",
        message: "Failed processing. \nmessage: ${e.message}",
      );
    } on ApiResponseError catch (err) {
      return GcashResponse(
        status: false,
        result: "",
        message: "Failed processing. \ncode: ${err.code}, \nmessage: ${err.message}",
      );
    } catch (e, stack) {
      print(e);
      print(stack);
      return GcashResponse(
        status: false,
        result: "",
        message: "Failed processing. \ncode: ${e.code}, \nmessage: ${e.message}",
      );
    }
  }


}