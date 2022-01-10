import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/input_field_home.dart';
import 'package:baranh/widgets/table_cards.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AllReservationsPage extends StatelessWidget {
  const AllReservationsPage({Key? key}) : super(key: key);

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
              text(context, "ALL RESERVATIONS", 0.05, myWhite),
              const Divider(
                thickness: 1,
                color: myWhite,
              ),
              heightBox(context, 0.02),
              inputFieldsHome("Reservation Number:", "Ex:Res.00042", context, keyBoardType: TextInputType.number),
              heightBox(context, 0.02),
              inputFieldsHome("Select Date:", hintText, context, check: true),
              heightBox(context, 0.04),
              coloredButton(context, "SEARCH", myOrange, fontSize: 0.042),
              heightBox(context, 0.02),
              Expanded(
                child: tableCards(
                  context,
                  getReservationData("reservelist"),
                  "Guest Arrived",
                  "View Details",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
