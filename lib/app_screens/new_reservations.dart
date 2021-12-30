import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/app_screens/contact_information.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/input_field_home.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NewReservationsPage extends StatefulWidget {
  const NewReservationsPage({Key? key}) : super(key: key);

  @override
  State<NewReservationsPage> createState() => _NewReservationsPageState();
}

class _NewReservationsPageState extends State<NewReservationsPage> {
  bool loading = false;
  String indexValue = "";
  dynamic bigArray = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text(context, "Time", 0.04, Colors.white),
                            FutureBuilder(
                              future: getTimeSlots("1", hintText),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  indexValue = snapshot.data[0]
                                          ["opening_time"] +
                                      " - " +
                                      snapshot.data[0]["closing_time"];
                                  return (snapshot.data == false)
                                      ? text(context, "Server Error", 0.04,
                                          Colors.red)
                                      : StatefulBuilder(
                                          builder: (BuildContext context,
                                              changeSate) {
                                            return DropdownButton<String>(
                                              hint: text(context, indexValue,
                                                  0.04, Colors.white),
                                              items: snapshot.data
                                                  .map<
                                                      DropdownMenuItem<
                                                          String>>((value) =>
                                                      DropdownMenuItem<String>(
                                                        value: value[
                                                                "opening_time"] +
                                                            " - " +
                                                            value[
                                                                "closing_time"],
                                                        child: Text(value[
                                                                "opening_time"] +
                                                            " - " +
                                                            value[
                                                                "closing_time"]),
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
                inputFieldsHome("Seats:", "", context),
                heightBox(context, 0.03),
                coloredButton(context, "CHECK AVAILABILITY", myOrange,
                    function: () {
                  checkAvailibility();

                  CoolAlert.show(
                      onConfirmBtnTap: () {
                        push(context, const ContactInformation());
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
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

checkAvailibility() {}
