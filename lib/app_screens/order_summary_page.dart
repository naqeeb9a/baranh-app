import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/essential_widgets.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class OrderSummaryPage extends StatelessWidget {
  final String saleId;

  const OrderSummaryPage({Key? key, required this.saleId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
        child: Column(
          children: [
            heightBox(context, 0.02),
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  pop(context);
                },
                child: const Icon(
                  LineIcons.arrowLeft,
                  color: myWhite,
                ),
              ),
            ),
            heightBox(context, 0.02),
            FutureBuilder(
              future: getOrderSummary(saleId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null ||
                      snapshot.data[0]["message"] == "Nothing found!") {
                    return Expanded(
                      child: Center(
                        child: text(context, "No details", 0.04, Colors.white),
                      ),
                    );
                  } else if (snapshot.data == false) {
                    return Center(
                      child: text(
                          context,
                          "Server error or check your internet",
                          0.04,
                          Colors.white),
                    );
                  } else {
                    return orderDetails(context, snapshot.data);
                  }
                } else {
                  return Expanded(child: loader(context));
                }
              },
            ),
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

orderDetails(context, snapshot) {
  return Column(
    children: [
      heightBox(context, 0.05),
      text(context, "ORDER DETAILS #" + snapshot[0]["sale_no"], 0.05, myWhite),
      const Divider(
        thickness: 1,
        color: myWhite,
      ),
      heightBox(context, 0.05),
      (snapshot[0]["sale_details"].length == 0)
          ? text(
              context,
              "No items ordered yet!",
              0.04,
              myWhite,
            )
          : SizedBox(
              width: dynamicWidth(context, 1),
              height: dynamicWidth(context, 0.2),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot[0]["sale_details"].length,
                itemBuilder: (BuildContext context, int index) {
                  return viewOrderCard(
                      context, snapshot[0]["sale_details"], index);
                },
              ),
            ),
      heightBox(context, 0.02),
      billRow(context, "Product", "Total", 0.03, myWhite),
      billRow(context, "Subtotal", "PKR " + snapshot[0]["sub_total"], 0.03,
          myWhite),
      billRow(context, "Discount", snapshot[0]["sub_total_discount_value"],
          0.03, myWhite),
      billRow(context, "GST", "PKR 0.00", 0.03, myWhite),
      billRow(context, "Total", "PKR " + snapshot[0]["sub_total_with_discount"],
          0.03, myWhite),
      billRow(context, "Paid", "PKR " + snapshot[0]["paid_amount"].toString(),
          0.03, myWhite),
    ],
  );
}

viewOrderCard(context, snapshot, index) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.01)),
    width: dynamicWidth(context, 0.3),
    decoration: BoxDecoration(
      color: myOrange,
      borderRadius: BorderRadius.circular(
        dynamicWidth(context, 0.02),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, 0.02),
          ),
          child: text(
              context, snapshot[index]["menu_name"].toString(), 0.03, myWhite,
              alignText: TextAlign.center),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.02)),
          child: text(
            context,
            "Rs ." +
                snapshot[index]["menu_unit_price"] +
                " x " +
                snapshot[index]["qty"].toString(),
            0.03,
            myWhite,
          ),
        ),
      ],
    ),
  );
}
