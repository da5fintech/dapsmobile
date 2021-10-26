import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daps/common/constants.dart';

class KycEcddLpmtScreen extends StatefulWidget {
  @override
  _KycEcddLpmtScreenState createState () =>
      _KycEcddLpmtScreenState();
}

class _KycEcddLpmtScreenState extends State<KycEcddLpmtScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: ListView(
          children: [
            Text(
              'ECDD',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Front',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 3),
                    Text(
                      '(Required)',
                      style: GoogleFonts.roboto(
                        color: COLOR_DARK_GRAY,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    'assets/icons/image-placeholder.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: ButtonTheme(
                            minWidth: 160,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: COLOR_DARK_PURPLE,
                              ),
                            ),
                            child: RaisedButton.icon(
                              color: Colors.white,
                              onPressed: () async {
                              },
                              icon: Icon(Icons.camera_alt, color: COLOR_DARK_PURPLE),
                              label: Text(
                                  'TAKE A PHOTO',
                                  style: GoogleFonts.roboto(
                                    color: COLOR_DARK_PURPLE,
                                  )
                              ),
                            )
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                          flex: 1,
                          child: ButtonTheme(
                            minWidth: 160,
                            child: RaisedButton(
                                onPressed: () async {
                                },
                                color: COLOR_DARK_PURPLE,
                                child: Text(
                                    'CHOOSE FILE',
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                    )
                                )
                            ),
                          )
                      ),
                    ],
                  ),
                )
              ],
            ),
            Text(
              'LPMT',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Back',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 3),
                    Text(
                      '(Required)',
                      style: GoogleFonts.roboto(
                        color: COLOR_DARK_GRAY,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    'assets/icons/image-placeholder.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: ButtonTheme(
                            minWidth: 160,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: COLOR_DARK_PURPLE,
                              ),
                            ),
                            child: RaisedButton.icon(
                              color: Colors.white,
                              onPressed: () async {
                              },
                              icon: Icon(Icons.camera_alt, color: COLOR_DARK_PURPLE),
                              label: Text(
                                  'TAKE A PHOTO',
                                  style: GoogleFonts.roboto(
                                    color: COLOR_DARK_PURPLE,
                                  )
                              ),
                            )
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                          flex: 1,
                          child: ButtonTheme(
                            minWidth: 160,
                            child: RaisedButton(
                                onPressed: () async {
                                },
                                color: COLOR_DARK_PURPLE,
                                child: Text(
                                    'CHOOSE FILE',
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                    )
                                )
                            ),
                          )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        )
    );
  }
}