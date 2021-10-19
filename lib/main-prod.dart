import 'dart:async';

import 'package:flavor/flavor.dart';

import 'main.dart';

Future main() async {
  Flavor.create(
    Environment.production,
    properties: {
      namespaceKey: "",
      packageIdKey: "ph.kabootek.dapsmobile",
      dapsUrl: "https://accounts.daps.ph/web/index.php",
    },
  );
  setupApp();
}
