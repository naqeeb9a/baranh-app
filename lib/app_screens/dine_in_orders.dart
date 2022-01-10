import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/input_field_home.dart';
import 'package:baranh/widgets/table_cards.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class DineInOrders extends StatefulWidget {
  const DineInOrders({Key? key}) : super(key: key);

  @override
  State<DineInOrders> createState() => _DineInOrdersState();
}

class _DineInOrdersState extends State<DineInOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, 0.05),
          ),
          child: Column(
            children: [
              heightBox(context, 0.05),
              text(context, "DINE IN ORDERS", 0.05, myWhite),
              const Divider(
                thickness: 1,
                color: myWhite,
              ),
              heightBox(context, 0.02),
              inputFieldsHome("Table Number:", "Ex:42", context),
              heightBox(context, 0.03),
              coloredButton(context, "SEARCH", myOrange),
              Expanded(
                child: tableCards(context, getReservationData("dinein-orders"),"Arrived Guests","View Details",
                    setState: () {
                  setState(() {});
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
