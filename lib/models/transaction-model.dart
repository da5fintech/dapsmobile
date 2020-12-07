import 'package:swipe/common/constants.dart';
import 'package:swipe/models/product-model.dart';

class TransactionModel {
  String id;
  SwipeServiceOffering offering;
  ProductModel product;
  String recipient;
  TransactionModel({this.id, this.offering, this.recipient, this.product});
}

abstract class TransactionProcessingResponse {
  int status;
  String reference;
  String message;
  String result;

  TransactionProcessingResponse(
      {this.status, this.reference, this.message, this.result});
}
