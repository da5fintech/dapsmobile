import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';
import 'package:daps/screens/onboarding/first-screen.dart';
import 'package:daps/screens/onboarding/fourth-screen.dart';
import 'package:daps/screens/onboarding/second-screen.dart';
import 'package:daps/screens/onboarding/third-screen.dart';
import 'package:daps/screens/splash-screen.dart';
import 'package:daps/store/application-store.dart';
import 'package:daps/main.dart';

final store = getIt<ApplicationStore>();

class OnboardingMainScreen extends StatefulWidget {
  bool navInSetting;

  OnboardingMainScreen({this.navInSetting = false});

  @override
  _OnboardingMainScreenState createState() => _OnboardingMainScreenState();
}

class _OnboardingMainScreenState extends State<OnboardingMainScreen> {
  CarouselController carouselController = CarouselController();
  int _current = 0;
  List<Widget> _items = new List<Widget>();

  @override
  void initState() {
    super.initState();
    _items = [
      FirstScreen(),
      SecondScreen(),
      ThirdScreen(),
      FourthScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    return Theme(
      data: td,
      child: Scaffold(
        appBar: widget.navInSetting ? SubAppbarWidget(
          title: "Onboarding",
          actions: [
            Observer(
              builder: (_) => Switch(
                activeColor: Colors.white,
                value: store.freshInstall,
                onChanged: (v) {
                  store.setIfFreshInstall(v);
                },
              ),
            ),
          ],
        ) : null,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: !widget.navInSetting ? FlatButton(
                  onPressed: () {
                    store.setIfFreshInstall(false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SplashScreen()),
                    );
                  },
                  child: Text('Skip', style: TextStyle(color: COLOR_DAPS)),
                ) : null,
              ),  
              Expanded(
                flex: 1,
                child: CarouselSlider(
                  items: _items,
                  carouselController: carouselController,
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    autoPlay: false,
                    height: SizeConfig.screenHeight,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _items.map((url) {
                    int index = _items.indexOf(url);
                    return InkWell(
                      onTap: () {
                        carouselController.animateToPage(index);
                      },
                      child: Container(
                        width: 40.0,
                        height: 8.0,
                        margin:
                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          shape: BoxShape.rectangle,
                          color: _current == index
                              ? COLOR_DAPS
                              : COLOR_DAPS.withOpacity(.5),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: COLOR_DAPS,
          onPressed: () {
            if(_current < 3 ) {
              carouselController.nextPage();
            } else {
              if(widget.navInSetting) {
                Navigator.pop(context);
              } else {
                store.setIfFreshInstall(false);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SplashScreen()),
                );
              }

            }
          },
          child: Icon(_current < 3  ? Icons.arrow_forward_ios : Icons.check, color: Colors.white),
        ),
      ),
    );
  }
}
