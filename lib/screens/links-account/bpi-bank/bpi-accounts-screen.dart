import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/screens/links-account/bpi-bank/widgets/credit-card-widget.dart';
import 'package:swipe/main.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/models/bpi-account-model.dart';

final store = getIt<ApplicationStore>();

class BpiAccountsScreen extends StatefulWidget {
  const BpiAccountsScreen({Key key}) : super(key: key);

  @override
  _BpiAccountsScreenState createState() => _BpiAccountsScreenState();
}

class _BpiAccountsScreenState extends State<BpiAccountsScreen> {
  BpiAccountModel bpiModel;

  @override
  void initState () {
    if(store.bpiAccountModel == null) {
      bpiModel = null;
    } else {
      bpiModel = store.bpiAccountModel[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData td = createThemePurpleOnWhite(context);
    double appHeaderContainerSize = SizeConfig.screenHeight * .45;
    return Theme(
      data: td,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: appHeaderContainerSize,
                width: SizeConfig.screenWidth,
                child: Stack(
                  children: [
                    Container(
                      height: appHeaderContainerSize * .60,
                      decoration: BoxDecoration(
                        color: COLOR_DARK_PURPLE,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50)),
                      ),
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 70),
                          child: ListTile(
                            visualDensity: VisualDensity(horizontal: -4),
                            leading: FaIcon(
                              FontAwesomeIcons.alignJustify,
                              color: Colors.white,
                            ),
                            title: Text(
                              'banking',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: SizeConfig.blockSizeVertical * 3,
                              ),
                            ),
                          )),
                    ),
                    CreditCardWidget(),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status',
                      style: GoogleFonts.roboto(
                        fontSize: SizeConfig.blockSizeVertical * 2,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      color: Colors.grey[100],
                      elevation: 5,
                      child: ListTile(
                        visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                        leading: bpiModel == null ? Icon(Icons.warning_rounded, color: Colors.orange) : Icon(Icons.check, color: COLOR_GREEN),
                        title: Text(
                          'Your Swipe Account is not linked to BPI.',
                          style: GoogleFonts.roboto(
                            fontSize: SizeConfig.blockSizeVertical * 1.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          bpiModel == null ? 'unlinked' : 'linked',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.blockSizeVertical * 1.4
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            handleNext();
                          },
                          icon: Icon(Icons.arrow_forward_ios, size: 12),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void handleNext() async {
    var a = await store.bpiService.getAccounts();
    store.bpiAccountModel = a.collections.map((collection) {
      return BpiAccountModel.fromMap(collection);
    }).toList();
    
  }

}
