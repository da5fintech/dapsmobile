import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart';
import 'package:sensitive_http/http.dart' as http;
import 'package:swipe/common/constants.dart';
import 'package:swipe/models/UserVerificationModel.dart';
import 'package:swipe/models/user-model.dart';
import 'package:swipe/services/da5-service.dart';

class VerifyResponse {
  bool result;
  Map<String, dynamic>error;
  String timestamp;
  String referenceNumber;

  VerifyResponse(
      {this.result, this.error, this.timestamp, this.referenceNumber});


}

class VerifyService extends Da5Service {
  VerifyService()
      : super(
    merchantId: VERIFY_MERCHANT_ID,
    networkId: VERIFY_NETWORK_ID,
    signature: VERIFY_SIGNATURE,
    username: VERIFY_USERNAME,
    endpoint: VERIFY_ENDPOINT,
  );

  Future<VerifyResponse> verify(UserVerificationModel vUser,
      UserModel user) async {
    try {
      String token = await getVerifyToken();
      print(token);

      var uri = Uri.parse(VERIFY_ENDPOINT + '/api/user/verify');
      Map<String, String> headers = {"Authorization": 'Bearer ${token}'};

      var idStream = new http.ByteStream(DelegatingStream(vUser.id.openRead()));
      var idLength = await vUser.id.length();
      var idFile = new http.MultipartFile(
          'id_scanned', idStream.cast(), idLength,
          filename: basename('${user.id}/${vUser.idType}/${user.displayName}'));

      var faceStream =
      new http.ByteStream(DelegatingStream(vUser.face.openRead()));
      var faceLength = await vUser.face.length();
      var faceFile = new http.MultipartFile(
          'face_scanned', faceStream.cast(), faceLength,
          filename: basename('${user.id}/${user.displayName}'));

      var request = new http.MultipartRequest("POST", uri);
      request.headers.addAll(headers);
      request.files.add(idFile);
      request.files.add(faceFile);
      request.fields["user_id"] = user.id;
      request.fields["first_name"] = vUser.firstName;
      request.fields["middle_name"] = vUser.middleName ?? "";
      request.fields["last_name"] = vUser.lastName;
      request.fields["has_middle_name"] = vUser.middleName ?? "N";
      request.fields["gender"] = "M";
      request.fields["display_name"] = "${vUser.firstName} ${vUser.lastName}";
      request.fields["mobile_number"] = vUser.contactNumber;
      request.fields["id_type"] = vUser.idType;
      request.fields["id_number"] = vUser.idNumber;
      request.fields["email_address"] = user.emailAddress;
      request.fields["date_of_birth"] = vUser.dateOfBirth;
      request.fields["place_of_birth"] = vUser.placeOfBirth;
      request.fields["nationality"] = vUser.nationality;
      request.fields["state"] = vUser.state;
      request.fields["city"] = vUser.city;
      request.fields["address"] = vUser.address;
      request.fields["barangay"] = vUser.barangay;
      request.fields["country"] = vUser.country;
      request.fields["nature_of_work"] = vUser.natureOfWork;
      request.fields["position_level"] = "Entry Level";
      request.fields["source_of_funds"] = vUser.sourceOfIncome;

      var result = await request.send();
      var response = await http.Response.fromStream(result);
      var map = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 400) {
        return VerifyResponse(
          result: true,
          referenceNumber: map['reference_number'].toString(),
          timestamp: map['timestamp'].toString(),
        );
      } else {
        return VerifyResponse(
          result: false,
          error: map['error'],
          timestamp: map['timestamp'].toString(),
        );
      }

    } catch (err) {
      print(err);
      return VerifyResponse(
        result: false,
        error: {"errorResponse": ['Unknown']},
        timestamp: null,
      );
    }
  }

  void test() {
    print('test');
  }
}
