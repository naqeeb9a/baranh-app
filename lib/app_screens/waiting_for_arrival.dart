import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/table_cards.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class WaitingForArrival extends StatefulWidget {
  const WaitingForArrival({Key? key}) : super(key: key);

  @override
  State<WaitingForArrival> createState() => _WaitingForArrivalState();
}

class _WaitingForArrivalState extends State<WaitingForArrival> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, 0.05),
          ),
          child: Column(
            children: [
              heightBox(context, 0.05),
              text(context, "WAITING FOR ARRIVAL GUESTS", 0.05, myWhite),
              const Divider(
                thickness: 1,
                color: myWhite,
              ),
              Expanded(
                child: tableCards(context, getReservationData("dinein-orders"),
                    "Arrived Guests", "View Details", setstate: () {
                  setState(() {});
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
