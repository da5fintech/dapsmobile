import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/places.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/util.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/main.dart';
import 'package:swipe/screens/user-profile/user-verification/verification-review-information-screen.dart';
import 'package:swipe/store/application-store.dart';

final store = getIt<ApplicationStore>();

class VerificationUserInformationScreen extends StatefulWidget {
  @override
  _VerificationUserInformationScreenState createState() =>
      _VerificationUserInformationScreenState();
}

class _VerificationUserInformationScreenState extends State<VerificationUserInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  var maskFormatter = MaskTextInputFormatter(mask: "##/##/####");
  Map<String, dynamic> values = Map<String, dynamic>();
  AppUtil _appUtil = AppUtil();
  bool hasMiddleName = false;
  String selectedSourceOfFunds = "";
  bool hasError = false;
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
  Map<String, dynamic> selectedRegion = regions[0];
  Map<String, dynamic> selectedState;
  Map<String, dynamic> selectedCity;
  Map<String, dynamic> selectedBarangay;
  String isSelectedState = "";
  String isSelectedCity = "";
  String isSelectedBarangay = "";
  List<Map<String, dynamic>> states = [];
  List<Map<String, dynamic>> cities = [];
  List<Map<String, dynamic>> barangay = [];

  @override
  void initState () {
    super.initState();
    onSelectPlace();
    // store.verification.idType = "UMID";
    // store.verification.idNumber = "29223020";
    // store.verification.firstName = "Jose Paulo";
    // store.verification.middleName = "Maniquez";
    // store.verification.lastName = "Dela Cruz";
    // store.verification.nationality = "Filipino";
    // store.verification.placeOfBirth= "Pasig City";
    // store.verification.contactNumber = "639056535707";
    // store.verification.dateOfBirth = "10/21/1995";
    // store.verification.address = "Blk 24 Lot 18 Saint Joseph 6";
    // store.verification.barangay = "Butong";
    // store.verification.city = "Cabuyao";
    // store.verification.zipCode = "4025";
    // store.verification.state = "Laguna";
    // store.verification.country = "Philippines";
    // store.verification.natureOfWork= "Developer";
    // selectedSourceOfFunds = "Salary";
    // store.verification.sourceOfIncome = "Salary";
  }

  String inputValidator(String text, String field) {
    if(text.isEmpty) {
      return "$field is required";
    }
    return null;
  }

  void onSelectPlace ({isSelectedRegion = "REGION I (ILOCOS REGION)"}) {
    var a = regions.firstWhere((region) => region['regDesc'] == isSelectedRegion);
    selectedRegion = a;
    states = provinces.where((province) => province['regCode'] == a['regCode']).toList();
    onSelectedState();
    setState(() {});
  }

  void onSelectedState ({isSelectState = ""}) {
    if(isSelectState == "") {
      print( 'region is change' );
      selectedState = states[0];
      selectedCity = citiesCollection.firstWhere((city) => city['provCode'] == selectedState['provCode']);
      cities = citiesCollection.where((city) => city['provCode'] == selectedState['provCode']).toList();
      setState(() {});
    } else {
      var a = provinces.firstWhere((province) => province['provDesc'] == isSelectState);
      selectedState = a;
      selectedCity = citiesCollection.firstWhere((city) => city['provCode'] == selectedState['provCode']);
      cities = citiesCollection.where((city) => city['provCode'] == selectedState['provCode']).toList();
      setState(() {});
    }
  }

  void onSelectCity ({isSelectCity = ""}) {
    var a = cities.firstWhere((city) => city['citymunDesc'] == isSelectCity);
    selectedCity = a;
    setState(() {});
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
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          validator: (text) => inputValidator(text, "ID Type"),
                          onSaved: (v) {
                            values['idType'] = v;
                          },
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
                            hintText: "Drivers License"
                          ),
                        ),
                        TextFormField(
                          autofocus: true,
                          focusNode: idTypeNumberNode,
                          keyboardType: TextInputType.visiblePassword,
                          onTap: () => _requestFocus(idTypeNumberNode),
                          textInputAction: TextInputAction.next,
                          validator: (text) => inputValidator(text, "ID NUMBER"),
                          onSaved: (v) {
                            values['idNumber'] = v;
                          },
                          onFieldSubmitted: (text) {
                            idTypeNumberNode.unfocus();
                            FocusScope.of(context).requestFocus(firstNameNode);
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            labelText: "ID NUMBER",
                            labelStyle: TextStyle(color: idTypeNumberNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            focusColor: COLOR_DARK_PURPLE,
                          ),
                        ),
                        TextFormField(
                          autofocus: true,
                          focusNode: firstNameNode,
                          onTap: () => _requestFocus(firstNameNode),
                          validator: (text) => inputValidator(text, "FIRST NAME"),
                          textCapitalization: TextCapitalization.words,
                          onSaved: (v) {
                            values['firstName'] = v;
                          },
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
                          ),
                        ),
                        if(!hasMiddleName) ...[
                          TextFormField(
                            autofocus: true,
                            focusNode: middleNameNode,
                            onTap: () => _requestFocus(middleNameNode),
                            textCapitalization: TextCapitalization.words,
                            validator: (text) => inputValidator(text, "MIDDLE NAME"),
                            onSaved: (v) {
                              values['middleName'] = v;
                            },
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
                            ),
                          ),
                        ],
                        Row(
                          children: [
                            Checkbox(
                              visualDensity: VisualDensity(vertical: 0, horizontal: -4),
                              value: hasMiddleName,
                              onChanged: (val) {
                                hasMiddleName = val;
                                setState(() {});
                              },
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
                          validator: (text) => inputValidator(text, "LAST NAME"),
                          textCapitalization: TextCapitalization.words,
                          onSaved: (v) {
                            values['lastName'] = v;
                          },
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
                          ),
                        ),
                        TextFormField(
                          autofocus: true,
                          focusNode: nationalityNode,
                          onTap: () => _requestFocus(nationalityNode),
                          textCapitalization: TextCapitalization.words,
                          validator: (text) => inputValidator(text, "NATIONALITY"),
                          onSaved: (v) {
                            values['nationality'] = v;
                          },
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
                          ),
                        ),
                        TextFormField(
                          autofocus: true,
                          focusNode: placeOfBirthNode,
                          textCapitalization: TextCapitalization.words,
                          onTap: () => _requestFocus(placeOfBirthNode),
                          validator: (text) => inputValidator(text, "PLACE OF BIRTH"),
                          onSaved: (v) {
                            values['placeOfBirth'] = v;
                          },
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
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                autofocus: true,
                                focusNode: contactNode,
                                keyboardType: TextInputType.number,
                                onTap: () => _requestFocus(contactNode),
                                validator: (text) => inputValidator(text, "CONTACT NUMBER"),
                                onSaved: (v) {
                                  values['contactNumber'] = v;
                                },
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
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                autofocus: true,
                                focusNode: dateOfBirthNode,
                                keyboardType: TextInputType.number,
                                onTap: () => _requestFocus(dateOfBirthNode),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Birth Date is Required';
                                  }
                                  final components = value.split("/");
                                  if (components.length == 3) {
                                    int month = int.parse(components[0]);
                                    int day = int.parse(components[1]);
                                    int year = int.parse(components[2]);
                                    int dayInMonth =
                                    _appUtil.daysInMonth(month, year);
                                    if (day != null &&
                                        month != null &&
                                        year != null) {
                                      if (day > dayInMonth) {
                                        return 'Invalid Date Input';
                                      }
                                      return null;
                                    }
                                  }
                                  return "Wrong Format";
                                },
                                onSaved: (v) {
                                  values['dateOfBirth'] = v;
                                },
                                onFieldSubmitted: (text) {
                                  dateOfBirthNode.unfocus();
                                  FocusScope.of(context).requestFocus(addressNode);
                                  setState(() {});
                                },
                                inputFormatters: [maskFormatter],
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: "Date of Birth",
                                  labelStyle: TextStyle(color: dateOfBirthNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  focusColor: COLOR_DARK_PURPLE,
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
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            'Region',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: COLOR_DARK_GRAY,
                            )
                        ),
                      ),
                      Container(
                        width: width,
                        child: DropdownButton<String>(
                          value: selectedRegion['regDesc'],
                          isExpanded: true,
                          items: regions.map((value) {
                            return new DropdownMenuItem<String>(
                              value: value['regDesc'],
                              child: new Text(value['regDesc'], style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w500)),
                            );
                          }).toList(),
                          onChanged: (val) {
                            onSelectPlace(
                              isSelectedRegion: val,
                            );
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                      'State',
                                      style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: COLOR_DARK_GRAY,
                                      )
                                  ),
                                ),
                                Container(
                                  width: width,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: selectedState['provDesc'],
                                    items: states?.map((value) {
                                      return new DropdownMenuItem<String>(
                                        value: value['provDesc'],
                                        child: new Text(value['provDesc'], style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w500)),
                                      );
                                    })?.toList() ?? [],
                                    onChanged: (val) {
                                      onSelectedState(
                                        isSelectState: val,
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            flex: 1,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                      'City',
                                      style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: COLOR_DARK_GRAY,
                                      )
                                  ),
                                ),
                                Container(
                                  width: width,
                                  child: DropdownButton<String>(
                                    value: selectedCity['citymunDesc'],
                                    isExpanded: true,
                                    items: cities.map((value) {
                                      return new DropdownMenuItem<String>(
                                        value: value['citymunDesc'],
                                        child: new Text(value['citymunDesc'], style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w500)),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      onSelectCity(isSelectCity: val);
                                    },
                                  ),
                                )
                              ],
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
                              focusNode: barangayNode,
                              textCapitalization: TextCapitalization.words,
                              onTap: () => _requestFocus(barangayNode),
                              validator: (text) => inputValidator(text, "BARANGAY"),
                              onSaved: (v) {
                                values['barangay'] = v;
                              },
                              onFieldSubmitted: (text) {
                                barangayNode.unfocus();
                                FocusScope.of(context).requestFocus(zipNode);
                                setState(() {});
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Barangay",
                                labelStyle: TextStyle(color: barangayNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                focusColor: COLOR_DARK_PURPLE,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              autofocus: true,
                              focusNode: zipNode,
                              keyboardType: TextInputType.number,
                              onTap: () => _requestFocus(zipNode),
                              validator: (text) => inputValidator(text, "ZIP CODE"),
                              onSaved: (v) {
                                values['zipCode'] = v;
                              },
                              onFieldSubmitted: (text) {
                                zipNode.unfocus();
                                FocusScope.of(context).requestFocus(addressNode);
                                setState(() {});
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Zip Code",
                                labelStyle: TextStyle(color: zipNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                focusColor: COLOR_DARK_PURPLE,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        autofocus: true,
                        focusNode: addressNode,
                        textCapitalization: TextCapitalization.words,
                        onTap: () => _requestFocus(addressNode),
                        validator: (text) => inputValidator(text, "House No. and Street Name"),
                        onSaved: (v) {
                          values['address'] = v;
                        },
                        onFieldSubmitted: (text) {
                          addressNode.unfocus();
                          FocusScope.of(context).requestFocus(countryNode);
                          setState(() {});
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: "House No. and Street Name",
                          labelStyle: TextStyle(color: addressNode.hasFocus ? COLOR_DARK_PURPLE : COLOR_DARK_GRAY),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          focusColor: COLOR_DARK_PURPLE,
                        ),
                      ),
                      TextFormField(
                        autofocus: true,
                        focusNode: countryNode,
                        textCapitalization: TextCapitalization.words,
                        onTap: () => _requestFocus(countryNode),
                        validator: (text) => inputValidator(text, "COUNTRY"),
                        onSaved: (v) {
                          values['country'] = v;
                        },
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
                        ),
                      ),
                      TextFormField(
                        autofocus: true,
                        focusNode: workNode,
                        onTap: () => _requestFocus(workNode),
                        textCapitalization: TextCapitalization.words,
                        validator: (text) => inputValidator(text, "NATURE OF WORK"),
                        onSaved: (v) {
                          values['natureOfWork'] = v;
                        },
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
                      if(hasError) ...[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              'Source of Income is Required',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                height: 2,
                                color: COLOR_DANGER,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              )
                          ),
                        ),
                      ],
                      Row(
                        children: [
                          Checkbox(
                            visualDensity: VisualDensity(vertical: -2, horizontal: -4),
                            value: selectedSourceOfFunds == "Salary" ? true: false,
                            onChanged: (val) {
                              if(val) {
                                selectedSourceOfFunds = "Salary";
                              } else {
                                selectedSourceOfFunds = "";
                              }
                              setState(() {});
                            },
                          ),
                          Text(
                            'Salary',
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
                            value: selectedSourceOfFunds == "Remittance" ? true: false,
                            onChanged: (val) {
                              if(val) {
                                selectedSourceOfFunds = "Remittance";
                              } else {
                                selectedSourceOfFunds = "";
                              }
                              setState(() {});
                            },
                          ),
                          Text(
                            'Remittance',
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
                            value: selectedSourceOfFunds == "Business" ? true: false,
                            onChanged: (val) {
                              if(val) {
                                selectedSourceOfFunds = "Business";
                              } else {
                                selectedSourceOfFunds = "";
                              }
                              setState(() {});
                            },
                          ),
                          Text(
                            'Business',
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
                            value: selectedSourceOfFunds == "Allowance" ? true: false,
                            onChanged: (val) {
                              if(val) {
                                selectedSourceOfFunds = "Allowance";
                              } else {
                                selectedSourceOfFunds = "";
                              }
                              setState(() {});
                            },
                          ),
                          Text(
                            'Allowance',
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
                            value: selectedSourceOfFunds == "Government Benefits / Pension" ? true: false,
                            onChanged: (val) {
                              if(val) {
                                selectedSourceOfFunds = "Government Benefits / Pension";
                              } else {
                                selectedSourceOfFunds = "";
                              }
                              setState(() {});
                            },
                          ),
                          Text(
                            'Government Benefits / Pension',
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
                        onPressed: _handleNext,
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

  void _handleNext () async {
    bool status = _formKey.currentState.validate();
    if(status) {
      _formKey.currentState.save();
      store.verification.idType = values['idType'];
      store.verification.idNumber = values['idNumber'];
      store.verification.firstName = values['firstName'];
      store.verification.middleName = values['middleName'];
      store.verification.lastName = values['lastName'];
      store.verification.nationality = values['nationality'];
      store.verification.placeOfBirth = values['placeOfBirth'];
      store.verification.contactNumber = values['contactNumber'];
      store.verification.dateOfBirth = values['dateOfBirth'];
      store.verification.address = values['address'];
      store.verification.barangay = values['barangay'];
      store.verification.city = selectedCity['citymunDesc'];
      store.verification.zipCode = values['zipCode'];
      store.verification.state = selectedState['provDesc'];
      store.verification.country = values['country'];
      store.verification.natureOfWork = values['natureOfWork'];
      store.verification.sourceOfIncome = selectedSourceOfFunds;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => VerificationReviewInfromationScreen()),
      );
    }
  }
}