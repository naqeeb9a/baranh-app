import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/table_cards.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../app_functions/bottom_ad_bar.dart';

class DineInOrders extends StatefulWidget {
  const DineInOrders({Key? key}) : super(key: key);

  @override
  State<DineInOrders> createState() => _DineInOrdersState();
}

class _DineInOrdersState extends State<DineInOrders> {
  @override
  Widget build(BuildContext context) {
    globalDineInContext = context;
    globalDineInRefresh = () {
      setState(() {});
    };

    return Scaffold(
      bottomNavigationBar: const BottomBannerAd(),
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
              Expanded(
                child: tableCards(
                  context,
                  getDineInOrders("dinein-orders", false),
                  "View details",
                  "Change Table",
                  setState: () {
                    setState(() {});
                  },
                  visible: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
