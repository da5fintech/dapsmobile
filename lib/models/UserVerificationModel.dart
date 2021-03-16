import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class UserVerificationModel {
  String idType;
  String idNumber;
  String firstName;
  String middleName;
  String lastName;
  String nationality;
  String placeOfBirth;
  String contactNumber;
  String dateOfBirth;
  String address;
  String barangay;
  String city;
  String zipCode;
  String state;
  String country;
  String natureOfWork;
  String sourceOfIncome;
  File id;
  File face;


  UserVerificationModel({
    this.idType,
    this.idNumber,
    this.firstName,
    this.middleName,
    this.lastName,
    this.nationality,
    this.placeOfBirth,
    this.contactNumber,
    this.dateOfBirth,
    this.address,
    this.barangay,
    this.city,
    this.zipCode,
    this.state,
    this.country,
    this.natureOfWork,
    this.sourceOfIncome,
    this.id,
    this.face,
  });

}