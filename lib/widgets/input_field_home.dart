import 'dart:math';

import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget inputFieldsHome(
  text1,
  hintText1,
  context, {
  check = false,
  generatePasswordCheck = false,
  timeSlot = false,
  function = "",
  keyBoardType = TextInputType.text,
}) {
  final TextEditingController _password = TextEditingController();
  return StatefulBuilder(builder: (context, changeState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(context, text1, 0.04, myWhite),
        heightBox(context, .01),
        Container(
          color: myWhite,
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, 0.04),
          ),
          child: (check == true)
              ? InkWell(
                  onTap: () async {
                    var newTime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2999, 1, 1),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: myBlack,
                            colorScheme:
                                const ColorScheme.light(primary: myOrange),
                            buttonTheme: const ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (newTime != null) {
                      changeState(() {
                        hintText =
                            DateFormat('yyyy-MM-dd').format(newTime).toString();
                        function();
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: dynamicWidth(context, 0.5),
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: hintText.toString(),
                              fillColor: myWhite),
                        ),
                      ),
                      const Icon(Icons.calendar_today_outlined)
                    ],
                  ),
                )
              : generatePasswordCheck == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _password,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: hintText1,
                            ),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              var rng = Random();
                              _password.text = rng.nextInt(9999999).toString();
                            },
                            child: const Icon(Icons.rotate_left))
                      ],
                    )
                  : TextFormField(
                      keyboardType: keyBoardType,
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: hintText1),
                    ),
        )
      ],
    );
  });
}
