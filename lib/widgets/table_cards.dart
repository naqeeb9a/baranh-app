import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/app_screens/menu.dart';
import 'package:baranh/app_screens/order_summary_page.dart';

import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';

Widget tableCards(
  context,
  function,
  buttonText1,
  buttonText2, {
  setState = "",
  function1check = false,
  function2check = false,
}) {
  var assignTable = 0;
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
                function: setState,
                function1check: function1check,
                function2check: function2check,
                assignTable: assignTable);
          },
        );
      } else {
        return text(context, "not working", 0.028, Colors.white);
      }
    },
  );
}

Widget tableCardsExtension(
    context, snapshotTable, indexTable, buttonText1, buttonText2,
    {function = "",
    function1check = false,
    function2check = false,
    assignTable}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: dynamicHeight(context, 0.01)),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(dynamicWidth(context, 0.015)),
        border: Border.all(width: 1, color: myWhite.withOpacity(0.5))),
    padding: EdgeInsets.all(dynamicWidth(context, 0.04)),
    child: Column(
      children: [
        text(
            context,
            "Table: " + snapshotTable[indexTable]["table_id"].toString(),
            0.04,
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
                text(
                    context,
                    "Order: " + snapshotTable[indexTable]["sale_no"].toString(),
                    0.035,
                    myWhite),
                text(
                    context,
                    "Name: " +
                        snapshotTable[indexTable]["customer_name"].toString(),
                    0.035,
                    myWhite),
                text(
                    context,
                    "Phone: " +
                        snapshotTable[indexTable]["customer_phone"].toString(),
                    0.035,
                    myWhite),
                text(
                    context,
                    "Date: " +
                        snapshotTable[indexTable]["booking_date"].toString(),
                    0.035,
                    myWhite),
                text(
                    context,
                    "Time: " +
                        snapshotTable[indexTable]["opening_time"].toString(),
                    0.035,
                    myWhite),
                text(
                    context,
                    "Seats: " +
                        snapshotTable[indexTable]["booked_seats"].toString(),
                    0.035,
                    myWhite),
                text(
                    context,
                    "Status: " +
                        snapshotTable[indexTable]["usage_status"].toString(),
                    0.035,
                    myWhite),
              ],
            ),
            SizedBox(
              height: dynamicHeight(context, 0.12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  greenButtons(context, buttonText1, snapshotTable, indexTable,
                      function: () async {
                    if (buttonText1 == "View detail") {
                      push(
                          context,
                          OrderSummaryPage(
                            saleId:
                                snapshotTable[indexTable]["sale_id"].toString(),
                          ));
                    } else if (buttonText1 == "Assign Table") {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: text(
                                  context, "Assign Table", 0.04, Colors.white,
                                  bold: true),
                              backgroundColor: myBlack,
                              content: Container(
                                color: myBlack,
                                height: dynamicHeight(context, 0.6),
                                width: dynamicWidth(context, 0.8),
                                child: FutureBuilder(
                                  future: getTables(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return LottieBuilder.asset(
                                        "assets/loader.json",
                                        width: dynamicWidth(context, 0.1),
                                      );
                                    } else if (snapshot.data == false) {
                                      return text(context, "Server Error",
                                          0.028, Colors.white);
                                    } else if (snapshot.data.length == 0) {
                                      return Center(
                                          child: text(context, "no Tables!!",
                                              0.028, Colors.white));
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                mainAxisSpacing: 5,
                                                crossAxisSpacing: 5),
                                        itemCount: snapshot.data.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () async {
                                              assignTable =
                                                  snapshot.data[index]["name"];

                                              var response =
                                                  await assignTableOnline(
                                                      snapshotTable[indexTable]
                                                          ["sale_id"],
                                                      assignTable);
                                              if (response == false) {
                                                MotionToast.error(
                                                  description:
                                                      "Table not assigned Check your internet",
                                                  dismissable: true,
                                                ).show(context);
                                              } else {
                                                pageDecider = "Dine In Orders";
                                                Navigator.pop(
                                                    context, globalRefresh());
                                              }
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              color: myOrange,
                                              child: text(
                                                  context,
                                                  "Table\n" +
                                                      snapshot.data[index]
                                                          ["name"],
                                                  0.04,
                                                  Colors.white,
                                                  alignText: TextAlign.center),
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return text(context, "not working", 0.028,
                                          Colors.white);
                                    }
                                  },
                                ),
                              ),
                            );
                          });
                    } else {
                      var response = await arrivedGuests(
                          snapshotTable[indexTable]["sale_id"]);
                      if (response == false) {
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
                          cancelBtnText: "Cancel",
                          type: CoolAlertType.success,
                          onConfirmBtnTap: () {
                            pageDecider = "Arrived Guests";
                            globalRefresh();
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          backgroundColor: myOrange,
                          confirmBtnColor: myOrange,
                        );
                      }
                    }
                  }),
                  greenButtons(
                    context,
                    buttonText2,
                    snapshotTable,
                    indexTable,
                    function: () {
                      if (buttonText2 == "Assign Waiter") {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: text(
                                    context, "Assign Table", 0.04, Colors.white,
                                    bold: true),
                                backgroundColor: myBlack,
                                content: Container(
                                  color: myBlack,
                                  height: dynamicHeight(context, 0.6),
                                  width: dynamicWidth(context, 0.8),
                                  child: FutureBuilder(
                                    future: getWaiters(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return LottieBuilder.asset(
                                          "assets/loader.json",
                                          width: dynamicWidth(context, 0.1),
                                        );
                                      } else if (snapshot.data == false) {
                                        return text(context, "Server Error",
                                            0.028, Colors.white);
                                      } else if (snapshot.data.length == 0) {
                                        return Center(
                                            child: text(context, "no Waiters!!",
                                                0.028, Colors.white));
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 4,
                                                  mainAxisSpacing: 5,
                                                  crossAxisSpacing: 5),
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () async {
                                                assignTable =
                                                    snapshot.data[index]["id"];

                                                var response =
                                                    await assignWaiterOnline(
                                                        snapshotTable[
                                                                indexTable]
                                                            ["sale_id"],
                                                        assignTable);
                                                if (response == false) {
                                                  MotionToast.error(
                                                    description:
                                                        "Waiter not assigned Check your internet",
                                                    dismissable: true,
                                                  ).show(context);
                                                } else {
                                                  Navigator.pop(
                                                      context, function());
                                                }
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                color: myOrange,
                                                child: FittedBox(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        dynamicWidth(
                                                            context, 0.01)),
                                                    child: text(
                                                        context,
                                                        snapshot.data[index]
                                                                ["full_name"] +
                                                            "\n" +
                                                            snapshot.data[index]
                                                                ["id"],
                                                        0.04,
                                                        Colors.white,
                                                        alignText:
                                                            TextAlign.center),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        return text(context, "not working",
                                            0.028, Colors.white);
                                      }
                                    },
                                  ),
                                ),
                              );
                            });
                      } else {
                        push(
                          context,
                          function2check == true
                              ? MenuPage(
                                  saleId: snapshotTable[indexTable]["sale_id"]
                                      .toString(),
                                  tableNo: snapshotTable[indexTable]["table_id"]
                                      .toString(),
                                )
                              : OrderSummaryPage(
                                  saleId: snapshotTable[indexTable]["sale_id"]
                                      .toString(),
                                ),
                        );
                      }
                    },
                  ),
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
