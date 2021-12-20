import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ArrivedGuest extends StatelessWidget {
  const ArrivedGuest({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          heightBox(context, 0.05),
          text(context, "ARRIVED GUESTS", 0.05, myWhite),
          const Divider(
            thickness: 1,
            color: myWhite,
          ),
        ],
      ),
    );
  }
}