import 'package:swipe/common/constants.dart';

class TransactionModel {
  String id;
  SwipeServiceOffering offering;
  String recipient;
  double amount;

  TransactionModel({this.id, this.offering, this.recipient, this.amount});

  factory TransactionModel.fromJson(Map<String, dynamic> data, {id}) {
    // Map geoLocationMap = json['geoLocation'] as Map;
    // var geoLocation = null != geoLocationMap ? new GeoLocation(lat: geoLocationMap['lat'], lon: geoLocationMap['lon']) : null;

    return TransactionModel(
      id: id,
    );
  }
}
