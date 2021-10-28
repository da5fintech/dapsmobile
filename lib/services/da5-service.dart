import 'dart:async';
import 'dart:convert';
import 'package:daps/main.dart';
import 'package:daps/store/application-store.dart';
import 'package:flutter/foundation.dart';
import 'package:sensitive_http/http.dart' as http;
import 'package:daps/common/constants.dart';
import 'package:daps/common/errors.dart';

final store = getIt<ApplicationStore>();

class Da5Service {
  final String endpoint;
  final String username;
  final String merchantId;
  final String networkId;
  final String signature;

  Da5Service({
    @required this.endpoint,
    @required this.username,
    @required this.merchantId,
    @required this.networkId,
    @required this.signature,
  });

  Future<Map<String, dynamic>> post(String resource,
      [Map<String, String> body]) async {
    String token = await getToken();
    print("token is $token");
    return await rawPost(resource, body, token);
  }

  Future<Map<String, dynamic>> rawPost(String resource,
      [Map<String, String> body, String token]) async {
    try {
      String uri = "$endpoint$resource";

      var authBody = {
        "Username": store.user.credentials.username,
        "MerchantID": store.user.credentials.merchantId,
        "NetworkID": store.user.credentials.networkId,
        "Authentication": store.user.credentials.authSignature,
      };

      Map<String, String> headers = {"Authorization": token};

      var requestBody = {...authBody};
      if (body != null) {
        requestBody = {...requestBody, ...body};
      }
      print("sending body $requestBody");

      var result = await http.post(
        Uri.parse(uri),
        headers: headers,
        body: requestBody,
      ).timeout(
          Duration(seconds: 15),
          onTimeout: () {
            throw TimeoutException("The connection has timed out, Please try again!");
          }
      );

      print("result ${result.body}");

      var response = jsonDecode(result.body);

      if (result.statusCode >= 200 && result.statusCode < 400) {
        return response;
      } else {
        String message;
        if (response["message"].runtimeType == String) {
          message = response["message"];
        } else {
          message = response['message']["reason"];
        }
        throw ApiResponseError(code: response["code"], message: message);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<String> getToken() async {
    try {
      var response = await rawPost("/authtimeout/token");
      return response['token'];
    } catch (e) {
      return null;
    }
  }

  //cash in
  Future<Map<String, dynamic>> postCashIn(String resource,
      [Map<String, String> body]) async {
    String token = await getPostToken();
    print("token is $token");
    return await rawPostCashIn(resource, body, token);
  }

  Future<Map<String, dynamic>> rawPostCashIn(String resource,
      [Map<String, String> body, String token]) async {
    try {
      Map<String, dynamic> a;
      String uri = "$endpoint$resource";

      Map<String, String> headers = {"Authorization": 'Bearer ${token}'};

      var requestBody;
      if (body != null) {
        requestBody = {...body};
      }
      print("sending body $requestBody");

      var result = await http.post(
        Uri.parse(uri),
        headers: headers,
        body: requestBody,
      ).timeout(
        Duration(seconds: 10),
        onTimeout: () async {
          throw TimeoutException("The connection has timed out, Please try again!");
        }
      );

      print("result ${result.body}");

      var response = jsonDecode(result.body);

      if (result.statusCode >= 200 && result.statusCode < 400) {
        return response;
      } else {
        String message;
        if (response["message"].runtimeType == String) {
          message = response["message"];
        } else {
          message = response['message']["reason"];
        }
        throw ApiResponseError(code: response["code"], message: message);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<String> getPostToken() async {
    try {
      var response = await rawPostCashIn("/api/user/accessToken", {
        "email": 'ceo@kabootekph.com',
        "password": "Athlon-X2",
      });
      return response['token'];
    } catch (e) {
      return null;
    }
  }

  Future<String> getVerifyToken() async {
    print('geting token');
    try {
      var request = await http.post(
        Uri.parse(endpoint + '/api/user/accessToken'),
        headers: null,
        body: {
          "email": "info@swipe.ph",
          "password": "Athlon-X2",
        }
      );
      var response = jsonDecode(request.body);
      return response['token'];
    } catch (e) {
      return null;
    }
  }

  Future<List<dynamic>> phApi ({@required String endpoint, String req = ""}) async {
    print('fetch ph services');
    try {
      var uri = PH_SERVICE_ENDPOINT + "/api/" + endpoint + (req == "" ? "" : "/" + req);
      var request = await http.get(Uri.parse(uri)).timeout(Duration(seconds: 15));
      var response = jsonDecode(request.body);

      if (request.statusCode >= 200 && request.statusCode < 400) {
        return response;
      } else {
        throw ApiResponseError(message: "Not Found");
      }
    } catch (e) {
      print(e);
    }

  }
}
