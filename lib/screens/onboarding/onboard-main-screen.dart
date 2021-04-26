import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/screens/onboarding/first-screen.dart';
import 'package:swipe/screens/onboarding/fourth-screen.dart';
import 'package:swipe/screens/onboarding/second-screen.dart';
import 'package:swipe/screens/onboarding/third-screen.dart';
import 'package:swipe/screens/splash-screen.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/main.dart';

final store = getIt<ApplicationStore>();

class OnboardingMainScreen extends StatefulWidget {
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
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: FlatButton(
                  onPressed: () {
                    store.setIfFreshInstall();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SplashScreen()),
                    );
                  },
                  child: Text('Skip'),
                ),
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
                              ? COLOR_DARK_PURPLE
                              : COLOR_DARK_PURPLE.withOpacity(.5),
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
          backgroundColor: COLOR_DARK_PURPLE,
          onPressed: () {
            if(_current < 3 ) {
              carouselController.nextPage();
            } else {
              store.setIfFreshInstall();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SplashScreen()),
              );
            }
          },
          child: Icon(_current < 3  ? Icons.arrow_forward_ios : Icons.check, color: Colors.white),
        ),
      ),
    );
  }
}
