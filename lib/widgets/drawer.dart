import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

Widget drawerItems(context, function) {
  List drawerItemList = [
    {
      "icon": Icons.calendar_today,
      "text": "All Reservations",
      "function": () {
        pageDecider = "All Reservations";
        Navigator.pop(context, function());
      },
    },
    {
      "icon": Icons.share_arrival_time_rounded,
      "text": "Waiting For Arrival",
      "function": () {
        pageDecider = "Waiting For Arrival";
        Navigator.pop(context, function());
      },
    },
    {
      "icon": Icons.supervised_user_circle_rounded,
      "text": "Arrived Guests",
      "function": () {
        pageDecider = "Arrived Guests";
        Navigator.pop(context, function());
      },
    },
    {
      "icon": Icons.notes_rounded,
      "text": "Dine In Orders",
      "function": () {
        pageDecider = "Dine In Orders";
        Navigator.pop(context, function());
      },
    },
    {
      "icon": Icons.calendar_today,
      "text": "New Reservations",
      "function": () {
        pageDecider = "New Reservations";
        Navigator.pop(context, function());
      },
    },
    {
      "icon": Icons.notifications_active_rounded,
      "text": "Notifications",
      "function": () {
        pageDecider = "Notifications";
        Navigator.pop(context, function());
      },
    },
    {
      "icon": Icons.logout,
      "text": "LogOut",
      "function": () {
        popUntil(context);
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
                Icon(
                  Icons.menu_rounded,
                  color: myWhite,
                  size: dynamicWidth(context, .07),
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
