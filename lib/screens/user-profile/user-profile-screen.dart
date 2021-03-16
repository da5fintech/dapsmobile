import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/models/user-model.dart';
import 'package:swipe/screens/otp/otp-screen.dart';
import 'package:swipe/screens/user-profile/user-verification/verification-main-screen.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/main.dart';

final store = getIt<ApplicationStore>();

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  @override
  void initState() {
    firstname.text = store.user.firstName;
    lastname.text = store.user.lastName;
    mobileNumber.text = store.user.mobileNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    OverlayScreen().saveScreens({
      'progress': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(COLOR_ORANGE),
            ),
            SizedBox(height: 10.0),
            Text("Processing...",
                style: GoogleFonts.roboto(color: Colors.white)),
          ],
        ),
      ),
    });

    return Theme(
      data: td,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: height,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        width: width,
                        height: height * 0.25,
                        color: COLOR_DARK_PURPLE,
                        padding: EdgeInsets.only(top: 20, right: 20),
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios,
                                color: Colors.white, size: 24),
                          ),
                          title: Transform(
                            transform: Matrix4.translationValues(-20, 0.0, 0),
                            child: Text(
                              USER_PROFILE_SCREEN_TITLE_TEXT,
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          trailing: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => OtpScreen(
                                    mobileNumber: mobileNumber.text,
                                    type: OtpServiceAction.UPDATE_USER,
                                    btnText: "UPDATE USER",
                                    onOk: _handleUpdateUser,
                                  ),
                                )
                              );
                            },
                            padding: EdgeInsets.zero,
                            child: Text(
                              'Update',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: height * 0.18,
                        left: width * 0.37,
                        child: CircleAvatar(
                          maxRadius: 50,
                          backgroundColor: COLOR_ORANGE,
                          child: Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 22,
                  child: Chip(
                    padding: EdgeInsets.only(bottom: 10),
                    backgroundColor:
                        store.user.level >= 3 ? COLOR_GREEN : COLOR_DANGER,
                    label: GestureDetector(
                      // onTap: () async {
                      //   if(store.user.level <= 3) {
                      //     final cameras = await availableCameras();
                      //     final firstCamera = cameras.first;
                      //     Navigator.push(context, MaterialPageRoute(
                      //       builder: (_) => VerificationMainScreen(
                      //         cameras: firstCamera,
                      //       )
                      //     ));
                      //   }
                      // },
                      child: Text(
                        store.user.level >= 3
                            ? SERVICES_SCREEN_VERIFIED_TEXT
                            : "UNVERIFIED",
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          controller: firstname,
                          decoration: InputDecoration(
                            labelText: REGISTER_SCREEN_FIRSTNAME_TEXT,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            errorStyle: TextStyle(
                                color: COLOR_GRAY, fontSize: 12, height: 0.3),
                          ),
                        ),
                        TextFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          controller: lastname,
                          decoration: InputDecoration(
                            labelText: REGISTER_SCREEN_LASTNAME_TEXT,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            errorStyle: TextStyle(
                                color: COLOR_GRAY, fontSize: 12, height: 0.3),
                          ),
                        ),
                        TextFormField(
                          autofocus: true,
                          readOnly: true,
                          showCursor: true,
                          // initialValue: store.user.addres,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: REGISTER_SCREEN_ADDRESS_TEXT,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            errorStyle: TextStyle(
                                color: COLOR_GRAY, fontSize: 12, height: 0.3),
                          ),
                        ),
                        TextFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          readOnly: true,
                          showCursor: true,
                          initialValue: store.user.dateOfBirth,
                          decoration: InputDecoration(
                            labelText: REGISTER_SCREEN_BIRTHDAY_TEXT,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            errorStyle: TextStyle(
                                color: COLOR_GRAY, fontSize: 12, height: 0.3),
                          ),
                        ),
                        TextFormField(
                          autofocus: true,
                          readOnly: true,
                          showCursor: true,
                          initialValue: store.user.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: REGISTER_SCREEN_EMAIL_TEXT,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            errorStyle: TextStyle(
                                color: COLOR_GRAY, fontSize: 12, height: 0.3),
                          ),
                        ),
                        TextFormField(
                          autofocus: true,
                          controller: mobileNumber,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                                color: COLOR_GRAY, fontSize: 12, height: 0.3),
                            labelText: REGISTER_SCREEN_MOBIILE_TEXT,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            prefix: Container(
                              padding: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: Text(
                                '+63',
                                style: GoogleFonts.roboto(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 30,
                          ),
                          child: Text(
                            USER_PROFILE_SCREEN_NOTE_TEXT,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              height: 1.5,
                              fontWeight: FontWeight.w400,
                              color: COLOR_DARK_GRAY,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleUpdateUser () async {
    try {
      OverlayScreen().show(
        context,
        identifier: 'progress',
      );
      UserModel updatedUser = await store.accountService.updateUser(
          firstname.text,
          lastname.text,
          mobileNumber.text,
          store.user,
      );
      store.setUser(updatedUser);
      OverlayScreen().pop();
      Navigator.pop(context);
      Navigator.pop(context);
    } catch(err) {

    }

  }
}
