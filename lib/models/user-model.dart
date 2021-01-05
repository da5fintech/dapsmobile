import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String displayName;
  String mpin;
  String email;
  String photoURL;
  double balance;
  DateTime creationDate;

  UserModel(
      {this.id,
      this.displayName,
      this.mpin,
      this.email,
      this.photoURL,
      this.balance = 0.00,
      this.creationDate}) {
    creationDate = creationDate == null ? DateTime.now() : creationDate;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": displayName,
      "mpin": mpin,
      "email": email,
      "photoURL": photoURL,
      "balance": balance,
      "creationDate": creationDate
    };
  }

  String getInitials() {
    return displayName.substring(0, 1).toUpperCase();
  }

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot document) {
    var data = document.data();
    var model = new UserModel();
    var ts = data["creationDate"] as Timestamp;

    model.id = document.id;
    model.displayName = data["name"];
    model.mpin = data['mpin'];
    model.email = data['email'];
    model.photoURL = data['photoURL'];

    model.creationDate = ts.toDate();
    return model;
  }
}
