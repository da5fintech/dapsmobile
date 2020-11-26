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
      packageIdKey: "ph.packetworx.packetthings.dev",
    },
  );
  setupApp();
}
