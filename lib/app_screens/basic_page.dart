import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/drawer.dart';
import 'package:baranh/widgets/essential_widgets.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BasicPage extends StatefulWidget {
  const BasicPage({Key? key}) : super(key: key);

  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {
  var hintText = "mm/dd/yy";
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: myBlack,
      appBar: bar(
        context,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      drawer: SafeArea(
        child: Drawer(
          child: drawerItems(context, () {
            setState(() {});
          }),
        ),
      ),
      endDrawer: SafeArea(
        child: Drawer(
          child: drawerItems(context, () {
            setState(() {});
          }),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, 0.1),
          ),
          child: bodyPage(pageDecider),
        ),
      ),
    );
  }

  Widget allReservationsPage() {
    return Column(
      children: [
        heightBox(context, 0.05),
        text(context, "ALL RESERVATIONS", 0.05, myWhite),
        const Divider(
          thickness: 1,
          color: myWhite,
        ),
        heightBox(context, 0.02),
        inputFieldsHome("Reservation Number:", "Ex:Res.00042"),
        heightBox(context, 0.02),
        inputFieldsHome("Select Date:", hintText, check: true),
        heightBox(context, 0.04),
        coloredButton(context, "SEARCH", myOrange, fontSize: 0.042)
      ],
    );
  }

  Widget inputFieldsHome(text1, hintText1, {check = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(context, text1, 0.04, myWhite),
        heightBox(context, .01),
        Container(
          color: myWhite,
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, 0.04),
          ),
          child: (check == true)
              ? InkWell(
                  onTap: () async {
                    var newTime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1999, 1, 1),
                      lastDate: DateTime(2999, 1, 1),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: myBlack,
                            colorScheme:
                                const ColorScheme.light(primary: myOrange),
                            buttonTheme: const ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (newTime != null) {
                      setState(() {
                        hintText =
                            DateFormat.yMMMd().format(newTime).toString();
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: dynamicWidth(context, 0.5),
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: hintText,
                              fillColor: myWhite),
                        ),
                      ),
                      const Icon(Icons.calendar_today_outlined)
                    ],
                  ),
                )
              : TextFormField(
                  decoration: InputDecoration(hintText: hintText1),
                ),
        )
      ],
    );
  }

  Widget notificationsPage() {
    return Column(
      children: [
        heightBox(context, 0.05),
        text(context, "Notifications", 0.05, myWhite),
        const Divider(
          thickness: 1,
          color: myWhite,
        ),
        heightBox(context, 0.03),
        Align(
            alignment: Alignment.centerLeft,
            child: text(context, "Nothing Found!!", 0.04, myWhite))
      ],
    );
  }

  Widget newReservationPage() {
    hintText = "mm/dd/yyyy";
    return Column(
      children: [
        heightBox(context, 0.05),
        text(context, "RESERVATION", 0.05, myWhite),
        const Divider(
          thickness: 1,
          color: myWhite,
        ),
        heightBox(context, 0.01),
        text(context, "BARANH LAHORE", 0.04, myWhite),
        inputFieldsHome("Date", hintText, check: true),
        heightBox(context, 0.02),
        inputFieldsHome("Time:", ""),
        heightBox(context, 0.02),
        inputFieldsHome("Seats:", ""),
        heightBox(context, 0.03),
        coloredButton(context, "CHECK AVAILABILITY", myOrange)
      ],
    );
  }

  Widget dineInOrdersPage() {
    return Column(
      children: [
        heightBox(context, 0.05),
        text(context, "DINE IN ORDERS", 0.05, myWhite),
        const Divider(
          thickness: 1,
          color: myWhite,
        ),
        heightBox(context, 0.02),
        inputFieldsHome("Table Number:", "Ex:42"),
        heightBox(context, 0.03),
        coloredButton(context, "SEARCH", myOrange)
      ],
    );
  }

  Widget arrivedGuestPage() {
    return Column(
      children: [
        heightBox(context, 0.05),
        text(context, "ARRIVED GUESTS", 0.05, myWhite),
        const Divider(
          thickness: 1,
          color: myWhite,
        ),
      ],
    );
  }

  Widget waitingForArrival() {
    return Column(
      children: [
        heightBox(context, 0.05),
        text(context, "WAITING FOR ARRIVAL GUESTS", 0.05, myWhite),
        const Divider(
          thickness: 1,
          color: myWhite,
        ),
      ],
    );
  }

  bodyPage(String page) {
    switch (page) {
      case "All Reservations":
        return allReservationsPage();
      case "Waiting For Arrival":
        return waitingForArrival();
      case "Arrived Guests":
        return arrivedGuestPage();
      case "Dine In Orders":
        return dineInOrdersPage();
      case "New Reservations":
        return newReservationPage();
      case "Notifications":
        return notificationsPage();

      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            text(context, "error", .06, myWhite),
          ],
        );
    }
  }
}
