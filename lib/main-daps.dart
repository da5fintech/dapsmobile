import 'dart:async';

import 'package:flavor/flavor.dart';
import 'package:flutter/material.dart';

import 'main.dart';

Future main() async {
  Flavor.create(
    Environment.production,
    color: Colors.green,
    properties: {
      namespaceKey: "daps_",
      packageIdKey: "ph.kabootek.dapsmobile",
      dapsUrl: "https://accounts.daps.ph/web/index.php",
    },
  );
  setupApp();
}
