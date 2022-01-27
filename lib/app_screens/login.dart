import 'dart:convert';

import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/form_fields.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();

  loginFunction() async {
    try {
      setState(() {
        loading = true;
      });
      var response = await http.post(Uri.parse(callBackUrl+"/api/signin-waiter"),
          body: {"email": email.text, "password": password.text});
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        return jsonData["data"];
      } else {
        return "Error";
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: (loading == true)
          ? Center(
              child: LottieBuilder.asset(
                "assets/loader.json",
                width: dynamicWidth(context, 0.3),
              ),
            )
          : Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        width: dynamicWidth(context, 0.3),
                      ),
                      text(
                        context,
                        "TEAM LOGIN",
                        .08,
                        myWhite,
                        bold: true,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(context, "Email", .05, myWhite),
                          heightBox(context, .01),
                          inputTextField(
                            context,
                            "Email",
                            email,
                          ),
                          heightBox(context, .02),
                          text(context, "Password", .05, myWhite),
                          heightBox(context, .01),
                          inputTextField(
                            context,
                            "Password",
                            password,
                            password: true,
                            function2: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                        ],
                      ),
                      coloredButton(context, "SIGN IN", myOrange,
                          function: () async {
                        if (!EmailValidator.validate(email.text)) {
                          MotionToast.error(
                            title: "Error",
                            dismissable: true,
                            titleStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            description: "Please enter valid email!",
                          ).show(context);
                        } else if (password.text.isEmpty) {
                          MotionToast.error(
                            title: "Error",
                            dismissable: true,
                            titleStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            description: "Please enter valid password!",
                          ).show(context);
                        } else {
                          var response = await loginFunction();

                          if (response == "Error") {
                            setState(() {
                              loading = false;
                            });
                            MotionToast.error(
                              title: "Error",
                              dismissable: true,
                              titleStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              description: "Invalid Credentials",
                            ).show(context);
                          } else if (response == false) {
                            setState(() {
                              loading = false;
                            });
                            MotionToast.error(
                              title: "Error",
                              dismissable: true,
                              titleStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              description:
                                  "Check your Internet or try again later",
                            ).show(context);
                          } else {
                            SharedPreferences loginUser =
                                await SharedPreferences.getInstance();
                            loginUser.setString(
                              "userResponse",
                              json.encode(response),
                            );
                            setState(() {
                              pageDecider = "New Reservations";
                            });
                            pushAndRemoveUntil(
                              context,
                              const MyApp(),
                            );
                          }
                        }
                      }),
                      heightBox(context, .04),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
