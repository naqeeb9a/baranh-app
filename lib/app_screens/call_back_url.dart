import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/input_field_home.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      // bottomNavigationBar: const BottomBannerAd(),
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
                    "https://example.com",
                    context,
                    controller: callBackUrlController,
                  ),
                  heightBox(context, 0.02),
                  coloredButton(context, "Change", myOrange, function: () {
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.confirm,
                        backgroundColor: myOrange,
                        onConfirmBtnTap: () async {
                          SharedPreferences callBackUrlStored =
                              await SharedPreferences.getInstance();
                          Navigator.of(context, rootNavigator: true).pop();
                          callBackUrl = callBackUrlController.text;
                          callBackUrlStored.setString(
                              "SavedUrl", callBackUrlController.text);
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
                        onConfirmBtnTap: () async {
                          Navigator.of(context, rootNavigator: true).pop();
                          SharedPreferences callBackUrlStored =
                              await SharedPreferences.getInstance();
                          callBackUrl = callBackUrlController.text;
                          callBackUrlStored.setString(
                              "SavedUrl", "https://baranh.pk");
                          callBackUrl = "https://baranh.pk";
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
