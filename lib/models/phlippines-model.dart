import 'package:flutter/material.dart';

class RegionModel {
  int id;
  String psgcCode;
  String regDesc;
  String regCode;

  RegionModel({this.id, this.psgcCode, this.regDesc, this.regCode});

  factory RegionModel.fromMap(Map<String, dynamic> map) {
    return RegionModel(
      id: map['id'],
      psgcCode: map['psgcCode'],
      regDesc: map['regDesc'],
      regCode: map['regCode'],
    );
  }

}

class ProvinceModel{
  int id;
  String psgcCode;
  String provDesc;
  String regCode;
  String provCode;

  ProvinceModel({this.id, this.psgcCode, this.provDesc, this.regCode, this.provCode});

  factory ProvinceModel.fromMap(Map<String, dynamic> map) {
    return ProvinceModel(
      id: map['id'],
      psgcCode: map['psgcCode'],
      provDesc: map['provDesc'],
      regCode: map['regCode'],
      provCode: map['provCode'],
    );
  }
}

class CityModel {
  int id;
  String psgcCode;
  String citymunDesc;
  String regDesc;
  String provCode;
  String citymunCode;

  CityModel({
    this.id,
    this.psgcCode,
    this.citymunDesc,
    this.regDesc,
    this.provCode,
    this.citymunCode,
  });

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'],
      psgcCode: map['psgcCode'],
      citymunDesc: map['citymunDesc'],
      regDesc: map['regDesc'],
      provCode: map['provCode'],
      citymunCode: map['citymunCode'],
    );
  }

}

class BarangayModel {
  int id;
  String brgyCode;
  String brgyDesc;
  String regCode;
  String provCode;
  String citymunCode;

  BarangayModel({
    this.id,
    this.brgyCode,
    this.brgyDesc,
    this.regCode,
    this.provCode,
    this.citymunCode
  });

  factory BarangayModel.fromMap(Map<String, dynamic> map) {
    return BarangayModel(
      id: map['id'],
      brgyCode: map['brgyCode'],
      brgyDesc: map['brgyDesc'],
      regCode: map['regCode'],
      provCode: map['provCode'],
      citymunCode: map['citymunCode'],
    );
  }

}















