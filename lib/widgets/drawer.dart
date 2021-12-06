import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

Widget drawerItems(context) {
  List drawerItemList = [
    {
      "icon": Icons.calendar_today,
      "text": "All Reservations",
      "function": () {
        pop(context);
        // push(context, AboutUs());
      },
    },
    {
      "icon": Icons.share_arrival_time_rounded,
      "text": "Waiting For Arrival",
      "function": () {
        pop(context);
        // push(context, PoliciesPage());
      },
    },
    {
      "icon": Icons.supervised_user_circle_rounded,
      "text": "Arrived Guests",
      "function": () {
        pop(context);
        // push(context, StoreFinder());
      },
    },
    {
      "icon": Icons.notes_rounded,
      "text": "Dine In Orders",
      "function": () {
        pop(context);
        // push(context, ContactPage());
      },
    },
    {
      "icon": Icons.calendar_today,
      "text": "New Reservations",
      "function": () {
        pop(context);
        // push(context, ContactPage());
      },
    },
    {
      "icon": Icons.notifications_active_rounded,
      "text": "Notifications",
      "function": () {
        pop(context);
        // push(context, ContactPage());
      },
    },
    {
      "icon": Icons.logout,
      "text": "LogOut",
      "function": () {
        pop(context);
        // push(context, ContactPage());
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
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: dynamicHeight(context, .03),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                text(
                  context,
                  "Hi user name\n(Floor Manager)",
                  .05,
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
