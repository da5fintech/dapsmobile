import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';

class VoucherPocketsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    return DefaultTabController(
      length: 3,
      child: Theme(
        data: td,
        child: Scaffold(
          appBar: SubAppbarWidget(
            height: 90.0,
            title: VOUCHER_POCKETS_SCREEN_TITLE,
            bottom: TabBar(
              indicatorColor: COLOR_ORANGE,
              tabs: [
                Tab(icon: Text(VOUCHER_POCKETS_TAB_1_TITLE)),
                Tab(icon: Text(VOUCHER_POCKETS_TAB_2_TITLE)),
                Tab(icon: Text(VOUCHER_POCKETS_TAB_3_TITLE)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 30),
                    child: SvgPicture.asset(
                      'assets/svg/voucher-pockets/voucher-pockets.svg',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      VOUCHER_POCKETS_NOTE_TEXT,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        height: 1.5,
                        color: COLOR_DARK_GRAY,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      VOUCHER_POCKETS_INFORMATION_TEXT,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        height: 1.5,
                        color: COLOR_DARK_PURPLE.withOpacity(0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Container(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
