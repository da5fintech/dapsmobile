

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swipe/models/product-model.dart';

class NotificationModel extends ProductModel {
  String ownerId;
  String createdAt;
  String subject;
  String content;
  String receiverMobileNumber;
  String receiverId;
  String purpose;
  String profilePhoto;

  NotificationModel({
    this.ownerId,
    this.createdAt,
    this.subject,
    this.content,
    this.receiverMobileNumber,
    this.receiverId,
    this.purpose,
    this.profilePhoto,
    double amount,
  }) : super(amount: amount);


  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'createdAt': createdAt,
      'subject': subject,
      'content': content,
      'receiverMobileNumber': receiverMobileNumber,
      'receiverId': receiverId,
      'purpose': purpose,
      'profilePhoto': profilePhoto,
      'amount': amount,
    };
  }

  factory NotificationModel.fromDocumentSnapshot(DocumentSnapshot document) {
    var data = document.data();
    var model = new NotificationModel();
    model.ownerId = data['ownerId'];
    model.createdAt = data['createdAt'];
    model.subject = data['subject'];
    model.content = data['content'];
    model.receiverMobileNumber = data['receiverMobileNumber'];
    model.receiverId = data['receiverId'];
    model.purpose = data['purpose'];
    model.profilePhoto = data['profilePhoto'];
    return model;
  }



}