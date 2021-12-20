import 'package:baranh/app_screens/all_reservations.dart';
import 'package:baranh/app_screens/arrived_guests.dart';
import 'package:baranh/app_screens/dine_in_orders.dart';
import 'package:baranh/app_screens/new_reservations.dart';
import 'package:baranh/app_screens/notifications_page.dart';
import 'package:baranh/app_screens/waiting_for_arrival.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class BasicPage extends StatefulWidget {
  const BasicPage({Key? key}) : super(key: key);

  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> with TickerProviderStateMixin {
  var hintText = "mm/dd/yyy";

  @override
  Widget build(BuildContext context) {
    customContext = context;
    return Scaffold(
      backgroundColor: myBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, 0.05),
          ),
          child: bodyPage(pageDecider),
        ),
      ),
    );
  }

  bodyPage(String page) {
    switch (page) {
      case "All Reservations":
        return const AllReservationsPage();
      case "Waiting For Arrival":
        return const WaitingForArrival();
      case "Arrived Guests":
        return const ArrivedGuest();
      case "Dine In Orders":
        return const DineInOrders();
      case "New Reservations":
        return const NewReservationsPage();
      case "Notifications":
        return const NotificationsPage();

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
