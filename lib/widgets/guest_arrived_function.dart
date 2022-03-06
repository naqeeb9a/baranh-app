import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/config.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

guestArrivedNow(context, snapshotTable, indexTable, searchDelegate) async {
  CoolAlert.show(
      context: context,
      type: CoolAlertType.loading,
      barrierDismissible: false,
      lottieAsset: "assets/loader.json");
  var response = await arrivedGuests(snapshotTable[indexTable]["sale_id"]);
  if (response == false) {
    Navigator.of(context, rootNavigator: true).pop();
    CoolAlert.show(
        context: context,
        text: "There is some problem in Internet or the Server",
        confirmBtnText: "Retry",
        type: CoolAlertType.error,
        backgroundColor: myOrange,
        confirmBtnColor: myOrange);
  } else if (response == "cancelled") {
    Navigator.of(context, rootNavigator: true).pop();
    CoolAlert.show(
      context: context,
      text: "Reservation cancelled because the guest was not on time",
      confirmBtnText: "Book again",
      cancelBtnText: "Book later",
      type: CoolAlertType.error,
      barrierDismissible: false,
      showCancelBtn: true,
      onConfirmBtnTap: () {
        pageDecider = "New Reservations";
        globalRefresh();
        Navigator.of(context, rootNavigator: true).pop();
        if (searchDelegate != "") {
          searchDelegate();
        }
      },
      onCancelBtnTap: () {
        globalRefresh();
        Navigator.of(context, rootNavigator: true).pop();
        if (searchDelegate != "") {
          searchDelegate();
        }
      },
      backgroundColor: myOrange,
      confirmBtnColor: myOrange,
    );
  } else {
    Navigator.of(context, rootNavigator: true).pop();
    CoolAlert.show(
      context: context,
      text: "Guest Arrived Successfully",
      confirmBtnText: "continue",
      cancelBtnText: "Cancel",
      type: CoolAlertType.success,
      barrierDismissible: false,
      onConfirmBtnTap: () {
        pageDecider = "Arrived Guests";
        globalRefresh();
        Navigator.of(context, rootNavigator: true).pop();
        if (searchDelegate != "") {
          searchDelegate();
        }
      },
      backgroundColor: myOrange,
      confirmBtnColor: myOrange,
    );
  }
}
