import 'dart:async';

import 'package:flavor/flavor.dart';
import 'package:flutter/material.dart';

import 'main.dart';

Future main() async {
  Flavor.create(
    Environment.dev,
    color: Colors.green,
    name: 'PREVIEW',
    properties: {
      namespaceKey: "dev_",
      packageIdKey: "ph.kabootek.dapsmobile",
      dapsUrl: "https://accounts.daps.ph/staging/index.php",
    },
  );
  setupApp();
}
