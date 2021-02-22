import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  bool isNew;
  String id;
  String displayName;
  String firstName;
  String lastName;
  String birthdate;
  String mobileNumber;
  String mpin;
  String email;
  String photoURL;
  double balance;
  double swipePoints;
  DateTime creationDate;
  String password;

  UserModel(
      {this.isNew = false,
      this.id,
      this.displayName,
      this.firstName,
      this.lastName,
      this.birthdate,
      this.mobileNumber,
      this.password,
      this.mpin,
      this.email,
      this.photoURL,
      this.balance = 0.00,
      this.swipePoints = 0.00,
      this.creationDate}) {
    creationDate = creationDate == null ? DateTime.now() : creationDate;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "displayName": displayName,
      "firstName": firstName,
      "lastName": lastName,
      "birthdate": birthdate,
      "mobileNumber": mobileNumber,
      "mpin": mpin,
      "email": email,
      "photoURL": photoURL,
      "balance": balance,
      "creationDate": creationDate,
      "swipePoints": swipePoints,
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
    model.balance = data["balance"] + .0;
    model.displayName = data["displayName"];
    model.firstName = data["firstName"];
    model.lastName = data["lastName"];
    model.birthdate = data["birthdate"];
    model.mobileNumber = data["mobileNumber"];
    model.password = data["password"];
    model.mpin = data['mpin'];
    model.email = data['email'];
    model.photoURL = data['photoURL'];
    model.swipePoints = data['swipePoints'] ?? 0.00;
    model.creationDate = ts.toDate();
    return model;
  }
}
