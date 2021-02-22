import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/models/auto-suggest-model.dart';
import 'package:swipe/services/local-storage.dart';

class SaveSuggestionsServices {
  LocalStorage _localStorage = LocalStorage();
  List<BuyLoadSuggest> _saveNumbers = new List<BuyLoadSuggest>();

  ///save recipient numbers
  Future<void> saveNumber(
      String mobileNumber, SwipeServiceOffering typeService) async {

    var alreadyExist = _saveNumbers.firstWhere(
        (el) => el.mobileNumber == mobileNumber,
        orElse: () => null);
    if(alreadyExist == null) {
      _saveNumbers
          .add(BuyLoadSuggest(mobileNumber: mobileNumber, type: typeService));

      await _localStorage.openStorageBox('mobile-numbers').then((box) {
        box.put('numbers', _saveNumbers);
      });
    }
  }

  ///on load save numbers
  Future<List<BuyLoadSuggest>> onloadNumbers() async {
    _saveNumbers = []; //reset
    await _localStorage.openStorageBox('mobile-numbers').then((box) {
      List<dynamic> a = box.get('numbers', defaultValue: []);
      a.forEach((num) {
        _saveNumbers.add(num);
      });
    });

    return _saveNumbers;
  }

  void deleteAll() async {
    final box = await _localStorage.openStorageBox('mobile-numbers');
    box.deleteFromDisk();
    print('DELETE LOCAL MEMMORY');
  }

  List<BuyLoadSuggest> get saveNumbers => _saveNumbers;
}
