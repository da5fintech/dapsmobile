import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/models/product-model.dart';

class TransactionModel {
  String id;
  SwipeServiceOffering offering;
  ProductModel product;
  String recipient;
  // Amount to be paid for by user for the product
  double amount;
  TransactionModel({this.id, this.offering, this.recipient, this.product});
}

abstract class TransactionProcessingResponse {
  bool status;
  String reference;
  String message;
  String result;

  TransactionProcessingResponse(
      {this.status, this.reference, this.message, this.result});
}

class GenericProcessingResponse extends TransactionProcessingResponse {
  GenericProcessingResponse(
      {status = false, reference = "", message = "", result = ""})
      : super(
            status: status,
            reference: reference,
            message: message,
            result: result);
}

class TransactionRecordModel {
  String id;
  String reference;
  String product;
  String transactionType;
  String transactionTypePretty;
  double amount;
  double totalAmount;
  String recipient;
  bool status;
  String reason;
  DateTime creationDate;

  TransactionRecordModel(
      {this.reference,
      this.product,
      this.transactionType,
      this.transactionTypePretty,
      this.amount,
      this.totalAmount,
      this.recipient,
      this.status,
      this.reason,
      this.creationDate});

  Map<String, dynamic> toMap() {
    return {
      "reference": reference,
      "product": product,
      "transactionType": transactionType,
      "transactionTypePretty": transactionTypePretty,
      "amount": amount,
      "totalAmount": totalAmount,
      "recipient": recipient,
      "status": status,
      "reason": reason,
      "creationDate": creationDate
    };
  }

  factory TransactionRecordModel.fromDocumentSnapshot(
      DocumentSnapshot document) {
    var data = document.data();
    var model = new TransactionRecordModel();
    var ts = data["creationDate"] as Timestamp;

    model.id = document.id;
    model.reference = data["reference"];
    model.product = data["product"];
    model.transactionType = data["transactionType"];
    model.transactionTypePretty = data["transactionTypePretty"];
    model.amount = data["amount"] + .0;
    model.totalAmount = data["totalAmount"] + .0;
    model.recipient = data["recipient"];
    model.status = data["status"];
    model.reason = data["reason"];
    model.creationDate = ts.toDate();
    return model;
  }
}
