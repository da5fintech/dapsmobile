// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application-store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ApplicationStore on _ApplicationStore, Store {
  final _$versionNumberAtom = Atom(name: '_ApplicationStore.versionNumber');

  @override
  String get versionNumber {
    _$versionNumberAtom.reportRead();
    return super.versionNumber;
  }

  @override
  set versionNumber(String value) {
    _$versionNumberAtom.reportWrite(value, super.versionNumber, () {
      super.versionNumber = value;
    });
  }

  final _$userAtom = Atom(name: '_ApplicationStore.user');

  @override
  UserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$balanceAtom = Atom(name: '_ApplicationStore.balance');

  @override
  double get balance {
    _$balanceAtom.reportRead();
    return super.balance;
  }

  @override
  set balance(double value) {
    _$balanceAtom.reportWrite(value, super.balance, () {
      super.balance = value;
    });
  }

  final _$swipePointsAtom = Atom(name: '_ApplicationStore.swipePoints');

  @override
  double get swipePoints {
    _$swipePointsAtom.reportRead();
    return super.swipePoints;
  }

  @override
  set swipePoints(double value) {
    _$swipePointsAtom.reportWrite(value, super.swipePoints, () {
      super.swipePoints = value;
    });
  }

  final _$savedBillersAtom = Atom(name: '_ApplicationStore.savedBillers');

  @override
  List<BillerProduct> get savedBillers {
    _$savedBillersAtom.reportRead();
    return super.savedBillers;
  }

  @override
  set savedBillers(List<BillerProduct> value) {
    _$savedBillersAtom.reportWrite(value, super.savedBillers, () {
      super.savedBillers = value;
    });
  }

  final _$enabledBiometricsAtom =
      Atom(name: '_ApplicationStore.enabledBiometrics');

  @override
  bool get enabledBiometrics {
    _$enabledBiometricsAtom.reportRead();
    return super.enabledBiometrics;
  }

  @override
  set enabledBiometrics(bool value) {
    _$enabledBiometricsAtom.reportWrite(value, super.enabledBiometrics, () {
      super.enabledBiometrics = value;
    });
  }

  final _$idImageAtom = Atom(name: '_ApplicationStore.idImage');

  @override
  File get idImage {
    _$idImageAtom.reportRead();
    return super.idImage;
  }

  @override
  set idImage(File value) {
    _$idImageAtom.reportWrite(value, super.idImage, () {
      super.idImage = value;
    });
  }

  final _$faceImageAtom = Atom(name: '_ApplicationStore.faceImage');

  @override
  File get faceImage {
    _$faceImageAtom.reportRead();
    return super.faceImage;
  }

  @override
  set faceImage(File value) {
    _$faceImageAtom.reportWrite(value, super.faceImage, () {
      super.faceImage = value;
    });
  }

  final _$_ApplicationStoreActionController =
      ActionController(name: '_ApplicationStore');

  @override
  dynamic setVersionNumber(String version) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.setVersionNumber');
    try {
      return super.setVersionNumber(version);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic createTransaction(SwipeServiceOffering offering, dynamic recipient) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.createTransaction');
    try {
      return super.createTransaction(offering, recipient);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTransactionProduct(ProductModel product, double amount) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.setTransactionProduct');
    try {
      return super.setTransactionProduct(product, amount);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setNewBalance(double amount) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.setNewBalance');
    try {
      return super.setNewBalance(amount);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setNewSwipeBalance(double currentSwipePoints) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.setNewSwipeBalance');
    try {
      return super.setNewSwipeBalance(currentSwipePoints);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUser(UserModel user) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.setUser');
    try {
      return super.setUser(user);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setNewBiller(List<BillerProduct> billerProduct) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.setNewBiller');
    try {
      return super.setNewBiller(billerProduct);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setId(File image) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.setId');
    try {
      return super.setId(image);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFace(File image) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.setFace');
    try {
      return super.setFace(image);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
versionNumber: ${versionNumber},
user: ${user},
balance: ${balance},
swipePoints: ${swipePoints},
savedBillers: ${savedBillers},
enabledBiometrics: ${enabledBiometrics},
idImage: ${idImage},
faceImage: ${faceImage}
    ''';
  }
}
