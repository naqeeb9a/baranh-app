import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/input_field_home.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:baranh/widgets/toast.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

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
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const BottomBannerAd(),
      backgroundColor: myBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              heightBox(context, 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    pop(context);
                  },
                  child: const Icon(
                    LineIcons.arrowLeft,
                    color: myWhite,
                  ),
                ),
              ),
              heightBox(context, 0.05),
              text(
                context,
                "CONTACT INFORMATION",
                0.05,
                myWhite,
              ),
              heightBox(context, 0.02),
              inputFieldsHome(
                "Your Name",
                "Enter Your Name",
                context,
                controller: _name,
              ),
              heightBox(context, 0.02),
              inputFieldsHome(
                "Phone",
                "Enter Phone Number",
                context,
                keyBoardType: TextInputType.number,
                controller: _phone,
                generatePasswordCheck: true,
              ),
              heightBox(context, 0.02),
              inputFieldsHome(
                "Address",
                "Enter Address",
                context,
                controller: _address,
              ),
              heightBox(context, 0.02),
              inputFieldsHome(
                "Email",
                "someone@gmail.com",
                context,
                keyBoardType: TextInputType.emailAddress,
                controller: _email,
              ),
              heightBox(context, 0.04),
              coloredButton(context, "Submit", myOrange, function: () async {
                if (_name.text.isEmpty || _phone.text.isEmpty) {
                  customToastFlutter("Fill all fields appropriately");
                } else if (_email.text.isNotEmpty &&
                    !_email.text.contains("@")) {
                  customToastFlutter("Enter a Valid Email");
                } else {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.loading,
                      barrierDismissible: false,
                      lottieAsset: "assets/loader.json");
                  var response = await reserveTable(
                    _name.text,
                    _phone.text,
                    _email.text == "" ? "" : _email.text,
                    widget.seats,
                    widget.date,
                    widget.dropDownTime,
                  );
                  if (response == false) {
                    Navigator.of(context, rootNavigator: true).pop();
                    CoolAlert.show(
                        title: "Server Error or check internet",
                        text: "please Try again",
                        context: context,
                        loopAnimation: true,
                        backgroundColor: myOrange,
                        confirmBtnColor: myOrange,
                        confirmBtnText: "Retry",
                        type: CoolAlertType.error,
                        animType: CoolAlertAnimType.slideInRight);
                  } else {
                    Navigator.of(context, rootNavigator: true).pop();
                    customToastFlutter("Reserved successfully");

                    pageDecider = "Waiting For Arrival";
                    popUntil(customContext);
                  }
                }
              }),
              heightBox(context, 0.04),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    _email.dispose();
    super.dispose();
  }
}
