import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/size.config.dart';
import 'package:mobx/mobx.dart';

class SubAppbarWidget extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final String title;
  final Widget bottom;
  final double height;
  final List<Widget> actions;
  final double elevation;
  final bool enableSearch;
  final Function onSearch;

  SubAppbarWidget(
      {Key key,
      @required this.title,
      this.bottom,
      this.height,
      this.actions,
      this.elevation,
      this.enableSearch = false,
      this.onSearch})
      : preferredSize = Size.fromHeight(height ?? 56.0),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SubAppbarWidgetState();
  }
}

class _SubAppbarWidgetState extends State<SubAppbarWidget> {
  bool isSearching = false;
  List<Widget> actions;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Widget searchBtn = IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          isSearching = true;
          setState(() {});
        });

    Widget clearBtn = IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          isSearching = false;
          controller.text = "";
          widget.onSearch("");
          setState(() {});
        });
    actions = widget.actions;

    if (widget.enableSearch) {
      var searchAction = searchBtn;
      if (isSearching) {
        searchAction = clearBtn;
      }

      if (widget.actions == null) {
        actions = [searchAction];
      } else {
        print("adding search button");
        actions.add(searchAction);
      }
    }

    return AppBar(
      elevation: widget.elevation,
      leading: IconButton(
          onPressed: () {
            _handleBack();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          )),
      title: widget.enableSearch && isSearching
          ? Container(
              padding: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.red))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    onChanged: (text) {
                      widget.onSearch(text);
                    },
                    onFieldSubmitted: (text) {
                      widget.onSearch(text);
                    },
                    enabled: true,
                    onSaved: (v) {},
                    keyboardType: TextInputType.text,
                    validator: (text) {},
                    controller: controller,
                    style: GoogleFonts.roboto(color: Colors.white),
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.roboto(color: Colors.white),
                        labelText: "Search Biller",
                        hintText: "Search Biller"),
                  ),
                ],
              ),
            )
          : Text(widget.title,
              style: GoogleFonts.roboto(
                  fontSize: SizeConfig.blockSizeVertical * 3, fontWeight: FontWeight.w500)),
      actions: actions,
      bottom: widget.bottom,
    );
  }

  void _handleBack() {
    Get.back();
  }
}
