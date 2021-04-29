import 'dart:io';
import 'dart:async';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe/models/auto-suggest-model.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/screens/onboarding/onboard-main-screen.dart';
import 'package:swipe/screens/splash-screen.dart';
import 'package:swipe/screens/user-profile/user-verification/verification-user-information-screen.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/router.dart' as onRouter;

import 'common/constants.dart';

const String namespaceKey = 'namespace';
const String packageIdKey = 'packageId';

GetIt getIt = GetIt.instance;

void setupApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  await Firebase.initializeApp().catchError((err) {
    print(err);
  });
  var cache = await SharedPreferences.getInstance();
  var dir = await getApplicationDocumentsDirectory();
  await Hive.init(dir.path);
  Hive.registerAdapter(AutoSweepSuggestAdapter());
  Hive.registerAdapter(AccountRecipientAdapter());
  Hive.registerAdapter(BuyLoadSuggestAdapter());
  Hive.registerAdapter(AutoSuggestAdapter());
  Hive.registerAdapter(SwipeServiceOfferingAdapter());
  Hive.registerAdapter(BillerProductAdapter());
  Hive.registerAdapter(BillerFieldAdapter());
  Hive.registerAdapter(BillerFieldTypeAdapter());
  Hive.registerAdapter(KeyValuePairAdapter());
  Hive.registerAdapter(ProductModelAdapter());
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

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  ApplicationStore store;
  Timer _timer;

  @override
  void initState() {
    store = ApplicationStore(prefs: getIt.get<SharedPreferences>());
    getIt.registerSingleton<ApplicationStore>(store);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    ///detect app if it's in the background
    switch(state) {
      case AppLifecycleState.paused:
        print('paused');
        _timer = Timer.periodic(Duration(seconds: 5), (timer) {
          _timer?.cancel();
          exit(0);
        });
        setState(() {});
        break;
      case AppLifecycleState.resumed:
        print('resumed');
        _timer?.cancel();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
    }
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
          home: store.freshInstall ? OnboardingMainScreen() : SplashScreen(),
          onGenerateRoute: onRouter.Router.generateRouting,
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }
}
