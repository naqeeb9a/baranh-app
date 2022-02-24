import 'package:baranh/app_screens/new_reservations.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/buttons_column.dart';
import 'package:baranh/widgets/custom_search.dart';
import 'package:baranh/widgets/essential_widgets.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'input_field_home.dart';

Widget tableCards(context, function, buttonText1, buttonText2,
    {setState = "",
    visible = false,
    visibleButton = true,
    shrinkWrap = false,
    physics = const AlwaysScrollableScrollPhysics()}) {
  final TextEditingController _tableNo = TextEditingController();
  var assignTable = 0;
  return FutureBuilder(
    future: function,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.data == false) {
          return shrinkWrap == true
              ? Column(
                  children: [retry(context), heightBox(context, 0.02)],
                )
              : retry(
                  context,
                );
        } else if (snapshot.data.length == 0) {
          return shrinkWrap == true
              ? SizedBox(
                  height: dynamicHeight(context, 0.4),
                  child: Center(
                      child: text(context, "No orders Yet!!", 0.04, myWhite)))
              : Center(child: text(context, "No orders Yet!!", 0.04, myWhite));
        } else {
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
                                visibleButton),
                          );
                        },
                        child: inputFieldsHome(
                          pageDecider == "Waiting For Arrival" ||
                                  pageDecider == "Arrived Guests"
                              ? "Search"
                              : "Table no:",
                          pageDecider == "Waiting For Arrival" ||
                                  pageDecider == "Arrived Guests"
                              ? "Ex: Name / phone"
                              : "Ex: table no",
                          context,
                          enable: false,
                          controller: _tableNo,
                        ),
                      ),
                      heightBox(context, 0.03),
                    ],
                  )),
              shrinkWrap == true
                  ? RefreshIndicator(
                      onRefresh: () {
                        return Future.delayed(const Duration(milliseconds: 0),
                            () {
                          setState();
                        });
                      },
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: shrinkWrap,
                        physics: physics,
                        itemBuilder: (BuildContext context, int index) {
                          return tableCardsExtension(
                            context,
                            snapshot.data,
                            index,
                            buttonText1,
                            buttonText2,
                            function: setState,
                            assignTable: assignTable,
                            visibleButton: visibleButton,
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: () {
                          return Future.delayed(const Duration(milliseconds: 0),
                              () {
                            setState();
                          });
                        },
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          shrinkWrap: shrinkWrap,
                          physics: physics,
                          itemBuilder: (BuildContext context, int index) {
                            return tableCardsExtension(context, snapshot.data,
                                index, buttonText1, buttonText2,
                                function: setState,
                                assignTable: assignTable,
                                visibleButton: visibleButton);
                          },
                        ),
                      ),
                    ),
            ],
          );
        }
      } else {
        return shrinkWrap == true
            ? SizedBox(
                height: dynamicHeight(context, 0.4),
                child: Center(
                  child: loader(context),
                ),
              )
            : loader(context);
      }
    },
  );
}

Widget tableCardsExtension(
  context,
  snapshotTable,
  indexTable,
  buttonText1,
  buttonText2, {
  function = "",
  assignTable,
  visibleButton = true,
  searchDelegate = "",
}) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.symmetric(vertical: dynamicHeight(context, 0.01)),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(dynamicWidth(context, 0.015)),
        border: Border.all(width: 1, color: myWhite.withOpacity(0.5))),
    padding: EdgeInsets.all(dynamicWidth(context, 0.04)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        snapshotTable[indexTable]["table_id"] == null
            ? text(
                context,
                snapshotTable[indexTable]["customer_name"]
                    .toString()
                    .toString(),
                0.05,
                myWhite,
                bold: true)
            : text(
                context,
                "Table: " + snapshotTable[indexTable]["table_name"].toString(),
                0.05,
                myWhite,
                bold: true),
        Divider(
          thickness: 1,
          color: myWhite.withOpacity(0.5),
        ),
        Visibility(
          child: text(
              context,
              snapshotTable[indexTable]["waiter_id"] != null
                  ? "Waiter : " +
                      snapshotTable[indexTable]["waiter_name"]
                          .toString()
                          .toUpperCase()
                  : "No Waiter assigned",
              0.04,
              snapshotTable[indexTable]["waiter_id"] != null ? myOrange : myRed,
              bold: true),
          visible: (pageDecider == "Arrived Guests" ||
                  pageDecider == "Dine In Orders")
              ? true
              : false,
        ),
        Visibility(
          visible: pageDecider == "Dine In Orders" ? true : false,
          child: text(
              context,
              snapshotTable[indexTable]["order_status"] == "1" ||
                      snapshotTable[indexTable]["order_status"] == "2"
                  ? "Active"
                  : "Completed",
              0.04,
              snapshotTable[indexTable]["order_status"] == "1" ||
                      snapshotTable[indexTable]["order_status"] == "2"
                  ? myGreen
                  : myOrange,
              bold: true),
        ),
        heightBox(context, 0.02),
        text(
            context,
            snapshotTable[indexTable]["customer_name"].toString() +
                "  |  " +
                snapshotTable[indexTable]["booked_seats"].toString() +
                "  |  " +
                getConvertedTime(
                    snapshotTable[indexTable]["opening_time"].toString()),
            0.04,
            myWhite),
        heightBox(context, 0.02),
        buttonsColumn(context, buttonText1, buttonText2, snapshotTable,
            indexTable, assignTable, function, visibleButton, searchDelegate)
      ],
    ),
  );
}
