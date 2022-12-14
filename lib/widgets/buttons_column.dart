import 'package:baranh/app_screens/menu.dart';
import 'package:baranh/app_screens/order_summary_page.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/guest_arrived_function.dart';
import 'package:baranh/widgets/show_alert.dart';
import 'package:baranh/widgets/toast.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import 'green_buttons.dart';

buttonsColumn(context, buttonText1, buttonText2, snapshotTable, indexTable,
    assignTable, function, visibleButton, searchDelegate) {
  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    alignment: WrapAlignment.center,
    runAlignment: WrapAlignment.center,
    spacing: 10,
    runSpacing: 10,
    children: [
      Visibility(
        visible:
            (buttonText1 == "View details" || buttonText2 == "View details") &&
                    visibleButton == true
                ? true
                : false,
        child: greenButtons(context, "Take Order", snapshotTable, indexTable,
            function: () {
          push(
              context,
              MenuPage(
                saleId: snapshotTable[indexTable]["sale_id"].toString(),
                tableNo: snapshotTable[indexTable]["table_id"].toString(),
                tableName: snapshotTable[indexTable]["table_name"],
              ));
        }),
      ),
      greenButtons(context, buttonText1, snapshotTable, indexTable,
          function: () async {
        if (buttonText1 == "View details") {
          push(
              context,
              OrderSummaryPage(
                saleId: snapshotTable[indexTable]["sale_id"].toString(),
                tableName: snapshotTable[indexTable]["table_name"] ?? "",
              ));
        } else if (buttonText1 == "Assign Table") {
          dialogueCustom(context, snapshotTable, indexTable, assignTable,
              function, searchDelegate);
        } else if (buttonText1 == "Assign Waiter") {
          dialogueCustomWaiter(context, snapshotTable, indexTable, assignTable,
              function, searchDelegate);
        } else if (buttonText1 == "Guest Arrived") {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.confirm,
              showCancelBtn: true,
              confirmBtnText: "Yes",
              backgroundColor: myOrange,
              barrierDismissible: false,
              confirmBtnColor: myOrange,
              confirmBtnTextStyle: TextStyle(
                  fontSize: dynamicWidth(context, 0.04), color: myWhite),
              onConfirmBtnTap: () {
                Navigator.of(context, rootNavigator: true).pop();

                guestArrivedNow(
                    context, snapshotTable, indexTable, searchDelegate);
              });
        } else {
          customToastFlutter("Something Went wrong");
        }
      }),
      Visibility(
        visible: userResponse["designation"].toString().toLowerCase() !=
                    "Floor Manager".toLowerCase() &&
                pageDecider == "Dine In Orders"
            ? false
            : visibleButton,
        child: greenButtons(
          context,
          buttonText2,
          snapshotTable,
          indexTable,
          function: () {
            if (buttonText2 == "Assign Waiter") {
              dialogueCustomWaiter(context, snapshotTable, indexTable,
                  assignTable, function, searchDelegate);
            } else if (buttonText2 == "Assign Table" ||
                buttonText2 == "Change Table") {
              dialogueCustom(context, snapshotTable, indexTable, assignTable,
                  function, searchDelegate);
            } else if (buttonText2 == "Take Order") {
              push(
                  context,
                  MenuPage(
                    saleId: snapshotTable[indexTable]["sale_id"].toString(),
                    tableNo: snapshotTable[indexTable]["table_id"].toString(),
                    tableName: snapshotTable[indexTable]["table_name"],
                  ));
            } else if (buttonText2 == "View details") {
              push(
                context,
                OrderSummaryPage(
                    saleId: snapshotTable[indexTable]["sale_id"].toString(),
                    tableName: snapshotTable[indexTable]["table_name"]),
              );
            } else {
              customToastFlutter("Something Went wrong");
            }
          },
        ),
      ),
      Visibility(
        visible: userResponse["designation"].toString().toLowerCase() ==
                    "Floor Manager".toLowerCase() &&
                pageDecider == "Dine In Orders"
            ? visibleButton
            : false,
        child: greenButtons(
          context,
          "Change Waiter",
          snapshotTable,
          indexTable,
          function: () {
            dialogueCustomWaiter(context, snapshotTable, indexTable,
                assignTable, function, searchDelegate);
          },
        ),
      ),
    ],
  );
}
