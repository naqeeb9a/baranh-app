import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

Widget text(context, text, size, color, {bold = false}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: dynamicWidth(context, size),
      fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
    ),
  );
}
