import 'package:baranh/main.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget drawerItems(
  context,
  function,
) {
  List drawerItemList = [
    {
      "icon": Icons.calendar_today,
      "text": "All Reservations",
      "function": () {
        pageDecider = "All Reservations";
        popUntil(customContext);
        Navigator.pop(context, function());
      },
    },
    {
      "icon": Icons.share_arrival_time_rounded,
      "text": "Waiting For Arrival",
      "function": () {
        pageDecider = "Waiting For Arrival";
        popUntil(customContext);
        Navigator.pop(context, function());
      },
    },
    {
      "icon": Icons.supervised_user_circle_rounded,
      "text": "Arrived Guests",
      "function": () {
        pageDecider = "Arrived Guests";
        popUntil(customContext);
        Navigator.pop(context, function());
      },
    },
    {
      "icon": Icons.notes_rounded,
      "text": "Dine In Orders",
      "function": () {
        pageDecider = "Dine In Orders";
        popUntil(customContext);
        Navigator.pop(context, function());
      },
    },
    {
      "icon": Icons.calendar_today,
      "text": "New Reservations",
      "function": () {
        pageDecider = "New Reservations";
        popUntil(customContext);
        Navigator.pop(context, function());
      },
    },
    {
      "icon": Icons.notifications_active_rounded,
      "text": "Notifications",
      "function": () {
        pageDecider = "Notifications";
        popUntil(customContext);
        Navigator.pop(context, function());
      },
    },
    {
      "icon": Icons.logout,
      "text": "LogOut",
      "function": () async {
        SharedPreferences loginUser = await SharedPreferences.getInstance();
        loginUser.clear();
        checkLoginStatus(context);
      },
    },
  ];
  return SafeArea(
    child: ColoredBox(
      color: myBlack.withOpacity(.9),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: dynamicHeight(context, .02),
              horizontal: dynamicWidth(context, .02),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/menu.png",
                  scale: 30,
                ),
                text(context, "MENU", .05, myWhite, bold: true),
                InkWell(
                  onTap: () {
                    pop(context);
                  },
                  child: Icon(
                    Icons.close_rounded,
                    color: myWhite,
                    size: dynamicWidth(context, .08),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 0,
            color: myWhite,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: dynamicHeight(context, .04),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                text(
                  context,
                  "Hi user name\n(Floor Manager)",
                  .054,
                  myWhite,
                  bold: true,
                ),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(
                top: dynamicHeight(context, .04),
                left: dynamicWidth(context, .02),
              ),
              child: ListView.builder(
                itemCount: drawerItemList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: drawerItemList[index]["function"],
                    leading: Icon(
                      drawerItemList[index]["icon"],
                      color: myWhite,
                    ),
                    title: Text(
                      drawerItemList[index]["text"].toString().toUpperCase(),
                      style: TextStyle(
                        color: myWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: dynamicWidth(context, .044),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget drawerItems2(context) {
  return ColoredBox(
    color: myBlack.withOpacity(.9),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: dynamicWidth(context, 0.04),
      ),
      child: Column(
        children: [
          dividerRowWigets(context, "YOUR CART"),
          Divider(
            thickness: 1,
            color: myWhite.withOpacity(0.5),
          ),
          dividerRowWigets(context, "TOTAL:", check: true),
          heightBox(context, 0.02),
          coloredButton(context, "GO TO CHECKOUT", const Color(0xFF008000),
              fontSize: 0.035),
          heightBox(context, 0.02),
          coloredButton(context, "CONTINUE ORDERING", Colors.transparent,
              fontSize: 0.035)
        ],
      ),
    ),
  );
}

Widget dividerRowWigets(context, text1, {check = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: dynamicHeight(context, 0.01)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text(context, text1, 0.04, myWhite),
        check == true
            ? text(context, "PKR 0", 0.04, myWhite)
            : InkWell(
                onTap: () {
                  pop(context);
                },
                child: Icon(
                  Icons.close_rounded,
                  color: myWhite,
                  size: dynamicWidth(context, .08),
                ),
              ),
      ],
    ),
  );
}
