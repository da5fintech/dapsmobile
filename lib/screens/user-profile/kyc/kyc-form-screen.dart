import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';

class KycFormScreen extends StatefulWidget {
  @override
  _KycFormScreenState createState() =>
      _KycFormScreenState();

}

class _KycFormScreenState extends State<KycFormScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(20),
      child: ListView(
        children: [
          Text(
            'Basic Info',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              height: 2
            )
          ),
          TextFormField(
            autofocus: true,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {},
            onSaved: (v) {},
            decoration: InputDecoration(
              errorStyle: TextStyle(
                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
              labelText: "DA Customer No.",
              floatingLabelBehavior:
              FloatingLabelBehavior.always,
            ),
          ),
          Text(
            'Enter 8-digit Customer Account Number',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: COLOR_DARK_GRAY,
              height: 2,
            )
          ),
          TextFormField(
            autofocus: true,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {},
            onSaved: (v) {},
            decoration: InputDecoration(
              errorStyle: TextStyle(
                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
              labelText: "Search Engine",
              floatingLabelBehavior:
              FloatingLabelBehavior.always,
            ),
          ),
          TextFormField(
            autofocus: true,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {},
            onSaved: (v) {},
            decoration: InputDecoration(
              errorStyle: TextStyle(
                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
              labelText: "Name",
              floatingLabelBehavior:
              FloatingLabelBehavior.always,
            ),
          ),
          TextFormField(
            autofocus: true,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {},
            onSaved: (v) {},
            decoration: InputDecoration(
              errorStyle: TextStyle(
                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
              labelText: "DOB",
              floatingLabelBehavior:
              FloatingLabelBehavior.always,
            ),
          ),
          TextFormField(
            autofocus: true,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {},
            onSaved: (v) {},
            decoration: InputDecoration(
              errorStyle: TextStyle(
                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
              labelText: "Address 1",
              floatingLabelBehavior:
              FloatingLabelBehavior.always,
            ),
          ),
          TextFormField(
            autofocus: true,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {},
            onSaved: (v) {},
            decoration: InputDecoration(
              errorStyle: TextStyle(
                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
              labelText: "Address 2",
              floatingLabelBehavior:
              FloatingLabelBehavior.always,
            ),
          ),
          TextFormField(
            autofocus: true,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {},
            onSaved: (v) {},
            decoration: InputDecoration(
              errorStyle: TextStyle(
                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
              labelText: "Contact No.",
              floatingLabelBehavior:
              FloatingLabelBehavior.always,
            ),
          ),
        ],
      ),
    );
  }

}
