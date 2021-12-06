import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/drawer.dart';
import 'package:baranh/widgets/essential_widgets.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      appBar: bar(context),
      drawer: SizedBox(
        width: dynamicWidth(context, .7),
        height: dynamicHeight(context, 1),
        child: Drawer(
          child: drawerItems(
            context,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.1)),
        child: Column(
          children: [
            heightBox(context, 0.05),
            text(context, "ALL RESERVATIONS", 0.05, myWhite),
            const Divider(
              thickness: 1,
              color: myWhite,
            ),
            heightBox(context, 0.02),
            inputFieldsHome(context, "Reservation Number:", "Ex:Res.00042"),
            heightBox(context, 0.02),
            inputFieldsHome(context, "Select Date:", "mm/dd/yy"),
            heightBox(context, 0.03),
            coloredButton(context, "SEARCH", myOrange)
          ],
        ),
      )),
    );
  }
}

Widget inputFieldsHome(context, text1, hintText1) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      text(context, text1, 0.04, myWhite),
      Container(
        color: myWhite,
        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.04)),
        child: TextFormField(
          decoration: InputDecoration(hintText: hintText1, fillColor: myWhite),
        ),
      )
    ],
  );
}
