import 'package:baranh/app_screens/basic_page.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/form_fields.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

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
                    if (!EmailValidator.validate(email.text)) {
                      MotionToast.error(
                        title: "Error",
                        titleStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        description: "Please enter valid email!",
                      ).show(context);
                    } else if (password.text.isEmpty ||
                        password.text.length < 8) {
                      MotionToast.error(
                        title: "Error",
                        titleStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        description: "Please enter valid password!",
                      ).show(context);
                    } else if (EmailValidator.validate(email.text) &&
                        password.text.length >= 8) {
                      push(context, const BasicPage());
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
