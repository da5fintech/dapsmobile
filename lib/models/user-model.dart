import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  bool thirdPartySign;
  bool isNew;
  String id;
  String displayName;
  String firstName;
  String lastName;
  String dateOfBirth;
  String mobileNumber;
  String address;
  String mpin;
  String emailAddress;
  String photoURL;
  double balance;
  double swipePoints;
  int level;
  DateTime createdAt;
  DateTime updatedAt;
  String password;

  UserModel(
      {this.thirdPartySign = false,
      this.isNew = false,
      this.id,
      this.displayName,
      this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.address,
      this.mobileNumber,
      this.password,
      this.mpin,
      this.emailAddress,
      this.photoURL,
      this.balance = 0.00,
      this.swipePoints = 0.00,
      this.level = 1,
      this.createdAt}) {
    createdAt = createdAt == null ? DateTime.now() : createdAt;
    updatedAt = updatedAt == null ? DateTime.now() : updatedAt;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "displayName": displayName,
      "firstName": firstName,
      "lastName": lastName,
      "dateOfBirth": dateOfBirth,
      "address": address,
      "mobileNumber": mobileNumber,
      "mpin": mpin,
      "emailAddress": emailAddress,
      "photoURL": photoURL,
      "balance": balance,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "swipePoints": swipePoints,
      "level": level,
    };
  }

  String getInitials() {
    return displayName.substring(0, 1).toUpperCase();
  }

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot document) {
    var data = document.data() as Map<String, dynamic>;
    var model = new UserModel();
    var ts = data["createdAt"] as Timestamp;
    var uts = data['updatedAt'] as Timestamp;

    model.id = document.id;
    model.balance = data["balance"] + .0;
    model.displayName = data["displayName"];
    model.firstName = data["firstName"];
    model.lastName = data["lastName"];
    model.dateOfBirth = data["dateOfBirth"];
    model.address = data['address'] ?? "";
    model.mobileNumber = data["mobileNumber"];
    model.password = data["password"];
    model.mpin = data['mpin'];
    model.emailAddress = data['emailAddress'];
    model.photoURL = data['photoURL'];
    model.swipePoints = data['swipePoints'] ?? 0.00;
    model.level = data['level'] ?? 1;
    model.createdAt = ts.toDate();
    model.updatedAt = uts.toDate();
    return model;
  }
}
