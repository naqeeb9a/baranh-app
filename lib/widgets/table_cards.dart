import 'dart:async';

import 'package:baranh/app_functions/functions.dart';
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
  return FutureBuilder(
    future: function,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return UpdateTableCards(
          snapshot: snapshot.data,
          shrinkWrap: shrinkWrap,
          physics: physics,
          buttonText1: buttonText1,
          buttonText2: buttonText2,
          setState: setState,
          visibleButton: visibleButton,
          visible: visible,
        );
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

// ignore: must_be_immutable
class UpdateTableCards extends StatefulWidget {
  dynamic snapshot,
      shrinkWrap,
      physics,
      buttonText1,
      buttonText2,
      setState,
      visibleButton,
      visible;
  UpdateTableCards(
      {Key? key,
      required this.snapshot,
      required this.shrinkWrap,
      required this.physics,
      required this.buttonText1,
      required this.buttonText2,
      required this.setState,
      required this.visibleButton,
      required this.visible})
      : super(key: key);
  bool isMount = true;
  @override
  State<UpdateTableCards> createState() => _UpdateTableCardsState();
}

class _UpdateTableCardsState extends State<UpdateTableCards> {
  final TextEditingController _tableNo = TextEditingController();

  var assignTable = 0;
  updateOrders() async {
    dynamic newData = "";
    if (pageDecider == "Dine In Orders") {
      newData = await getDineInOrders("dinein-orders", false);
    } else if (pageDecider == "All Reservations") {
      newData = await getReservationData("reservelist");
    } else if (pageDecider == "Waiting For Arrival") {
      newData = await getReservationData("waiting-for-arrival");
    } else {
      newData = await getReservationData("arrived");
    }

    if (widget.isMount == true) {
      setState(() {
        widget.snapshot = newData;
      });
    }
  }

  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 10), ((timer) async {
      await updateOrders();
    }));
    super.initState();
  }

  @override
  void dispose() {
    widget.isMount = false;

    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.snapshot == false
        ? (widget.shrinkWrap == true
            ? Column(
                children: [retry(context), heightBox(context, 0.02)],
              )
            : retry(
                context,
              ))
        : widget.snapshot.length == 0
            ? (widget.shrinkWrap == true
                ? SizedBox(
                    height: dynamicHeight(context, 0.4),
                    child: Center(
                        child: text(context, "No orders Yet!!", 0.04, myWhite)))
                : Center(
                    child: text(context, "No orders Yet!!", 0.04, myWhite)))
            : Column(
                children: [
                  Visibility(
                      visible: widget.visible,
                      child: Column(
                        children: [
                          heightBox(context, 0.02),
                          InkWell(
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: CustomDineInSearchDelegate(
                                    widget.snapshot,
                                    setState,
                                    assignTable,
                                    widget.buttonText1,
                                    widget.buttonText2,
                                    widget.visibleButton),
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
                  widget.shrinkWrap == true
                      ? RefreshIndicator(
                          onRefresh: () {
                            return Future.delayed(
                                const Duration(milliseconds: 0), () {
                              globalRefresh();
                            });
                          },
                          child: ListView.builder(
                            itemCount: widget.snapshot.length,
                            shrinkWrap: widget.shrinkWrap,
                            physics: widget.physics,
                            itemBuilder: (BuildContext context, int index) {
                              return TableCardsExtension(
                                  context: context,
                                  snapshotTable: widget.snapshot,
                                  indexTable: index,
                                  buttonText1: widget.buttonText1,
                                  buttonText2: widget.buttonText2,
                                  function: widget.setState,
                                  assignTable: assignTable,
                                  visibleButton: widget.visibleButton);
                            },
                          ),
                        )
                      : Expanded(
                          child: RefreshIndicator(
                          onRefresh: () {
                            return Future.delayed(
                                const Duration(milliseconds: 0), () {
                              globalRefresh();
                            });
                          },
                          child: ListView.builder(
                            itemCount: widget.snapshot.length,
                            shrinkWrap: widget.shrinkWrap,
                            physics: widget.physics,
                            itemBuilder: (BuildContext context, int index) {
                              return TableCardsExtension(
                                  context: context,
                                  snapshotTable: widget.snapshot,
                                  indexTable: index,
                                  buttonText1: widget.buttonText1,
                                  buttonText2: widget.buttonText2,
                                  function: widget.setState,
                                  assignTable: assignTable,
                                  visibleButton: widget.visibleButton);
                            },
                          ),
                        )),
                ],
              );
  }
}

class TableCardsExtension extends StatelessWidget {
  final dynamic context,
      snapshotTable,
      indexTable,
      buttonText1,
      buttonText2,
      function,
      assignTable,
      visibleButton,
      searchDelegate;
  const TableCardsExtension(
      {Key? key,
      this.context,
      this.snapshotTable,
      this.indexTable,
      this.buttonText1,
      this.buttonText2,
      this.function = "",
      this.assignTable,
      this.visibleButton = true,
      this.searchDelegate = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  "Table: " +
                      snapshotTable[indexTable]["table_name"].toString(),
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
                snapshotTable[indexTable]["waiter_id"] != null
                    ? myOrange
                    : myRed,
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
                  getConvertedTime(snapshotTable[indexTable]["opening_time"] ??
                      "not provided"),
              0.04,
              myWhite),
          heightBox(context, 0.02),
          buttonsColumn(customContext, buttonText1, buttonText2, snapshotTable,
              indexTable, assignTable, function, visibleButton, searchDelegate)
        ],
      ),
    );
  }
}
