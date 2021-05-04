

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swipe/models/product-model.dart';

class NotificationModel extends ProductModel {
  String ownerId;
  String senderDisplayName;
  String createdAt;
  String subject;
  String content;
  String receiverMobileNumber;
  String senderMobileNumber;
  String receiverId;
  String purpose;
  String profilePhoto;

  NotificationModel({
    this.ownerId,
    this.senderDisplayName,
    this.createdAt,
    this.subject,
    this.content,
    this.receiverMobileNumber,
    this.senderMobileNumber,
    this.receiverId,
    this.purpose,
    this.profilePhoto,
    double amount,
  }) : super(amount: amount);


  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'senderDisplayName': senderDisplayName,
      'createdAt': createdAt,
      'subject': subject,
      'content': content,
      'receiverMobileNumber': receiverMobileNumber,
      'senderMobileNumber': senderMobileNumber,
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
    model.senderMobileNumber = data['senderDisplayName'];
    model.createdAt = data['createdAt'];
    model.subject = data['subject'];
    model.content = data['content'];
    model.receiverMobileNumber = data['receiverMobileNumber'];
    model.senderMobileNumber = data['senderMobileNumber'];
    model.receiverId = data['receiverId'];
    model.purpose = data['purpose'];
    model.profilePhoto = data['profilePhoto'];
    return model;
  }



}