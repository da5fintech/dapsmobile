import 'package:flutter/material.dart';
import 'package:swipe/models/product-model.dart';

class AddBillerService {
  ///API add biller service
  ///Save biller for each unique user

  List<BillerProduct> _billers = new List();

  void addBiller (BillerProduct biller) {
    _billers.add(biller);
    print(_billers.length);
  }

  void deleteBiller () {

  }

  void test() {
    print('test call function');
  }

  List<BillerProduct> get billers => _billers;
}