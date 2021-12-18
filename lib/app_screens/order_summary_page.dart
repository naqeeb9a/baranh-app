import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
        child: Column(
          children: [
            heightBox(context, 0.05),
            text(context, "ORDER DETAILS #009851", 0.05, myWhite),
            const Divider(
              thickness: 1,
              color: myWhite,
            ),
            heightBox(context, 0.02),
            billRow(context, "Product", "Total", 0.03, myWhite),
            billRow(context, "Subtotal", "PKR 0.00", 0.03, myWhite),
            billRow(context, "Discount", "0%", 0.03, myWhite),
            billRow(context, "GST", "PKR 0.00", 0.03, myWhite),
            billRow(context, "Total", "PKR 0.00", 0.03, myWhite),
            billRow(context, "Paid", "PKR", 0.03, myWhite),
            heightBox(context, 0.02),
            coloredButton(context, "Update Kitchen Items", myGreen,
                fontSize: 0.035),
            heightBox(context, 0.01),
            coloredButton(context, "Checkout", myGreen, fontSize: 0.035),
          ],
        ),
      ),
    );
  }
}

billRow(context, text1, text2, size, color) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(context, text1, size, color),
          text(context, text2, size, color),
        ],
      ),
      const Divider(
        thickness: 1,
        color: myWhite,
      )
    ],
  );
}
