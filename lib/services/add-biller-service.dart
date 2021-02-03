import 'package:flutter/material.dart';
import 'package:swipe/models/product-model.dart';

class AddBillerService {
  ///API add biller service
  ///Save biller for each unique user

  List<SavedBiller> _billers = new List();

  void AddBiller (SavedBiller biller) {
    _billers.add(biller);
  }

  void DeleteBiller () {

  }

  void test() {
    print('test call function');
  }

  List<SavedBiller> get billers => _billers;
}