import 'package:flutter/material.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/models/auto-suggest-model.dart';
import 'package:daps/models/product-model.dart';
import 'package:daps/services/local-storage.dart';

class SaveSuggestionsServices {
  LocalStorage _localStorage = LocalStorage();
  List<BuyLoadSuggest> _saveNumbers = new List<BuyLoadSuggest>();
  List<AccountRecipient> _listAccountNumbers = new List<AccountRecipient>();
  List<AutoSweepSuggest> _listPlateNumbers = new List<AutoSweepSuggest>();

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

  ///save plate numbers
  Future<void> savePlateNumbers (AutosweepProduct plate) async {
    var alreadyExist = _listPlateNumbers.firstWhere(
            (el) => el.plateNumber == plate.plateNumber,
        orElse: () => null);
    if (alreadyExist == null) {
      _listPlateNumbers
          .add(AutoSweepSuggest(plateNumber: plate.plateNumber, type: SwipeServiceOffering.AUTOSWEEP));

      await _localStorage.openStorageBox('plate-numbers').then((box) {
        box.put('car-plates', _listPlateNumbers);
      });
    }
  }

  ///on load plate numbers
  Future<List<AutoSweepSuggest>> onloadPlateNumbers () async {
    _listPlateNumbers = [];
    await _localStorage.openStorageBox('plate-numbers').then((box) {
      List<dynamic> a = box.get('car-plates', defaultValue: []);
      a.forEach((plate) {
        _listPlateNumbers.add(plate);
      });
    });

    return _listPlateNumbers;

  }

  ///on load save numbers
  Future<List<BuyLoadSuggest>> onloadDirectSendNumbers() async {
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

  void deleteAll() async {
    final box = await _localStorage.openStorageBox('account-recipient-details');
    box.deleteFromDisk();
    print('DELETE LOCAL MEMMORY');
  }


  List<BuyLoadSuggest> get saveNumbers => _saveNumbers;

  List<AccountRecipient> get listAccountNumbers => _listAccountNumbers;

  List<AutoSweepSuggest> get listPlateNumbers => _listPlateNumbers;
}

