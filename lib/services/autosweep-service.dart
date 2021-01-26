import 'package:swipe/common/constants.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/models/transaction-model.dart';
import 'package:swipe/services/da5-service.dart';
import 'package:swipe/common/errors.dart';

class AutosweepProcessingResponse extends TransactionProcessingResponse {
  AutosweepProcessingResponse({status, reference, message, result})
      : super(
          status: status,
          reference: reference,
          message: message,
          result: result,
        );

  factory AutosweepProcessingResponse.fromMap(Map<String, dynamic> map) {
    if (map.containsKey("status") && map["status"] == 200) {
      var ref = map["trans_status"];
      return AutosweepProcessingResponse(
        message: map["message"],
        result: map["message"],
        reference: ref,
        status: true,
      );
    }

    var errors = map["message"];
    String message = "UNKNOWN ERROR";
    if (errors.length > 0) {
      message = map["message"];
    }
    return AutosweepProcessingResponse(
      message: message,
      result: message,
      reference: "",
      status: false,
    );
  }
}

class AutosweepService extends Da5Service {
  AutosweepService()
      : super(
          endpoint: API_ENDPOINT,
          merchantId: AUTH_MERCHANT_ID,
          networkId: AUTH_NETWORK_ID,
          signature: AUTH_SIGNATURE,
          username: AUTH_USERNAME,
        );

  Future<AutosweepProcessingResponse> process(
    AutosweepProduct product,
    double amount,
  ) async {
    try {
      double total = amount + AUTOSWEEP_FEE;
      Map<String, String> params = {
        "Scope": AUTOSWEEP_SCOPE,
        "Amount": formatterWithoutPHP.format(total).replaceFirst(" ", ""),
        "PlateNumber": product.plateNumber
      };

      var response = await post("/API_autosweep/process", params);
      print("response: ${response} ");
      return AutosweepProcessingResponse.fromMap(response);
    } on ApiResponseError catch (e) {
      print("caught2");
      return AutosweepProcessingResponse(
        status: false,
        reference: "",
        message: "Failed processing. \ncode: ${e.code} \nreason: ${e.message}",
        result: "",
      );
    } on InstapayProcessingError catch (e) {
      print("caught1");
      return AutosweepProcessingResponse(
        status: false,
        reference: "",
        message: "Failed processing. \ncode: ${e.code}, \nreason: ${e.message}",
        result: "",
      );
    } catch (e, stack) {
      print("caught ${e}");
      print(stack);

      return AutosweepProcessingResponse(
        status: false,
        reference: "",
        message: "Failed processing. \nreason: UNKNOWN",
        result: "",
      );
    }
  }
}
