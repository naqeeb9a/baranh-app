import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

bar(context, {function = ""}) {
  return AppBar(
    backgroundColor: myBlack,
    title: Center(
      child: Image.asset(
        "assets/logo.png",
        width: dynamicWidth(context, 0.2),
      ),
    ),
    actions: [
      InkWell(
        onTap: () {
          popUntil(context);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, .02),
          ),
          child: const Icon(Icons.logout),
        ),
      ),
      InkWell(
        onTap: function == "" ? () {} : function,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, .02),
          ),
          child: const Icon(Icons.shopping_cart_outlined),
        ),
      ),
      widthBox(context, 0.01)
    ],
    bottom: PreferredSize(
        child: Container(
          color: myWhite.withOpacity(0.5),
          height: 1,
        ),
        preferredSize: const Size.fromHeight(4.0)),
  );
}
