import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/app_screens/orders_page.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget tableCards(context, function, buttonText1, buttonText2,
    {setstate = ""}) {
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
        return Center(
            child: text(context, "no Orders Yet!!", 0.028, Colors.white));
      } else if (snapshot.connectionState == ConnectionState.done) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return tableCardsExtension(
                context, snapshot.data, index, buttonText1, buttonText2,
                function: setstate);
          },
        );
      } else {
        return text(context, "not working", 0.028, Colors.white);
      }
    },
  );
}

Widget tableCardsExtension(context, snapshot, index, buttonText1, buttonText2,
    {function = ""}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: dynamicHeight(context, 0.01)),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(dynamicWidth(context, 0.015)),
        border: Border.all(width: 1, color: myWhite.withOpacity(0.5))),
    padding: EdgeInsets.all(dynamicWidth(context, 0.04)),
    child: Column(
      children: [
        text(context, "Table: " + snapshot[index]["table_id"].toString(), 0.04,
            myWhite),
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
                text(context, "Order: " + snapshot[index]["sale_no"].toString(),
                    0.035, myWhite),
                text(
                    context,
                    "Name: " + snapshot[index]["customer_name"].toString(),
                    0.035,
                    myWhite),
                text(
                    context,
                    "Phone: " + snapshot[index]["customer_phone"].toString(),
                    0.035,
                    myWhite),
                text(
                    context,
                    "Date: " + snapshot[index]["booking_date"].toString(),
                    0.035,
                    myWhite),
                text(
                    context,
                    "Time: " + snapshot[index]["opening_time"].toString(),
                    0.035,
                    myWhite),
                text(
                    context,
                    "Seats: " + snapshot[index]["booked_seats"].toString(),
                    0.035,
                    myWhite),
                text(
                    context,
                    "Status: " + snapshot[index]["usage_status"].toString(),
                    0.035,
                    myWhite),
              ],
            ),
            SizedBox(
              height: dynamicHeight(context, 0.12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  greenButtons(context, buttonText1, snapshot, index,
                      function: () async {
                    var respone =
                        await arrivedGuests(snapshot[index]["sale_id"]);
                    if (respone == false) {
                      CoolAlert.show(
                          context: context,
                          text:
                              "There is some problem in Internet or the Server",
                          confirmBtnText: "Retry",
                          type: CoolAlertType.error,
                          backgroundColor: myOrange,
                          confirmBtnColor: myOrange);
                    } else {
                      CoolAlert.show(
                          context: context,
                          text: "Guest Arrived Successfully",
                          confirmBtnText: "continue",
                          type: CoolAlertType.success,
                          onConfirmBtnTap: () {
                            pageDecider = "Arrived Guests";
                            globalRefresh();
                          },
                          backgroundColor: myOrange,
                          confirmBtnColor: myOrange);
                    }
                  }),
                  greenButtons(context, buttonText2, snapshot, index,
                      function: () {
                    push(
                        context,
                        OrdersPage(
                          snapShot: snapshot[index],
                        ));
                  })
                ],
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget greenButtons(context, text1, snapshot, index, {function = ""}) {
  return InkWell(
    onTap: function == "" ? () {} : function,
    child: Container(
      alignment: Alignment.center,
      width: dynamicWidth(context, 0.3),
      padding: EdgeInsets.all(dynamicWidth(context, 0.03)),
      decoration: BoxDecoration(
          color: myGreen,
          borderRadius: BorderRadius.circular(dynamicWidth(context, 0.01))),
      child: text(context, text1, 0.035, myWhite),
    ),
  );
}
