import 'package:swipe/common/constants.dart';
import 'package:swipe/models/product-model.dart';

class TransactionModel {
  String id;
  SwipeServiceOffering offering;
  ProductModel product;
  String recipient;

  TransactionModel({this.id, this.offering, this.recipient, this.product});

  factory TransactionModel.fromJson(Map<String, dynamic> data, {id}) {
    // Map geoLocationMap = json['geoLocation'] as Map;
    // var geoLocation = null != geoLocationMap ? new GeoLocation(lat: geoLocationMap['lat'], lon: geoLocationMap['lon']) : null;

    return TransactionModel(
      id: id,
    );
  }
}
