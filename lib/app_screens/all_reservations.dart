import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/input_field_home.dart';
import 'package:baranh/widgets/table_cards.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import '../app_functions/bottom_ad_bar.dart';

class AllReservationsPage extends StatefulWidget {
  const AllReservationsPage({Key? key}) : super(key: key);

  @override
  State<AllReservationsPage> createState() => _AllReservationsPageState();
}

class _AllReservationsPageState extends State<AllReservationsPage> {
  bool searchCheck = false;
  final TextEditingController _reservationNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomBannerAd(),
      backgroundColor: myBlack,
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(milliseconds: 0), () {
            setState(() {});
          });
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: dynamicWidth(context, 0.05),
            ),
            child: SizedBox(
              height: dynamicHeight(context, 1),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    heightBox(context, 0.05),
                    text(context, "ALL RESERVATIONS", 0.05, myWhite),
                    const Divider(
                      thickness: 1,
                      color: myWhite,
                    ),
                    heightBox(context, 0.02),
                    inputFieldsHome(
                        "Reservation Number:", "Ex:Res.00042", context,
                        keyBoardType: TextInputType.number,
                        controller: _reservationNumber),
                    heightBox(context, 0.02),
                    inputFieldsHome("Select Date:", hintText, context,
                        check: true),
                    heightBox(context, 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        coloredButton(
                          context,
                          "SEARCH",
                          myOrange,
                          fontSize: 0.042,
                          width: dynamicWidth(context, .4),
                          function: () {
                            if (_reservationNumber.text != "") {
                              setState(() {
                                searchCheck = true;
                              });
                            } else {
                              MotionToast.error(
                                title: "Error",
                                dismissable: true,
                                titleStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                description: "Empty Fields",
                              ).show(context);
                            }
                          },
                        ),
                        coloredButton(
                          context,
                          "CLEAR",
                          myOrange,
                          fontSize: 0.042,
                          width: dynamicWidth(context, .4),
                          function: () {
                            setState(() {
                              _reservationNumber.clear();
                              searchCheck = false;
                            });
                          },
                        ),
                      ],
                    ),
                    heightBox(context, 0.02),
                    tableCards(
                        context,
                        searchCheck == false
                            ? getReservationData("reservelist")
                            : searchReservation(
                                hintText,
                                _reservationNumber.text,
                              ),
                        "View details",
                        "View details", setState: () {
                      setState(() {});
                    },
                        visibleButton: false,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics())
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _reservationNumber.dispose();
    super.dispose();
  }
}
