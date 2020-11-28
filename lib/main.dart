import 'dart:async';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe/screens/login-screen.dart';
import 'package:swipe/screens/registration-screen.dart';
import 'package:swipe/screens/splash-screen.dart';
import 'package:swipe/store/application-store.dart';

import 'common/constants.dart' as Constants;
import 'common/constants.dart';

const String namespaceKey = 'namespace';
const String packageIdKey = 'packageId';

GetIt getIt = GetIt.instance;

void setupApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  var cache = await SharedPreferences.getInstance();
  getIt.registerSingleton(cache);

  runZoned(() {
    runApp(MyApp());
  }, onError: (error, stack) {
    print(error);
    print(stack);
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    ApplicationStore store =
        ApplicationStore(prefs: getIt.get<SharedPreferences>());
    getIt.registerSingleton<ApplicationStore>(store);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: FeatureDiscovery(
        child: MaterialApp(
          navigatorKey: Get.key,
          debugShowCheckedModeBanner: false,
          title: 'Curiociti',
          theme: createTheme(context),
          // darkTheme: ThemeData.dark(),
          // builder: (context, widget) => Navigator(
          //   onGenerateRoute: (settings) => MaterialPageRoute(
          //     builder: (context) => UpdateApp(child: widget),
          //   ),
          // ),
          home: SplashScreen(),
          onGenerateRoute: (settings) {
            // final Map<String, Object> arguments = settings.arguments;
            switch (settings.name) {
              case '/login':
                return MaterialPageRoute(builder: (_) => LoginScreen());
              case '/registration':
                return MaterialPageRoute(builder: (_) => RegistrationScreen());
              default:
                return null;
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
