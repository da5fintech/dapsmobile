import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swipe/common/constants.dart' as Constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/access-permission-dialog.dart';

import '../main.dart';

final store = getIt<ApplicationStore>();

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  Map<Permission, PermissionStatus> _permissionsMap = Map.from({
    Permission.contacts: PermissionStatus.undetermined,
    Permission.storage: PermissionStatus.undetermined,
    Permission.location: PermissionStatus.undetermined,
    Permission.camera: PermissionStatus.undetermined,
  });
  @override
  void initState() {
    super.initState();
    // _initialize();
    SchedulerBinding.instance.addPostFrameCallback((_) => _initialize(context));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      // backgroundColor: Constants.backgroundColor2,
      body: Container(
        decoration: BoxDecoration(
          color: Constants.COLOR_DARK_PURPLE,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('SWIPE',
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 15)),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _initialize(BuildContext context) async {
    bool response = await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return RequestAccessPermissionDialog();
        });

    if (response == true) {
      var results = await _permissionsMap.keys.toList().request();
      results.removeWhere((key, value) => !_permissionsMap.keys.contains(key));
      _permissionsMap = results;
      store.setPermissionsGranted();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
