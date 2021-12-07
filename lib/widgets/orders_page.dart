import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
        child: Column(
          children: [
            heightBox(context, 0.05),
            text(context, "ORDER DETAILS #009851", 0.05, myWhite),
            const Divider(
              thickness: 1,
              color: myWhite,
            ),
            orderDetailCard(context),
            heightBox(context, 0.02),
            coloredButton(context, "Guest Arrived", myGreen, fontSize: 0.035),
            heightBox(context, 0.01),
            coloredButton(context, "Order Summary", myGreen, fontSize: 0.035),
          ],
        ),
      ),
    );
  }
}

Widget orderDetailCard(context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: dynamicHeight(context, 0.01)),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(dynamicWidth(context, 0.015)),
        border: Border.all(width: 1, color: myWhite.withOpacity(0.5))),
    padding: EdgeInsets.all(dynamicWidth(context, 0.04)),
    child: Column(
      children: [
        text(context, "Table:", 0.05, myWhite),
        Divider(
          thickness: 1,
          color: myWhite.withOpacity(0.5),
        ),
        text(context, "Status: Booked", 0.035, myWhite),
        Divider(
          thickness: 1,
          color: myWhite.withOpacity(0.5),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(context, "Name:Anamzohaib Zohaib", 0.035, myWhite),
                text(context, "Phone: 03212180787", 0.035, myWhite),
                text(context, "Date: 2021-12-06", 0.035, myWhite),
                text(context, "Time: 23:00-01:00", 0.035, myWhite),
                text(context, "Seats:4", 0.035, myWhite),
                text(context, "Status:Booked", 0.035, myWhite),
              ],
            ),
            SizedBox(
              height: dynamicHeight(context, 0.15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      push(context, const OrdersPage());
                    },
                    child: Container(
                      padding: EdgeInsets.all(dynamicWidth(context, 0.03)),
                      decoration: BoxDecoration(
                          color: myGreen,
                          borderRadius: BorderRadius.circular(
                              dynamicWidth(context, 0.01))),
                      child: text(context, "History", 0.035, myWhite),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(dynamicWidth(context, 0.03)),
                      decoration: BoxDecoration(
                          color: myRed,
                          borderRadius: BorderRadius.circular(
                              dynamicWidth(context, 0.01))),
                      child: text(context, "  Back  ", 0.035, myWhite),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}
