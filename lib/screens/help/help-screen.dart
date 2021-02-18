import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class HelpScreen extends StatelessWidget {
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
                  flex: 2,
                  child: Stack(
                    children: [
                      Container(
                        width: width,
                        height: height * 0.25,
                        color: COLOR_DARK_PURPLE,
                        padding: EdgeInsets.only(top: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ListTile(
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
                                  HELP_SCREEN_TITLE_TEXT,
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'How can we help you?',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                height: 2,
                              ),
                            ),
                            Text(
                              'Chat is currently unavailable but you can send us a ticket.',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 2,
                                color: Colors.white.withOpacity(0.74),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Positioned(
                        top: height * 0.20,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          width: width,
                          height: height * 0.20,
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Flexible(
                                      flex: 1,
                                      child: SvgPicture.asset('assets/svg/help/help.svg'),
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                       Text(
                                         'Submit a ticket',
                                         style: GoogleFonts.roboto(
                                           fontWeight: FontWeight.w500,
                                           fontSize: 14,
                                           height: 2,
                                           color: COLOR_DARK_PURPLE,
                                         )
                                       ),
                                        Text(
                                            'Leave a concern by messaging us and we’ll respond as soon as we can',
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                              height: 1.5,
                                              fontSize: 12,
                                              color: COLOR_DARK_GRAY,
                                            )
                                        ),
                                      ],
                                    )
                                  ),
                                  Icon(Icons.arrow_forward_ios, size: 14, color: COLOR_DARK_GRAY),
                                ],
                              ),
                            )
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: ListTile(
                                  visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                                  title: Text(
                                    'How do I change my MPIN?',
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.black
                                    ),
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios, size: 12),
                                ),
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.5),
                                thickness: 0.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: ListTile(
                                  visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                                  title: Text(
                                    'How will I recover my account?',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.black
                                    ),
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios, size: 12),
                                ),
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.5),
                                thickness: 0.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: ListTile(
                                  visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                                  title: Text(
                                    'What should I do if I forgot my MPIN?',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.black
                                    ),
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios, size: 12),
                                ),
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.5),
                                thickness: 0.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: ListTile(
                                  visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                                  title: Text(
                                    'I cash in, but entered the wrong number. What do I do?',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.black
                                    ),
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios, size: 12),
                                ),
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.5),
                                thickness: 0.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: ListTile(
                                  visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                                  title: Text(
                                    'How to setup my biometric security',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.black
                                    ),
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios, size: 12),
                                ),
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.5),
                                thickness: 0.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  'View More Articles',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: COLOR_DARK_PURPLE,
                                  )
                                ),
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.5),
                                thickness: 0.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: ListTile(
                                  leading: Icon(Icons.local_library, color: COLOR_DARK_PURPLE),
                                  visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                                  title: Text(
                                    'What can I do with SWIPE?',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.black
                                    ),
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios, size: 12),
                                ),
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.5),
                                thickness: 0.5,
                              ),

                            ]
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Terms & Condition',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: COLOR_DARK_PURPLE
                                ),
                              ),
                              Text(
                                'Privacy Policy',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: COLOR_DARK_PURPLE
                                ),
                              ),
                            ],
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