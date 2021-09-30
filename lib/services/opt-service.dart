import 'package:sensitive_http/http.dart' as http;
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/errors.dart';
import 'package:swipe/models/user-model.dart';

class OtpService {

  Future<void> sendOtp({String mobileNumber, int otp}) async {
    var message = "Your OTP verification is ${otp}";
    try {
      var a = await http.get(
          Uri.parse('${SMS_API}'
              'un=${SMS_USERNAME}&'
              'pwd=${SMS_PASSWORD}&'
              'dstno=${mobileNumber}&'
              'msg=${message}&agreedterm=YES&type=1&'
              'sendid=Swipe'));
      print(a.statusCode);
    } on ApiResponseError catch (e) {
      print("Failed $e");
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> sendReferenceNumber(
      {String senderName, String senderMobileNumber, String amount, String senderMessage, String receiverMobileNumber, String referenceNumber}) async {
    var message =
        "You have received PHP ${amount}\n"
        "from ${senderName}\n"
        "Your reference Number is ${referenceNumber}\n"
        "Sender Message ${senderMessage}";
    try {
      var receiver = await http.get(
          Uri.parse('${SMS_API}'
              'un=${SMS_USERNAME}&'
              'pwd=${SMS_PASSWORD}&'
              'dstno=${receiverMobileNumber}&'
              'msg=${message}&agreedterm=YES&type=1&'
              'sendid=Swipe')
      );
      var sender = await http.get(
          Uri.parse('${SMS_API}'
              'un=${SMS_USERNAME}&'
              'pwd=${SMS_PASSWORD}&'
              'dstno=${senderMobileNumber}&'
              'msg=${message}&agreedterm=YES&type=1&'
              'sendid=Swipe')
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> smsGreeting(String mobileNumber) async {
    var message = REGISTRATION_SCREEN_OTP_GREET;
    print('send sms greeting');
    try {
      var greetings = await http.get(
        Uri.parse('${SMS_API}'
            'un=${SMS_USERNAME}&'
            'pwd=${SMS_PASSWORD}&'
            'dstno=${mobileNumber}&'
            'msg=${message}&agreedterm=YES&type=1&'
            'sendid=Swipe')
      );
    } catch(err) {
      rethrow;
    }
  }

  Future<void> forgotMpin(String mobileNumber, UserModel user) async {
    var message = "Your MPIN is ${user.mpin}\nPlease delete this after reading this.";
    try {
      var mpinReq = await http.get(
          Uri.parse('${SMS_API}'
              'un=${SMS_USERNAME}&'
              'pwd=${SMS_PASSWORD}&'
              'dstno=${mobileNumber}&'
              'msg=${message}&agreedterm=YES&type=1&'
              'sendid=Swipe')
      );
    } catch(err) {
      rethrow;
    }
  }

}