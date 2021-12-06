import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/form_fields.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: dynamicWidth(context, .9),
            height: dynamicHeight(context, .6),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  text(
                    context,
                    "TEAM LOGIN",
                    .08,
                    myWhite,
                    bold: true,
                  ),
                  heightBox(context, .08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      text(context, "Email", .05, myWhite),
                    ],
                  ),
                  heightBox(context, .01),
                  inputTextField(
                    context,
                    "Email",
                    email,
                    function: (value) {
                      if (EmailValidator.validate(value)) {
                      } else {
                        return "Enter Valid Email";
                      }
                      return null;
                    },
                  ),
                  heightBox(context, .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      text(context, "Password", .05, myWhite),
                    ],
                  ),
                  heightBox(context, .01),
                  inputTextField(
                    context,
                    "Password",
                    password,
                    password: true,
                    function: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return 'Password must have 8 characters';
                      }
                      return null;
                    },
                    function2: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                  heightBox(context, .01),
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .01),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          text(context, "Reset Your Password", .04, myWhite),
                        ],
                      ),
                    ),
                  ),
                  heightBox(context, .04),
                  coloredButton(context, "SIGN IN", myOrange, function: () {
                    if (!_formKey.currentState!.validate()) {
                      push(context, const Home());
                      // return;
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
