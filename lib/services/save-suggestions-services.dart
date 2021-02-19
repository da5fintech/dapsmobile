import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/models/auto-suggest-model.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/services/local-storage.dart';

class SaveSuggestionsServices {
  LocalStorage _localStorage = LocalStorage();
  List<BuyLoadSuggest> _saveNumbers = new List<BuyLoadSuggest>();
  List<AccountRecipient> _listAccountNumbers = new List<AccountRecipient>();

  ///save recipient numbers
  Future<void> saveNumber(
      String mobileNumber, SwipeServiceOffering typeService) async {
    var alreadyExist = _saveNumbers.firstWhere(
        (el) => el.mobileNumber == mobileNumber,
        orElse: () => null);
    if (alreadyExist == null) {
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
      print(a);
      a.forEach((num) {
        _saveNumbers.add(num);
      });
    });

    return _saveNumbers;
  }

  ///save account numbers
  Future<void> saveAccountNumbers(
      InstapayBankProduct account, SwipeServiceOffering type) async {
    var alreadyExist = _listAccountNumbers.firstWhere(
        (el) => el.accountNumber == account.accountNumber,
        orElse: () => null);
    if (alreadyExist == null) {
      _listAccountNumbers.add(AccountRecipient(
          accountNumber: account.accountNumber,
          fullname: account.recipientName,
          type: type));

      await _localStorage
          .openStorageBox('account-recipient-details')
          .then((box) {
        box.put('recipient-details', _listAccountNumbers);
      });
    }
  }

  ///on load save account numbers.
  Future<List<AccountRecipient>> onloadAccountDetails() async {
    _listAccountNumbers = [];
    await _localStorage.openStorageBox('account-recipient-details').then((box) {
      List<dynamic> a = box.get('recipient-details', defaultValue: []);
      a.forEach((accountDetails) {
        _listAccountNumbers.add(accountDetails);
      });
    });
    return _listAccountNumbers;
  }

  void deleteAll() async {
    final box = await _localStorage.openStorageBox('account-recipient-details');
    box.deleteFromDisk();
    print('DELETE LOCAL MEMMORY');
  }

  List<BuyLoadSuggest> get saveNumbers => _saveNumbers;

  List<AccountRecipient> get listAccountNumbers => _listAccountNumbers;
}
