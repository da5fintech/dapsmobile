import 'package:flutter/material.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/services/local-storage.dart';

class AddBillerService {
  LocalStorage storage = LocalStorage();
  ///API add biller service
  ///Save biller for each unique user

  List<BillerProduct> _billers = new List();

  void addBiller (BillerProduct biller) async {
    _billers.add(biller);
   await storage.openStorageBox('billers').then((box) {
     box.put('list-billers', _billers);
   });
  }

  void deleteBiller (BillerProduct biller) async {
    int index = _billers.indexWhere((b) => b.name == biller.name);
    _billers.removeAt(index);
    await storage.openStorageBox('billers').then((box) {
      box.put('list-billers', _billers);
    });
  }

  Future<List<BillerProduct>> onLoading () async {
    await storage.openStorageBox('billers').then((box) {
      List<dynamic> listBillers = box.get('list-billers', defaultValue: []);
      listBillers.forEach((biller) {
        _billers.add(biller);
      });
    });

    return _billers;
  }

  void deleteAll() async {
    final box = await storage.openStorageBox('billers');
    box.deleteFromDis();
    print('DELETE LOCAL MEMMORY');
  }

  void test() {
    print('test call function');
  }

  List<BillerProduct> get billers => _billers;
}