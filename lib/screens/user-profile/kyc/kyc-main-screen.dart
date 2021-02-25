import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/screens/user-profile/kyc/kyc-acr-screen.dart';
import 'package:swipe/screens/user-profile/kyc/kyc-form-screen.dart';
import 'package:swipe/screens/user-profile/kyc/kyc-proof-id-screen.dart';
import 'package:swipe/screens/user-profile/kyc/kyc-selfie-screen.dart';

class KycMainScreen extends StatefulWidget {
  @override

  _KycMainScreenState createState () =>
      _KycMainScreenState();
}

class _KycMainScreenState extends State<KycMainScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: "KYC",
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: CarouselSlider(
                  items: [
                    KycFormScreen(),
                    KycSelfieScreen(),
                    KycProofIdScreen(),
                    KycAcrScreen(),
                    Text('5'),
                  ],
                  options: CarouselOptions(
                    autoPlay: false,
                    height: height,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      print(index);
                      FocusScope.of(context).unfocus();
                    }
                  ),
                )
              ),
              Container(
                height: height * 0.07,
                width:  width,
                color: COLOR_DARK_PURPLE,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_back_ios, size: 12, color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [1,2,3,4,5].map((url) {
                        int index = [1,2,3,4,5].indexOf(url);
                        return Container(
                          width: 6,
                          height: 6,
                          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 12)
                    ),
                  ],
                )
              )
            ],
          )
        )
      ),
    );
  }
}

