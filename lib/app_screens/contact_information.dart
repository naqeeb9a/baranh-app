import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/input_field_home.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ContactInformation extends StatelessWidget {
  const ContactInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              heightBox(context, 0.05),
              text(context, "CONTACT INFORMATION", 0.05, Colors.white),
              heightBox(context, 0.02),
              inputFieldsHome("Your Name", "Enter Your Name", context),
              heightBox(context, 0.02),
              inputFieldsHome("Phone", "Enter Phone Number", context,
                  generatePasswordCheck: true),
              heightBox(context, 0.02),
              inputFieldsHome("Address", "Enter Address", context),
              heightBox(context, 0.02),
              inputFieldsHome("Email", "someone@gmail.com", context),
              heightBox(context, 0.04),
              coloredButton(context, "Submit", myOrange, function: () {
                pageDecider = "All Reservations";
                popUntil(customContext);
              })
            ],
          ),
        ),
      ),
    );
  }
}
