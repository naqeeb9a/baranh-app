import 'package:baranh/utils/config.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: text(context, "POLO", 0.04, myBlack),
      ),
    );
  }
}
