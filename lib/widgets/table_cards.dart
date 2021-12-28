import 'package:baranh/app_screens/orders_page.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget tableCards(context, function) {
  return FutureBuilder(
    future: function,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return LottieBuilder.asset(
          "assets/loader.json",
          width: dynamicWidth(context, 0.3),
        );
      } else if (snapshot.data == false) {
        return text(context, "Server Error", 0.028, Colors.white);
      } else if (snapshot.data.length == 0) {
        return text(context, "no Orders Yet!!", 0.028, Colors.white);
      } else if (snapshot.connectionState == ConnectionState.done) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return tableCardsExtension(context, snapshot.data, index);
          },
        );
      } else {
        return text(context, "not working", 0.028, Colors.white);
      }
    },
  );
}

Widget tableCardsExtension(context, snapshot, index) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: dynamicHeight(context, 0.01)),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(dynamicWidth(context, 0.015)),
        border: Border.all(width: 1, color: myWhite.withOpacity(0.5))),
    padding: EdgeInsets.all(dynamicWidth(context, 0.04)),
    child: Column(
      children: [
        text(context, "Table: " + snapshot[index]["table_id"], 0.04, myWhite),
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
                text(context, "Order: " + snapshot[index]["sale_no"], 0.035,
                    myWhite),
                text(context, "Name: " + snapshot[index]["customer_name"],
                    0.035, myWhite),
                text(context, "Phone: " + snapshot[index]["customer_phone"],
                    0.035, myWhite),
                text(context, "Date: " + snapshot[index]["booking_date"], 0.035,
                    myWhite),
                text(context, "Time: " + snapshot[index]["opening_time"], 0.035,
                    myWhite),
                text(context, "Seats: " + snapshot[index]["booked_seats"],
                    0.035, myWhite),
                text(context, "Status: " + snapshot[index]["usage_status"],
                    0.035, myWhite),
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
