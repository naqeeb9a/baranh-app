import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/app_screens/login.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget drawerItems(context, function, changeState) {
  List drawerItemList = [
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
      "icon": Icons.logout,
      "text": "LogOut",
      "function": () async {
        changeState();
        Future.delayed(const Duration(milliseconds: 500), () async {
          SharedPreferences loginUser = await SharedPreferences.getInstance();
          loginUser.clear();
          userResponse = "";

          checkLoginStatus(context1) async {
            SharedPreferences loginUser = await SharedPreferences.getInstance();
            if (loginUser.getString("userResponse") == null) {
              Navigator.pushAndRemoveUntil(
                  context1,
                  MaterialPageRoute(builder: (context1) => const LoginScreen()),
                  (route) => false);
            }
          }

          checkLoginStatus(context);
        });
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
                  userResponse == ""
                      ? ""
                      : "Hi ${userResponse["full_name"] ?? ""}\n(${userResponse["designation"] ?? ""})\n\n${userResponse["outlet_name"] ?? ""}",
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
                top: dynamicHeight(context, .036),
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
  return StatefulBuilder(builder: (context, changeState) {
    num total = 0;
    num cost = 0;
    getTotal() {
      for (var item in cartItems) {
        total += num.parse(item["sale_price"]) * item["qty"];
      }
      return total;
    }

    getCost() {
      for (var item in cartItems) {
        cost += num.parse(item["sale_price"]) * item["qty"];
      }
      return cost;
    }

    cost = getCost();
    return ColoredBox(
      color: myBlack.withOpacity(.9),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: dynamicWidth(context, 0.04),
        ),
        child: Column(
          children: [
            dividerRowWidgets(context, "YOUR CART", ""),
            Divider(
              thickness: 1,
              color: myWhite.withOpacity(0.5),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: dynamicHeight(context, 0.01),
                  ),
                  child: cartCards(context, index, () {
                    changeState(() {});
                  }),
                );
              },
            )),
            dividerRowWidgets(
                context, "TOTAL: ", "PKR " + getTotal().toString(),
                check: true),
            heightBox(context, 0.02),
            coloredButton(
              context,
              "Place Order",
              const Color(0xFF008000),
              fontSize: 0.035,
              function: () async {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.loading,
                    barrierDismissible: false,
                    lottieAsset: "assets/loader.json");
                var response = await punchOrder(total, cost);
                if (response == false) {
                  Navigator.of(context, rootNavigator: true).pop();
                  MotionToast.error(
                    description: "Server Error or check your internet",
                    dismissable: true,
                  ).show(context);
                } else {
                  Navigator.of(context, rootNavigator: true).pop();
                  cartItems.clear();
                  saleIdGlobal = "";
                  tableNoGlobal = "";

                  pop(context);
                  popUntil(globalDineInContext);
                  globalDineInRefresh();
                  MotionToast.success(
                    description: "Order Placed",
                    dismissable: true,
                  ).show(context);
                }
              },
            ),
            heightBox(context, 0.02),
            coloredButton(
              context,
              "CONTINUE ORDERING",
              Colors.transparent,
              fontSize: 0.035,
              function: () {
                pop(context);
              },
            )
          ],
        ),
      ),
    );
  });
}

cartCards(context, index, function) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.network(
        cartItems[index]["photo"] ??
            "https://neurologist-ahmedabad.com/wp-content/themes/apexclinic/images/no-image/No-Image-Found-400x264.png",
        height: dynamicWidth(context, 0.2),
        width: dynamicWidth(context, 0.15),
        fit: BoxFit.cover,
      ),
      FittedBox(
        child: SizedBox(
          width: dynamicWidth(context, 0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              text(
                context,
                cartItems[index]["name"].toString(),
                0.04,
                myWhite,
              ),
              text(
                context,
                "Rs. " +
                    cartItems[index]["sale_price"].toString() +
                    " x " +
                    cartItems[index]["qty"].toString(),
                0.04,
                myWhite,
              ),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {
          cartItems.remove(cartItems[index]);
          menuRefresh();
          function();
        },
        child: const Icon(
          Icons.close,
          color: myWhite,
        ),
      )
    ],
  );
}

Widget dividerRowWidgets(context, text1, text2, {check = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: dynamicHeight(context, 0.01)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text(context, text1, 0.04, myWhite),
        check == true
            ? text(
                context,
                "$text2",
                0.04,
                myWhite,
              )
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
