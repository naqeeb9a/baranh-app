import 'dart:async';

import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/app_screens/contact_information.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/input_field_home.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';

class NewReservationsPage extends StatefulWidget {
  const NewReservationsPage({Key? key}) : super(key: key);

  @override
  State<NewReservationsPage> createState() => _NewReservationsPageState();
}

class _NewReservationsPageState extends State<NewReservationsPage> {
  final TextEditingController _seats = TextEditingController();
  late Timer _timer;
  String indexValue = "";
  dynamic bigArray = [];
  var timeDropDown = "";
  dynamic letsRefresh = "";

  @override
  void dispose() {
    _timer.cancel();
    _seats.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (letsRefresh == "") {
      } else {
        letsRefresh();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const BottomBannerAd(),
      backgroundColor: myBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, 0.05),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                heightBox(context, 0.05),
                text(context, "RESERVATION", 0.05, myWhite),
                const Divider(
                  thickness: 1,
                  color: myWhite,
                ),
                heightBox(context, 0.01),
                text(context, "BARANH", 0.04, myWhite),
                inputFieldsHome("Date", hintText, context,
                    check: true, timeSlot: true, function: () {
                  setState(() {});
                }),
                heightBox(context, 0.02),
                SizedBox(
                  height: dynamicWidth(context, 0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text(
                        context,
                        "Time",
                        0.04,
                        myWhite,
                      ),
                      widthBox(context, 0.1),
                      FutureBuilder(
                        future: getTimeSlots(hintText),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            (snapshot.data == false)
                                ? ""
                                : indexValue = "Select time";
                            if (snapshot.data == false) {
                              return InkWell(
                                onTap: () {
                                  globalRefresh();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.rotate_right_outlined,
                                      color: myOrange,
                                      size: dynamicWidth(context, 0.08),
                                    ),
                                    text(context, "Retry", 0.04, myWhite)
                                  ],
                                ),
                              );
                            } else {
                              return StatefulBuilder(
                                  builder: (context, superState) {
                                letsRefresh = () {
                                  superState(() {});
                                };
                                indexValue = "Select time";
                                var localVariable = false;
                                var counter = 0;
                                for (var item in snapshot.data) {
                                  if ((DateTime.now().minute).toString().length ==
                                          1
                                      ? (double.parse(item["opening_time"]
                                              .toString()
                                              .replaceAll(":", "."))) >=
                                          double.parse(
                                              (DateTime.now().hour).toString() +
                                                  ".0" +
                                                  (DateTime.now().minute)
                                                      .toString())
                                      : (double.parse(item["opening_time"]
                                              .toString()
                                              .replaceAll(":", "."))) >=
                                          double.parse(
                                              (DateTime.now().hour).toString() +
                                                  "." +
                                                  (DateTime.now().minute)
                                                      .toString())) {
                                    if (counter == 0) {
                                      indexValue = getConvertedTime(
                                              item["opening_time"]) +
                                          "  ${item["discount"]} % off" +
                                          "#${item["id"]}#${item["seats"]}#${item["booksum"]}#${item["discount"]}";
                                      counter++;
                                    }
                                  }
                                }
                                return StatefulBuilder(
                                  builder: (BuildContext context, changeSate) {
                                    return SizedBox(
                                      width: dynamicWidth(context, 0.4),
                                      child: DropdownButton<String>(
                                        hint: text(
                                          context,
                                          indexValue == "Select time"
                                              ? indexValue
                                              : localVariable == false
                                                  ? indexValue.substring(0,
                                                      indexValue.indexOf("#"))
                                                  : indexValue.substring(0,
                                                      indexValue.indexOf("#")),
                                          0.04,
                                          myWhite,
                                        ),
                                        items: snapshot.data
                                            .map<DropdownMenuItem<String>>(
                                                (value) {
                                          if ((DateTime.now().minute).toString().length == 1
                                              ? (double.parse(value["opening_time"]
                                                      .toString()
                                                      .replaceAll(":", "."))) >=
                                                  double.parse((DateTime.now().hour).toString() +
                                                      "." +
                                                      (DateTime.now().minute)
                                                          .toString())
                                              : (double.parse(value["opening_time"]
                                                      .toString()
                                                      .replaceAll(":", "."))) >=
                                                  double.parse((DateTime.now().hour)
                                                          .toString() +
                                                      "." +
                                                      (DateTime.now().minute).toString())) {
                                            return DropdownMenuItem<String>(
                                              value: getConvertedTime(
                                                      value["opening_time"]) +
                                                  "  ${value["discount"]} % off" +
                                                  "#${value["id"]}#${value["seats"]}#${value["booksum"]}#${value["discount"]}",
                                              child: Text(getConvertedTime(
                                                      value["opening_time"]) +
                                                  "  ${value["discount"]} % off"),
                                            );
                                          } else {
                                            return DropdownMenuItem<String>(
                                              value: getConvertedTime(
                                                      value["opening_time"]) +
                                                  "  ${value["discount"]} % off" +
                                                  "#${value["id"]}#${value["seats"]}#${value["booksum"]}#${value["discount"]}",
                                              child: Text(
                                                getConvertedTime(
                                                        value["opening_time"]) +
                                                    "  ${value["discount"]} % off",
                                                style: const TextStyle(
                                                    color: myGrey),
                                              ),
                                              enabled: false,
                                            );
                                          }
                                        }).toList(),
                                        onChanged: (value) {
                                          changeSate(() {
                                            localVariable = true;
                                            indexValue = value!;
                                          });
                                        },
                                      ),
                                    );
                                  },
                                );
                              });
                            }
                          } else {
                            return LottieBuilder.asset(
                              "assets/loader.json",
                              width: dynamicWidth(context, 0.3),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                heightBox(context, hintText == "mm/dd/yyyy" ? 0 : 0.02),
                inputFieldsHome(
                  "Seats:",
                  "",
                  context,
                  keyBoardType: TextInputType.number,
                  controller: _seats,
                ),
                heightBox(context, 0.03),
                coloredButton(context, "CHECK AVAILABILITY", myOrange,
                    function: () async {
                  if (_seats.text.isEmpty ||
                      hintText == "mm/dd/yyyy" ||
                      indexValue == "Select time") {
                    MotionToast.info(
                      description: "check provided seats or dates",
                      dismissable: true,
                    ).show(context);
                  } else {
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.loading,
                        barrierDismissible: false,
                        lottieAsset: "assets/loader.json");
                    var response = await checkAvailability(
                        hintText,
                        indexValue.substring(indexValue.indexOf("#") + 1),
                        _seats.text);
                    if (response == true) {
                      Navigator.of(context, rootNavigator: true).pop();
                      CoolAlert.show(
                          onConfirmBtnTap: () {
                            Navigator.of(context, rootNavigator: true).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactInformation(
                                          dropDownTime: indexValue.substring(
                                              indexValue.indexOf("#") + 1),
                                          seats: _seats.text,
                                          date: hintText,
                                        ))).then((value) => globalRefresh());
                          },
                          title: "Slots Available",
                          text: "Do you wish to proceed?",
                          context: context,
                          loopAnimation: true,
                          backgroundColor: myOrange,
                          confirmBtnColor: myOrange,
                          confirmBtnText: "Continue",
                          confirmBtnTextStyle: TextStyle(
                              fontSize: dynamicWidth(context, 0.04),
                              color: myWhite),
                          type: CoolAlertType.confirm,
                          animType: CoolAlertAnimType.slideInRight);
                    } else if (response == false) {
                      Navigator.of(context, rootNavigator: true).pop();
                      MotionToast.error(
                        description:
                            "Slots are not available try again after some time",
                        dismissable: true,
                      ).show(context);
                    } else if (response == "internet") {
                      Navigator.of(context, rootNavigator: true).pop();
                      MotionToast.warning(
                        description: "Check your internet",
                        dismissable: true,
                      );
                    } else {
                      Navigator.of(context, rootNavigator: true).pop();
                      CoolAlert.show(
                        title: "Server Error",
                        text: "please Try again",
                        context: context,
                        loopAnimation: true,
                        backgroundColor: myOrange,
                        confirmBtnColor: myOrange,
                        confirmBtnText: "Retry",
                        type: CoolAlertType.error,
                        animType: CoolAlertAnimType.slideInRight,
                      );
                    }
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

getConvertedTime(String time) {
  if (time == "not provided") {
    return "Not Provided";
  }
  var parsedTime = int.parse(time.substring(0, time.length - 3));
  if (parsedTime > 12) {
    return (parsedTime - 12) >= 10
        ? (parsedTime - 12).toString() + time.substring(2) + " pm"
        : "0" + (parsedTime - 12).toString() + time.substring(2) + " pm";
  } else if (parsedTime == 12) {
    return "12" + time.substring(2) + " pm";
  } else if (parsedTime == 00) {
    return "12" + time.substring(2) + " am";
  } else {
    return time + " am";
  }
}
