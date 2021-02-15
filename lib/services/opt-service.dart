import 'package:sensitive_http/http.dart' as http;
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/errors.dart';

class OtpService {

  Future<void> sendOtp ({String mobileNumber, int otp}) async {
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
    } on ApiResponseError catch(e) {
      print("Failed $e");
    } catch (err) {
      throw Exception(err);
    }
  }

}