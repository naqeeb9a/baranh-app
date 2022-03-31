import 'dart:convert';

import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/form_fields.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:baranh/widgets/toast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

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
      var response =
          await http.post(Uri.parse(callBackUrl + "/api/signin-waiter"), body: {
        "email": email.text,
        "password": password.text,
        "token": fireBaseToken,
      });
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

  func() {
    FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        fireBaseToken = value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    func();
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
                          customToastFlutter("Please enter valid email!");
                        } else if (password.text.isEmpty) {
                          customToastFlutter("Please enter valid password!");
                        } else {
                          var response = await loginFunction();

                          if (response == "Error") {
                            setState(() {
                              loading = false;
                            });
                            customToastFlutter("Invalid Credentials");
                          } else if (response == false) {
                            setState(() {
                              loading = false;
                            });
                            customToastFlutter(
                                "Check your Internet or try again later");
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
