import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/input_field_home.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

class CallBackUrl extends StatefulWidget {
  const CallBackUrl({Key? key}) : super(key: key);

  @override
  State<CallBackUrl> createState() => _CallBackUrlState();
}

class _CallBackUrlState extends State<CallBackUrl> {
  final TextEditingController callBackUrlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
        child: Column(
          children: [
            heightBox(context, 0.05),
            text(context, "Call Back Url", 0.05, myWhite),
            const Divider(
              thickness: 1,
              color: myWhite,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  inputFieldsHome(
                    "Callback Url:",
                    "https://baranhweb.cmcmtech.com/api/",
                    context,
                    controller: callBackUrlController,
                  ),
                  heightBox(context, 0.02),
                  coloredButton(context, "Change", myOrange, function: () {
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.confirm,
                        backgroundColor: myOrange,
                        onConfirmBtnTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          callBackUrl = callBackUrlController.text;
                          pageDecider = "New Reservations";
                          globalRefresh();
                        });
                  }),
                  heightBox(context, 0.02),
                  coloredButton(context, "Reset Url", myOrange, function: () {
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.confirm,
                        backgroundColor: myOrange,
                        onConfirmBtnTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          callBackUrl = "https://baranhweb.cmcmtech.com/api/";
                          pageDecider = "New Reservations";
                          globalRefresh();
                        });
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    callBackUrlController.dispose();
    super.dispose();
  }
}
