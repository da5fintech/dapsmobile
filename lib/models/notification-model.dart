

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String id;
  String createdAt;
  String title;
  String content;
  String userAssociated;
  String belongsTo;

  NotificationModel({
    this.id,
    this.createdAt,
    this.title,
    this.content,
    this.userAssociated,
    this.belongsTo,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'title': title,
      'content': content,
      'userAssociated': userAssociated,
      'belongsTo': belongsTo,
    };
  }

  factory NotificationModel.fromDocumentSnapshot(DocumentSnapshot document) {
    var data = document.data();
    var model = new NotificationModel();
    model.id = data['id'];
    model.createdAt = data['createdAt'];
    model.title = data['title'];
    model.content = data['content'];
    model.userAssociated = data['userAssociated'];
    model.belongsTo = data['belongsTo'];
    return model;
  }



}