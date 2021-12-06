import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

import '../utils/config.dart';

Widget coloredButton(context, text, color,
    {function = "", width = "", fontSize = 0.05}) {
  return GestureDetector(
    onTap: function == "" ? () {} : function,
    child: Container(
      width: width == "" ? dynamicWidth(context, 1) : width,
      height: dynamicHeight(context, .056),
      decoration: BoxDecoration(
        color: color,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: myWhite,
            fontWeight: FontWeight.bold,
            fontSize: dynamicWidth(context, fontSize),
          ),
        ),
      ),
    ),
  );
}
