

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daps/models/product-model.dart';

class NotificationModel extends ProductModel {
  String id;
  int uid;
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
  String status;
  bool isSeen;

  NotificationModel({
    this.id,
    this.uid,
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
    this.status,
    this.isSeen = false,
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
    var data = document.data() as Map<String, dynamic>;
    var model = new NotificationModel();
    model.id = document.id;
    model.uid = data['uid'];
    model.ownerId = data['ownerId'];
    model.amount = data['amount'];
    model.senderDisplayName = data['senderDisplayName'];
    model.createdAt = data['createdAt'];
    model.subject = data['subject'];
    model.content = data['content'];
    model.receiverMobileNumber = data['receiverMobileNumber'];
    model.senderMobileNumber = data['senderMobileNumber'];
    model.receiverId = data['receiverId'];
    model.purpose = data['purpose'];
    model.profilePhoto = data['profilePhoto'];
    model.status = data['status'];
    model.isSeen = data['isSeen'] ?? false;
    return model;
  }



}