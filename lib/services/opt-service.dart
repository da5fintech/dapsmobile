import 'package:sensitive_http/http.dart' as http;
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/errors.dart';

class OtpService {

  Future<void> sendOtp({String mobileNumber, int otp}) async {
    var message = "Your OTP verification is ${otp}";
    try {
      var a = await http.get(
          '${SMS_API}'
              'un=${SMS_USERNAME}&'
              'pwd=${SMS_PASSWORD}&'
              'dstno=${mobileNumber}&'
              'msg=${message}&agreedterm=YES&type=1&'
              'sendid=Swipe'
      );
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
          '${SMS_API}'
              'un=${SMS_USERNAME}&'
              'pwd=${SMS_PASSWORD}&'
              'dstno=${receiverMobileNumber}&'
              'msg=${message}&agreedterm=YES&type=1&'
              'sendid=Swipe'
      );
      var sender = await http.get(
          '${SMS_API}'
              'un=${SMS_USERNAME}&'
              'pwd=${SMS_PASSWORD}&'
              'dstno=${senderMobileNumber}&'
              'msg=${message}&agreedterm=YES&type=1&'
              'sendid=Swipe'
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> smsGreeting(String mobileNumber) async {
    var message =
        "We welcome you are valued user. "
        "You can now send money, buy load or pay bills, "
        "Thank you for using our SWIPE APP!";
    print('send sms greeting');
    try {
      var greetings = await http.get(
        '${SMS_API}'
        'un=${SMS_USERNAME}&'
            'pwd=${SMS_PASSWORD}&'
            'dstno=${mobileNumber}&'
            'msg=${message}&agreedterm=YES&type=1&'
            'sendid=Swipe'
      );
    } catch(err) {
      rethrow;
    }
  }

}