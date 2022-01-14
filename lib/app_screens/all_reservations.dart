import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/input_field_home.dart';
import 'package:baranh/widgets/table_cards.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AllReservationsPage extends StatefulWidget {
  const AllReservationsPage({Key? key}) : super(key: key);

  @override
  State<AllReservationsPage> createState() => _AllReservationsPageState();
}

class _AllReservationsPageState extends State<AllReservationsPage> {
  dynamic showData;

  @override
  void initState() {
  
    super.initState();
    setState(() {
      showData = getReservationData("reservelist");
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _reservationNumber = TextEditingController();
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
              text(context, "ALL RESERVATIONS", 0.05, myWhite),
              const Divider(
                thickness: 1,
                color: myWhite,
              ),
              heightBox(context, 0.02),
              inputFieldsHome("Reservation Number:", "Ex:Res.00042", context,
                  keyBoardType: TextInputType.number,
                  controller: _reservationNumber),
              heightBox(context, 0.02),
              inputFieldsHome("Select Date:", hintText, context, check: true),
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
                      setState(() {
                        showData = searchReservation(
                          hintText,
                          _reservationNumber.text,
                        );
                      });
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
                        showData = getReservationData("reservelist");
                      });
                    },
                  ),
                ],
              ),
              heightBox(context, 0.02),
              Expanded(
                child: tableCards(
                  context,
                  showData,
                  "Guest Arrived",
                  "View Details",
                  setState: () {
                    setState(() {});
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
