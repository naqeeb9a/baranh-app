import 'package:baranh/app_functions/bottom_ad_bar.dart';
import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/table_cards.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ArrivedGuest extends StatefulWidget {
  const ArrivedGuest({Key? key}) : super(key: key);

  @override
  State<ArrivedGuest> createState() => _ArrivedGuestState();
}

class _ArrivedGuestState extends State<ArrivedGuest> {
  @override
  void initState() {
    super.initState();
  }

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
              text(context, "ARRIVED GUESTS", 0.05, myWhite),
              const Divider(
                thickness: 1,
                color: myWhite,
              ),
              Expanded(
                child: tableCards(
                  context,
                  getReservationData("arrived"),
                  "Assign Waiter",
                  "Assign Table",
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
