import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget inputFieldsHome(text1, hintText1, context, {check = false}) {
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
                      firstDate: DateTime(1999, 1, 1),
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
                            DateFormat.yMMMd().format(newTime).toString();
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
                              hintText: hintText,
                              fillColor: myWhite),
                        ),
                      ),
                      const Icon(Icons.calendar_today_outlined)
                    ],
                  ),
                )
              : TextFormField(
                  decoration: InputDecoration(hintText: hintText1),
                ),
        )
      ],
    );
  });
}
