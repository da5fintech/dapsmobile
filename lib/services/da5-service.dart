import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:sensitive_http/http.dart' as http;
import 'package:swipe/common/errors.dart';

class Da5Service {
  final String endpoint;
  final String username;
  final String merchantId;
  final String networkId;
  final String signature;
  Da5Service(
      {@required this.endpoint,
      @required this.username,
      @required this.merchantId,
      @required this.networkId,
      @required this.signature});

  Future<Map<String, dynamic>> post(String resource,
      [Map<String, String> body]) async {
    String token = await getToken();
    print("token is $token");
    return await _post(resource, body, token);
  }

  Future<Map<String, dynamic>> _post(String resource,
      [Map<String, String> body, String token]) async {
    try {
      String uri = "$endpoint$resource";

      var authBody = {
        "Username": username,
        "MerchantID": merchantId,
        "NetworkID": networkId,
        "Authentication": signature
      };

      Map<String, String> headers = {"Authorization": token};

      var requestBody = {...authBody};
      if (body != null) {
        requestBody = {...requestBody, ...body};
      }
      print("sending body $requestBody");

      var result = await http.post(
        uri,
        headers: headers,
        body: requestBody,
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
      var response = await _post("/authtimeout/token");
      return response['token'];
    } catch (e) {
      return null;
    }
  }
}
