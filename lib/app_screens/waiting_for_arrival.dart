import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/table_cards.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../app_functions/bottom_ad_bar.dart';

class WaitingForArrival extends StatefulWidget {
  const WaitingForArrival({Key? key}) : super(key: key);

  @override
  State<WaitingForArrival> createState() => _WaitingForArrivalState();
}

class _WaitingForArrivalState extends State<WaitingForArrival> {
  @override
  Widget build(BuildContext context) {
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
              FittedBox(
                child: text(context, "WAITING FOR ARRIVAL", 0.05, myWhite,
                    alignText: TextAlign.center),
              ),
              const Divider(
                thickness: 1,
                color: myWhite,
              ),
              Expanded(
                child: tableCards(
                  context,
                  getReservationData("waiting-for-arrival"),
                  "Guest Arrived",
                  "View details",
                  setState: () {
                    setState(() {});
                  },
                  visible: true,
                  visibleButton: false,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
