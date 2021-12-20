import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/input_field_home.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class NewReservationsPage extends StatelessWidget {
  const NewReservationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        inputFieldsHome("Date", hintText, context, check: true),
        heightBox(context, 0.02),
        inputFieldsHome("Time:", "", context),
        heightBox(context, 0.02),
        inputFieldsHome("Seats:", "", context),
        heightBox(context, 0.03),
        coloredButton(context, "CHECK AVAILABILITY", myOrange)
      ],
    );
  }
}
