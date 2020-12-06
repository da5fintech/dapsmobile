import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/services/eloading-service.dart';

void main() {
  test('DA5 Must return products', () async {
    final service = new EloadingService();
    List<ProductModel> products = await service.getProducts("639672057407");
    expect(products, isNot(null));
    // expect(1, 1);
  });
}
