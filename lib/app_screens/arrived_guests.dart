import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/table_cards.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArrivedGuest extends StatefulWidget {
  const ArrivedGuest({Key? key}) : super(key: key);

  @override
  State<ArrivedGuest> createState() => _ArrivedGuestState();
}

class _ArrivedGuestState extends State<ArrivedGuest> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

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
              text(context, "ARRIVED GUESTS", 0.05, myWhite),
              const Divider(
                thickness: 1,
                color: myWhite,
              ),
              coloredButton(
                context,
                "text",
                myOrange,
                function: () async {
                  await getReservationData("arrived").then((value) {

                    reservedTable.clear();
                    for (var i in value) {

                      if ((i["order_status"] == "2" || i["order_status"] == "3") &&
                          i["apply_date"].toString() ==
                              "2022-01-13") {


                        reservedTable.add(i['table_name']);
                      }
                    }
                  });

                  print("object $reservedTable");
                },
              ),
              Expanded(
                child: tableCards(
                  context,
                  getReservationData("arrived"),
                  "Assign Table",
                  "Assign Waiter",
                  setState: () {
                    setState(() {});
                  },
                  function1check: true,
                  function2check: true,
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
