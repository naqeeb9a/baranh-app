import 'package:baranh/app_screens/menu.dart';
import 'package:baranh/app_screens/order_summary_page.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/custom_search.dart';
import 'package:baranh/widgets/essential_widgets.dart';
import 'package:baranh/widgets/green_buttons.dart';
import 'package:baranh/widgets/guest_arrived_function.dart';
import 'package:baranh/widgets/show_alert.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import 'input_field_home.dart';

Widget tableCards(context, function, buttonText1, buttonText2,
    {setState = "",
    function1check = false,
    function2check = false,
    visible = false}) {
  final TextEditingController _tableNo = TextEditingController();
  var assignTable = 0;
  return FutureBuilder(
    future: function,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data.length == 0) {
          return Center(
            child: text(context, "no Orders Yet!!", 0.028, myWhite),
          );
        } else if (snapshot.data.length > 0) {
          return Column(
            children: [
              Visibility(
                  visible: visible,
                  child: Column(
                    children: [
                      heightBox(context, 0.02),
                      InkWell(
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: CustomDineInSearchDelegate(
                              snapshot.data,
                              setState,
                              assignTable,
                              buttonText1,
                              buttonText2,
                              function1check,
                              function2check,
                            ),
                          );
                        },
                        child: inputFieldsHome(
                          "Search:",
                          "Ex: table no, name, phone",
                          context,
                          enable: false,
                          controller: _tableNo,
                        ),
                      ),
                      heightBox(context, 0.03),
                    ],
                  )),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () {
                    return Future.delayed(const Duration(milliseconds: 0), () {
                      setState();
                    });
                  },
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return tableCardsExtension(
                        context,
                        snapshot.data,
                        index,
                        buttonText1,
                        buttonText2,
                        function: setState,
                        function1check: function1check,
                        function2check: function2check,
                        assignTable: assignTable,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
      } else if (snapshot.data == false) {
        return retry(context);
      }
      return loader(context);
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
        snapshotTable[indexTable]["table_id"] == null
            ? text(
                context,
                snapshotTable[indexTable]["customer_name"]
                    .toString()
                    .toString(),
                0.04,
                myWhite)
            : text(
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
              height: dynamicHeight(
                  context, buttonText1 == "View detail" ? 0.16 : 0.12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: buttonText1 == "View detail" ? true : false,
                    child: greenButtons(
                        context, "Change Table", snapshotTable, indexTable,
                        function: () {
                      dailoageCustom(context, snapshotTable, indexTable,
                          assignTable, function);
                    }),
                  ),
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
                      dailoageCustom(context, snapshotTable, indexTable,
                          assignTable, function);
                    } else if (buttonText1 == "Assign Waiter") {
                      dailogCustomWaiter(context, snapshotTable, indexTable,
                          assignTable, function);
                    } else if (buttonText1 == "Guest Arrived") {
                      guestArrivedNow(context, snapshotTable, indexTable);
                    } else {
                      MotionToast.info(
                        description: "Something Went wrong",
                        dismissable: true,
                      ).show(context);
                    }
                  }),
                  greenButtons(
                    context,
                    buttonText2,
                    snapshotTable,
                    indexTable,
                    function: () {
                      if (buttonText2 == "Assign Waiter") {
                        dailogCustomWaiter(context, snapshotTable, indexTable,
                            assignTable, function);
                      } else if (buttonText2 == "Assign Table") {
                        dailoageCustom(context, snapshotTable, indexTable,
                            assignTable, function);
                      } else if (buttonText2 == "Take Order") {
                        push(
                            context,
                            MenuPage(
                              saleId: snapshotTable[indexTable]["sale_id"]
                                  .toString(),
                              tableNo: snapshotTable[indexTable]["table_id"]
                                  .toString(),
                            ));
                      } else if (buttonText2 == "View detail") {
                        push(
                          context,
                          OrderSummaryPage(
                            saleId:
                                snapshotTable[indexTable]["sale_id"].toString(),
                          ),
                        );
                      } else {
                        MotionToast.error(description: "Something went Wrong");
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
