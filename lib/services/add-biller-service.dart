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

  void deleteBiller (BillerProduct biller) {
    int index = _billers.indexWhere((b) => b.name == biller.name);
    _billers.removeAt(index);
  }

  void test() {
    print('test call function');
  }

  List<BillerProduct> get billers => _billers;
}