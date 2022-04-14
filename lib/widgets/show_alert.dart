import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:baranh/widgets/toast.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import 'essential_widgets.dart';

dialogueCustom(
    context, snapshotTable, indexTable, assignTable, function, searchDelegate) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text(context, "Assign Table", 0.04, myWhite, bold: true),
                const Icon(
                  Icons.close,
                  color: myWhite,
                )
              ],
            ),
          ),
          backgroundColor: myBlack,
          content: Container(
            color: myBlack,
            height: dynamicHeight(context, 0.6),
            width: dynamicWidth(context, 0.8),
            child: FutureBuilder(
                future: getDineInOrders("dinein-orders", true),
                builder: (context, snapshot2) {
                  if (snapshot2.connectionState == ConnectionState.done) {
                    if (snapshot2.data == false) {
                      return Center(
                        child: text(
                            context,
                            "Check your internet or try again later",
                            0.04,
                            myWhite),
                      );
                    } else if (snapshot2.hasData) {
                      return FutureBuilder(
                        future: getTables(snapshotTable[indexTable]["sale_id"]),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return loader(context);
                          } else if (snapshot.data == false) {
                            return retry(
                              context,
                            );
                          } else if (snapshot.data.length == 0) {
                            return Center(
                              child: text(
                                context,
                                "no Tables!!",
                                0.028,
                                myWhite,
                              ),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                var customColor = myOrange;

                                for (var i = 0;
                                    i < (snapshot2.data as List).length;
                                    i++) {
                                  if (((snapshot2.data as List)[i]
                                                  ["order_status"] ==
                                              "1" ||
                                          (snapshot2.data as List)[i]
                                                  ["order_status"] ==
                                              "2") &&
                                      snapshot.data[index]["id"] ==
                                          (snapshot2.data as List)[i]
                                              ["table_id"]) {
                                    customColor = myGrey;
                                  }
                                }
                                return InkWell(
                                  onTap: () async {
                                    if (customColor == myGrey) {
                                      customToastFlutter(
                                          "Table Already reserved");
                                    } else if (snapshotTable[indexTable]
                                                ["waiter_id"] ==
                                            null &&
                                        userResponse["designation"]
                                                .toString()
                                                .toLowerCase() ==
                                            "Floor Manager".toLowerCase()) {
                                      customToastFlutter("Assign waiter first");
                                    } else {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.loading,
                                          barrierDismissible: false,
                                          lottieAsset: "assets/loader.json");
                                      if (snapshotTable[indexTable]
                                                  ["waiter_id"] ==
                                              null &&
                                          userResponse["designation"]
                                                  .toString()
                                                  .toLowerCase() ==
                                              "Waiter".toLowerCase()) {
                                        assignTable = userResponse["id"];

                                        var response = await assignWaiterOnline(
                                            snapshotTable[indexTable]
                                                ["sale_id"],
                                            assignTable);
                                        if (response == false) {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                          customToastFlutter(
                                              "Waiter not assigned Check your internet");
                                        } else {
                                          assignTable =
                                              snapshot.data[index]["id"];

                                          var response =
                                              await assignTableOnline(
                                                  snapshotTable[indexTable]
                                                      ["sale_id"],
                                                  assignTable);

                                          if (response == false) {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                            customToastFlutter(
                                                "Table not assigned Check your internet");
                                          } else if (response ==
                                              "already reserved") {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                            customToastFlutter(
                                                "Table already assigned reopen the dialogue to get the updated status");
                                          } else {
                                            pageDecider = "Dine In Orders";
                                            Navigator.pop(
                                                context, globalRefresh());
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                            if (searchDelegate != "") {
                                              searchDelegate();
                                            }
                                            customToastFlutter(snapshotTable[
                                                                indexTable]
                                                            ["waiter_id"] ==
                                                        null &&
                                                    userResponse["designation"]
                                                            .toString()
                                                            .toLowerCase() ==
                                                        "waiter".toLowerCase()
                                                ? "Table and Waiter both Assigned"
                                                : snapshotTable[indexTable]
                                                            ["table_id"] ==
                                                        null
                                                    ? "Table assigned"
                                                    : "Table changed");
                                          }
                                        }
                                      } else {
                                        assignTable =
                                            snapshot.data[index]["id"];

                                        var response = await assignTableOnline(
                                            snapshotTable[indexTable]
                                                ["sale_id"],
                                            assignTable);
                                        if (response == false) {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                          customToastFlutter(
                                              "Table not assigned Check your internet");
                                        } else if (response ==
                                            "already reserved") {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                          customToastFlutter(
                                              "Table already assigned reopen the dialogue to get the updated status");
                                        } else {
                                          pageDecider = "Dine In Orders";
                                          Navigator.pop(
                                              context, globalRefresh());
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                          if (searchDelegate != "") {
                                            searchDelegate();
                                          }
                                          customToastFlutter(snapshotTable[
                                                              indexTable]
                                                          ["waiter_id"] ==
                                                      null &&
                                                  userResponse["designation"]
                                                          .toString()
                                                          .toLowerCase() ==
                                                      "waiter".toLowerCase()
                                              ? "Table and Waiter both Assigned"
                                              : snapshotTable[indexTable]
                                                          ["table_id"] ==
                                                      null
                                                  ? "Table assigned"
                                                  : "Table changed");
                                        }
                                      }
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: customColor,
                                    child: text(
                                      context,
                                      "Table\n" + snapshot.data[index]["name"],
                                      0.04,
                                      myWhite,
                                      alignText: TextAlign.center,
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return text(context, "not working", 0.028, myWhite);
                          }
                        },
                      );
                    } else {
                      return text(
                        context,
                        "retry",
                        0.04,
                        myWhite,
                      );
                    }
                  } else {
                    return loader(context);
                  }
                }),
          ),
        );
      });
}

dialogueCustomWaiter(
    context, snapshotTable, indexTable, assignTable, function, searchDelegate) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text(context, "Assign Waiter", 0.04, myWhite, bold: true),
                const Icon(
                  Icons.close,
                  color: myWhite,
                )
              ],
            ),
          ),
          backgroundColor: myBlack,
          content: Container(
            color: myBlack,
            height: dynamicHeight(context, 0.6),
            width: dynamicWidth(context, 0.8),
            child: FutureBuilder(
              future: getWaiters(snapshotTable[indexTable]["sale_id"]),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loader(context);
                } else if (snapshot.data == false) {
                  return retry(
                    context,
                  );
                } else if (snapshot.data.length == 0) {
                  return Center(
                      child: text(context, "no Waiters!!", 0.028, myWhite));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async {
                          try {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.loading,
                                barrierDismissible: false,
                                lottieAsset: "assets/loader.json");
                            assignTable = snapshot.data[index]["id"];

                            var response = await assignWaiterOnline(
                                snapshotTable[indexTable]["sale_id"].toString(),
                                assignTable.toString());
                            if (response == "timeOut") {
                              Navigator.of(context, rootNavigator: true).pop();
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text:
                                      "Connection timeout this happens if you are on a slow internet connection",
                                  title: "Slow internet");
                            } else if (response == "internet") {
                              Navigator.of(context, rootNavigator: true).pop();
                              customToastFlutter("No internet");
                            } else if (response == false) {
                              Navigator.of(context, rootNavigator: true).pop();
                              customToastFlutter("Server Error");
                            } else {
                              Navigator.pop(context, function());
                              Navigator.of(context, rootNavigator: true).pop();
                              if (searchDelegate != "") {
                                searchDelegate();
                              }
                              customToastFlutter("Waiter assigned");
                            }
                          } catch (e) {
                            Navigator.of(context, rootNavigator: true).pop();
                            customToastFlutter("Something went wrong");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: myOrange,
                          child: FittedBox(
                            child: Padding(
                              padding:
                                  EdgeInsets.all(dynamicWidth(context, 0.01)),
                              child: text(
                                  context,
                                  snapshot.data[index]["full_name"],
                                  0.04,
                                  myWhite,
                                  alignText: TextAlign.center),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return text(context, "not working", 0.028, myWhite);
                }
              },
            ),
          ),
        );
      });
}
