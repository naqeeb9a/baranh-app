import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/essential_widgets.dart';
import 'package:baranh/widgets/input_field_home.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class ContactInformation extends StatefulWidget {
  final String seats, dropDownTime, date;

  const ContactInformation(
      {Key? key,
      required this.seats,
      required this.dropDownTime,
      required this.date})
      : super(key: key);

  @override
  State<ContactInformation> createState() => _ContactInformationState();
}

class _ContactInformationState extends State<ContactInformation> {
  dynamic loading = false;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _name = TextEditingController();
    final TextEditingController _password = TextEditingController();
    final TextEditingController _address = TextEditingController();
    final TextEditingController _email = TextEditingController();
    return Scaffold(
      backgroundColor: myBlack,
      body: (loading == true)
          ? loader(context)
          : Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    heightBox(context, 0.05),
                    text(context, "CONTACT INFORMATION", 0.05, Colors.white),
                    heightBox(context, 0.02),
                    inputFieldsHome("Your Name", "Enter Your Name", context,
                        controller: _name),
                    heightBox(context, 0.02),
                    inputFieldsHome("Phone", "Enter Phone Number", context,
                        controller: _password, generatePasswordCheck: true),
                    heightBox(context, 0.02),
                    inputFieldsHome("Address", "Enter Address", context,
                        controller: _address),
                    heightBox(context, 0.02),
                    inputFieldsHome("Email", "someone@gmail.com", context,
                        controller: _email),
                    heightBox(context, 0.04),
                    coloredButton(context, "Submit", myOrange,
                        function: () async {
                      if (_name.text.isEmpty ||
                          _password.text.isEmpty ||
                          _address.text.isEmpty ||
                          _email.text.isEmpty) {
                        MotionToast.info(
                          description: "Fill all fields appropriately",
                          dismissable: true,
                        ).show(context);
                      } else {
                        setState(() {
                          loading = true;
                        });
                        var response = await reserveTable(
                            _name.text,
                            _password.text,
                            _email.text,
                            widget.seats,
                            widget.date,
                            widget.dropDownTime);
                        if (response == false) {
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
                        } else {
                          setState(() {
                            loading = false;
                          });
                          pageDecider = "All Reservations";
                          popUntil(customContext);
                        }
                      }
                    })
                  ],
                ),
              ),
            ),
    );
  }
}
