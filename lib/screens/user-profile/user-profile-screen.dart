import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/main.dart';

final store = getIt<ApplicationStore>();

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                    backgroundColor: COLOR_GREEN,
                    label: Text(
                      SERVICES_SCREEN_VERIFIED_TEXT,
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: Colors.white,
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
                          readOnly: true,
                          showCursor: true,
                          textInputAction: TextInputAction.next,
                          initialValue: store.user.firstName,
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
                          readOnly: true,
                          showCursor: true,
                          initialValue: store.user.lastName,
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
                          initialValue: store.user.birthdate,
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
                          initialValue: store.user.email,
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
                          readOnly: true,
                          showCursor: true,
                          initialValue: store.user.mobileNumber,
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
}
