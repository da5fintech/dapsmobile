import 'dart:async';
import 'dart:convert';
import 'package:sensitive_http/http.dart' as http;
import 'package:daps/common/errors.dart';
import 'package:daps/services/da5-service.dart';
import 'package:daps/models/user-model.dart';
import 'package:flavor/flavor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DapsAuthenticationService extends Da5Service {
  SharedPreferences prefs;
  final endpoint = Flavor.instance.properties['dapsUrl'];
  DapsAuthenticationService({this.prefs});

  Future<UserModel> dapsAuth({String username, String password}) async {
    try {
      var url = Uri.parse('$endpoint/API_accounts/validate');
      var request = await http.post(
        url,
        headers: null,
        body: { 'username': username, 'password': password },
      ).timeout(Duration(seconds: 15), onTimeout:  () {
        throw new TimeoutException("The Connection has timed out! Please Try again.");
      });

      var response = jsonDecode(request.body);

      if(request.statusCode >= 200 && request.statusCode < 400) {
        var userDetails = response['collection']['user_details'][0];
        var apiDetails = response['collection']['api_details'][0];
        UserModel user = new UserModel(
          id: userDetails['id'],
          displayName: userDetails['members_name'],
          firstName: userDetails['members_first_name'],
          lastName: userDetails['members_last_name'],
          dateOfBirth: userDetails['members_dob'],
          address: apiDetails['rem_company_address'],
          mobileNumber: userDetails['members_mobile'],
          password: password,
          emailAddress: userDetails['members_email'],
          photoURL: userDetails['members_avatar'],
          level: 3,
          credentials: UserCredentials.fromMap(response),
        );
        return user;
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
      print('service error $e');
      throw e;
    }
  }

  Future<double> balanceSyncing (UserCredentials creds) async {
    try {
      var url = Uri.parse('$endpoint/authtimeout/token');
      var request = await http.post(
        url,
        headers: null,
        body: {
          "Username": creds.username,
          "MerchantID": creds.merchantId,
          "NetworkID": creds.networkId,
          "Authentication": creds.authSignature,
        },
      );

      var response = jsonDecode(request.body);

      if(request.statusCode >= 200 && request.statusCode < 400) {
        return double.parse(response['wallet']);
      } else {
        String message = response['message'];
        throw ApiResponseError(message: message);
      }
    } catch (e) {
      print('balance $e');
      throw e;
    }
  }

  Future<void> saveCredentials (UserCredentials creds) async {
    var credentialsJson = json.encode(creds.toMap());
    var a = prefs.setString('credentials', credentialsJson);
    print('saving $a');
  }

  UserCredentials getCredentials () {
    var getCredentials = prefs.getString('credentials') ?? '';
    print('getting credentials in local storage');
    print(getCredentials);
    var credentialsToMap = jsonDecode(getCredentials);
    return UserCredentials(
      networkId: credentialsToMap['networkId'],
      merchantId: credentialsToMap['merchantId'],
      username: credentialsToMap['username'],
      authSignature: credentialsToMap['authSignature'],
    );
  }

  void test() async{
    print('test');
    print(Flavor.instance.properties['dapsUrl']);
  }

}