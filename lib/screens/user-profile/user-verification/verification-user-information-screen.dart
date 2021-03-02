import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/screens/user-profile/user-verification/verification-review-information-screen.dart';

class VerificationUserInformationScreen extends StatefulWidget {
  @override
  _VerificationUserInformationScreenState createState() =>
      _VerificationUserInformationScreenState();
}

class _VerificationUserInformationScreenState extends State<VerificationUserInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  FocusNode idTypeNode = new FocusNode();
  FocusNode idTypeNumberNode  = new FocusNode();
  FocusNode firstNameNode  = new FocusNode();
  FocusNode middleNameNode = new FocusNode();
  FocusNode lastNameNode = new FocusNode();
  FocusNode nationalityNode = new FocusNode();
  FocusNode placeOfBirthNode = new FocusNode();
  FocusNode dateOfBirthNode = new FocusNode();
  FocusNode contactNode = new FocusNode();
  FocusNode addressNode = new FocusNode();
  FocusNode barangayNode = new FocusNode();
  FocusNode cityNode = new FocusNode();
  FocusNode zipNode = new FocusNode();
  FocusNode provinceNode = new FocusNode();

  FocusNode countryNode = new FocusNode();
  FocusNode workNode = new FocusNode();

  @override
  void initState () {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double width = MediaQuery.of(context).size.width;
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: "User Information",
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: 5,
                        width: width * 0.15,
                        decoration: BoxDecoration(
                          color: COLOR_DARK_PURPLE,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: 5,
                        width: width * 0.15,
                        decoration: BoxDecoration(
                          color: COLOR_DARK_PURPLE,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: 5,
                        width: width * 0.15,
                        decoration: BoxDecoration(
                          color: COLOR_DARK_PURPLE,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Tell us more about yourself',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: COLOR_DARK_PURPLE,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'ID Information',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      focusNode: idTypeNode,
                      onTap: () => _requestFocus(idTypeNode),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (text) {
                        idTypeNode.unfocus();
                        FocusScope.of(context).requestFocus(idTypeNumberNode);
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: "ID TYPE",
                        labelStyle: TextStyle(color: idTypeNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        focusColor: COLOR_DARK_PURPLE,
                        errorStyle: TextStyle(
                            color: COLOR_GRAY, fontSize: 12, height: 0.3),
                      ),
                    ),
                    TextFormField(
                      autofocus: true,
                      focusNode: idTypeNumberNode,
                      onTap: () => _requestFocus(idTypeNumberNode),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (text) {
                        idTypeNumberNode.unfocus();
                        FocusScope.of(context).requestFocus(firstNameNode);
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: "ID TYPE",
                        labelStyle: TextStyle(color: idTypeNumberNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        focusColor: COLOR_DARK_PURPLE,
                        errorStyle: TextStyle(
                            color: COLOR_GRAY, fontSize: 12, height: 0.3),
                      ),
                    ),
                    TextFormField(
                      autofocus: true,
                      focusNode: firstNameNode,
                      onTap: () => _requestFocus(firstNameNode),
                      onFieldSubmitted: (text) {
                        firstNameNode.unfocus();
                        FocusScope.of(context).requestFocus(middleNameNode);
                        setState(() {});
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "First Name",
                        labelStyle: TextStyle(color: firstNameNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        focusColor: COLOR_DARK_PURPLE,
                        errorStyle: TextStyle(
                            color: COLOR_GRAY, fontSize: 12, height: 0.3),
                      ),
                    ),
                    TextFormField(
                      autofocus: true,
                      focusNode: middleNameNode,
                      onTap: () => _requestFocus(middleNameNode),
                      onFieldSubmitted: (text) {
                        middleNameNode.unfocus();
                        FocusScope.of(context).requestFocus(lastNameNode);
                        setState(() {});
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Middle Name",
                        labelStyle: TextStyle(color: middleNameNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        focusColor: COLOR_DARK_PURPLE,
                        errorStyle: TextStyle(
                            color: COLOR_GRAY, fontSize: 12, height: 0.3),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          visualDensity: VisualDensity(vertical: 0, horizontal: -4),
                          value: true,
                          onChanged: (val) {},
                        ),
                        Text(
                          'I do not have a middle name',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: COLOR_DARK_GRAY,
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      autofocus: true,
                      focusNode: lastNameNode,
                      onTap: () => _requestFocus(lastNameNode),
                      onFieldSubmitted: (text) {
                        lastNameNode.unfocus();
                        FocusScope.of(context).requestFocus(nationalityNode);
                        setState(() {});
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Last Name",
                        labelStyle: TextStyle(color: lastNameNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        focusColor: COLOR_DARK_PURPLE,
                        errorStyle: TextStyle(
                            color: COLOR_GRAY, fontSize: 12, height: 0.3),
                      ),
                    ),
                    TextFormField(
                      autofocus: true,
                      focusNode: nationalityNode,
                      onTap: () => _requestFocus(nationalityNode),
                      onFieldSubmitted: (text) {
                        nationalityNode.unfocus();
                        FocusScope.of(context).requestFocus(placeOfBirthNode);
                        setState(() {});
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Nationality",
                        labelStyle: TextStyle(color: nationalityNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        focusColor: COLOR_DARK_PURPLE,
                        errorStyle: TextStyle(
                            color: COLOR_GRAY, fontSize: 12, height: 0.3),
                      ),
                    ),
                    TextFormField(
                      autofocus: true,
                      focusNode: placeOfBirthNode,
                      onTap: () => _requestFocus(placeOfBirthNode),
                      onFieldSubmitted: (text) {
                        placeOfBirthNode.unfocus();
                        FocusScope.of(context).requestFocus(contactNode);
                        setState(() {});
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Place of Birth",
                        labelStyle: TextStyle(color: placeOfBirthNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        focusColor: COLOR_DARK_PURPLE,
                        errorStyle: TextStyle(
                            color: COLOR_GRAY, fontSize: 12, height: 0.3),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            autofocus: true,
                            focusNode: contactNode,
                            onTap: () => _requestFocus(contactNode),
                            onFieldSubmitted: (text) {
                              contactNode.unfocus();
                              FocusScope.of(context).requestFocus(dateOfBirthNode);
                              setState(() {});
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: "Contact Number",
                              labelStyle: TextStyle(color: contactNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              focusColor: COLOR_DARK_PURPLE,
                              errorStyle: TextStyle(
                                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            autofocus: true,
                            focusNode: dateOfBirthNode,
                            onTap: () => _requestFocus(dateOfBirthNode),
                            onFieldSubmitted: (text) {
                              dateOfBirthNode.unfocus();
                              FocusScope.of(context).requestFocus(addressNode);
                              setState(() {});
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: "Date of Birth",
                              labelStyle: TextStyle(color: dateOfBirthNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              focusColor: COLOR_DARK_PURPLE,
                              errorStyle: TextStyle(
                                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Address',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: COLOR_DARK_GRAY,
                        )
                      ),
                    ),
                    TextFormField(
                      autofocus: true,
                      focusNode: addressNode,
                      onTap: () => _requestFocus(addressNode),
                      onFieldSubmitted: (text) {
                        addressNode.unfocus();
                        FocusScope.of(context).requestFocus(barangayNode);
                        setState(() {});
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "House No. and Street Name",
                        labelStyle: TextStyle(color: addressNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        focusColor: COLOR_DARK_PURPLE,
                        errorStyle: TextStyle(
                            color: COLOR_GRAY, fontSize: 12, height: 0.3),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            autofocus: true,
                            focusNode: barangayNode,
                            onTap: () => _requestFocus(barangayNode),
                            onFieldSubmitted: (text) {
                              barangayNode.unfocus();
                              FocusScope.of(context).requestFocus(cityNode);
                              setState(() {});
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: "Barangay",
                              labelStyle: TextStyle(color: barangayNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              focusColor: COLOR_DARK_PURPLE,
                              errorStyle: TextStyle(
                                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            autofocus: true,
                            focusNode: cityNode,
                            onTap: () => _requestFocus(cityNode),
                            onFieldSubmitted: (text) {
                              cityNode.unfocus();
                              FocusScope.of(context).requestFocus(zipNode);
                              setState(() {});
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: "City",
                              labelStyle: TextStyle(color: cityNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              focusColor: COLOR_DARK_PURPLE,
                              errorStyle: TextStyle(
                                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            autofocus: true,
                            focusNode: zipNode,
                            onTap: () => _requestFocus(zipNode),
                            onFieldSubmitted: (text) {
                              zipNode.unfocus();
                              FocusScope.of(context).requestFocus(provinceNode);
                              setState(() {});
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: "Zip Code",
                              labelStyle: TextStyle(color: zipNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              focusColor: COLOR_DARK_PURPLE,
                              errorStyle: TextStyle(
                                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            autofocus: true,
                            focusNode: provinceNode,
                            onTap: () => _requestFocus(provinceNode),
                            onFieldSubmitted: (text) {
                              provinceNode.unfocus();
                              FocusScope.of(context).requestFocus(countryNode);
                              setState(() {});
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: "Province",
                              labelStyle: TextStyle(color: provinceNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              focusColor: COLOR_DARK_PURPLE,
                              errorStyle: TextStyle(
                                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
                            ),
                          ),
                        )
                      ],
                    ),
                    TextFormField(
                      autofocus: true,
                      focusNode: countryNode,
                      onTap: () => _requestFocus(countryNode),
                      onFieldSubmitted: (text) {
                        countryNode.unfocus();
                        FocusScope.of(context).requestFocus(workNode);
                        setState(() {});
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Country",
                        labelStyle: TextStyle(color: countryNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        focusColor: COLOR_DARK_PURPLE,
                        errorStyle: TextStyle(
                            color: COLOR_GRAY, fontSize: 12, height: 0.3),
                      ),
                    ),
                    TextFormField(
                      autofocus: true,
                      focusNode: workNode,
                      onTap: () => _requestFocus(workNode),
                      onFieldSubmitted: (text) {
                        workNode.unfocus();
                        FocusScope.of(context).requestFocus();
                        setState(() {});
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Nature of Work",
                        labelStyle: TextStyle(color: workNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        focusColor: COLOR_DARK_PURPLE,
                        errorStyle: TextStyle(
                            color: COLOR_GRAY, fontSize: 12, height: 0.3),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Source of Funds',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          visualDensity: VisualDensity(vertical: -2, horizontal: -4),
                          value: true,
                          onChanged: (val) {},
                        ),
                        Text(
                          'E-Money',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: COLOR_DARK_GRAY,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          visualDensity: VisualDensity(vertical: -2, horizontal: -4),
                          value: true,
                          onChanged: (val) {},
                        ),
                        Text(
                          'Cash on Hand',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: COLOR_DARK_GRAY,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          visualDensity: VisualDensity(vertical: -2, horizontal: -4),
                          value: true,
                          onChanged: (val) {},
                        ),
                        Text(
                          'Bank Account',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: COLOR_DARK_GRAY,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25, bottom: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: ButtonTheme(
                    buttonColor: COLOR_DARK_PURPLE,
                    child: RaisedButton(
                      // shape: ,
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => VerificationReviewInfromationScreen()),
                        );
                      },
                      child: Text(
                        'NEXT',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],

          ),
        )
      ),
    );
  }

  void _requestFocus(FocusNode node) {
    FocusScope.of(context).requestFocus(node);
    setState(() {});
  }
}