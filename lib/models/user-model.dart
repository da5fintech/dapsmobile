import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String mpin;
  String email;
  double balance;
  DateTime creationDate;

  UserModel(
      {this.id,
      this.mpin,
      this.email,
      this.balance = 0.00,
      this.creationDate}) {
    creationDate = creationDate == null ? DateTime.now() : creationDate;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "mpin": mpin,
      "email": email,
      "balance": balance,
      "creationDate": creationDate
    };
  }

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot document) {
    var data = document.data();
    var model = new UserModel();
    var ts = data["creationDate"] as Timestamp;

    model.id = document.id;
    model.mpin = data['mpin'];
    model.email = data['email'];
    model.creationDate = ts.toDate();
    return model;
  }
}
