import 'package:baranh/app_screens/orders_page.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

Widget tableCards(context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: dynamicHeight(context, 0.01)),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(dynamicWidth(context, 0.015)),
        border: Border.all(width: 1, color: myWhite.withOpacity(0.5))),
    padding: EdgeInsets.all(dynamicWidth(context, 0.04)),
    child: Column(
      children: [
        text(context, "Table: Muiz Sir", 0.04, myWhite),
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
                text(context, "Order: 009605", 0.035, myWhite),
                text(context, "Name: H", 0.035, myWhite),
                text(context, "Phone: 03212180787", 0.035, myWhite),
                text(context, "Date: 2021-12-04", 0.035, myWhite),
                text(context, "Time: 23:00-01:00", 0.035, myWhite),
                text(context, "Seats:4", 0.035, myWhite),
                text(context, "Status:Dine In", 0.035, myWhite),
              ],
            ),
            InkWell(
              onTap: () {
                push(context, const OrdersPage());
              },
              child: Container(
                padding: EdgeInsets.all(dynamicWidth(context, 0.03)),
                decoration: BoxDecoration(
                    color: myGreen,
                    borderRadius:
                        BorderRadius.circular(dynamicWidth(context, 0.01))),
                child: text(context, "View Details", 0.035, myWhite),
              ),
            )
          ],
        )
      ],
    ),
  );
}
