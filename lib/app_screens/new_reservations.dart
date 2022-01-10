import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/app_screens/contact_information.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/essential_widgets.dart';
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
  bool loading = false;
  String indexValue = "";
  dynamic bigArray = [];
  var timeDropDown = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: (loading == true)
          ? loader(context)
          : SafeArea(
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
                      text(context, "BARANH LAHORE", 0.04, myWhite),
                      inputFieldsHome("Date", hintText, context,
                          check: true, timeSlot: true, function: () {
                        setState(() {});
                      }),
                      heightBox(context, 0.02),
                      hintText == "mm/dd/yyyy"
                          ? Container()
                          : SizedBox(
                              height: dynamicHeight(context, 0.1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  text(context, "Time", 0.04, Colors.white),
                                  FutureBuilder(
                                    future: getTimeSlots("1", hintText),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        (snapshot.data == false)
                                            ? ""
                                            : indexValue = snapshot.data[0]
                                                    ["opening_time"] +
                                                " - " +
                                                snapshot.data[0]
                                                    ["closing_time"] +
                                                "  ${snapshot.data[0]["discount"]} % off" +
                                                "#${snapshot.data[0]["id"]}#${snapshot.data[0]["seats"]}#${snapshot.data[0]["booksum"]}#${snapshot.data[0]["discount"]}";
                                        return (snapshot.data == false)
                                            ? text(context, "Server Error",
                                                0.04, Colors.red)
                                            : StatefulBuilder(
                                                builder: (BuildContext context,
                                                    changeSate) {
                                                  return DropdownButton<String>(
                                                    hint: text(
                                                        context,
                                                        indexValue.substring(
                                                            0,
                                                            indexValue
                                                                .indexOf("#")),
                                                        0.04,
                                                        Colors.white),
                                                    items: snapshot.data
                                                        .map<
                                                                DropdownMenuItem<
                                                                    String>>(
                                                            (value) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value: value[
                                                                          "opening_time"] +
                                                                      " - " +
                                                                      value[
                                                                          "closing_time"] +
                                                                      "  ${value["discount"]} % off" +
                                                                      "#${value["id"]}#${value["seats"]}#${value["booksum"]}#${value["discount"]}",
                                                                  child: Text(value[
                                                                          "opening_time"] +
                                                                      " - " +
                                                                      value[
                                                                          "closing_time"] +
                                                                      "  ${value["discount"]} % off"),
                                                                ))
                                                        .toList(),
                                                    onChanged: (value) {
                                                      changeSate(() {
                                                        indexValue = value!;
                                                      });
                                                    },
                                                  );
                                                },
                                              );
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
                      inputFieldsHome("Seats:", "", context,
                          keyBoardType: TextInputType.number,
                          controller: _seats),
                      heightBox(context, 0.03),
                      coloredButton(context, "CHECK AVAILABILITY", myOrange,
                          function: () async {
                        if (_seats.text.isEmpty || hintText == "mm/dd/yyyy") {
                          MotionToast.info(
                            description: "check provided seats or dates",
                            dismissable: true,
                          ).show(context);
                        } else {
                          setState(() {
                            loading = true;
                          });
                          var response = await checkAvailability(
                              hintText,
                              indexValue.substring(indexValue.indexOf("#") + 1),
                              _seats.text);
                          if (response == true) {
                            setState(() {
                              loading = false;
                            });
                            CoolAlert.show(
                                onConfirmBtnTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  push(
                                      context,
                                      ContactInformation(
                                        dropDownTime: indexValue.substring(
                                            indexValue.indexOf("#") + 1),
                                        seats: _seats.text,
                                        date: hintText,
                                      ));
                                },
                                title: "Slots Available",
                                text: "Do you wish to proceed?",
                                context: context,
                                loopAnimation: true,
                                backgroundColor: myOrange,
                                confirmBtnColor: myOrange,
                                confirmBtnText: "Continue",
                                type: CoolAlertType.confirm,
                                animType: CoolAlertAnimType.slideInRight);
                          } else if (response == false) {
                            setState(() {
                              loading = false;
                            });
                            MotionToast.error(
                              description:
                                  "Slots are not available try again after some time",
                              dismissable: true,
                            );
                          } else if (response == "internet") {
                            setState(() {
                              loading = false;
                            });
                            MotionToast.warning(
                              description: "Check your internet",
                              dismissable: true,
                            );
                          } else {
                            setState(() {
                              loading = false;
                            });
                            CoolAlert.show(
                                title: "Server Error",
                                text: "please Try again",
                                context: context,
                                loopAnimation: true,
                                backgroundColor: myOrange,
                                confirmBtnColor: myOrange,
                                confirmBtnText: "Retry",
                                type: CoolAlertType.error,
                                animType: CoolAlertAnimType.slideInRight);
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
