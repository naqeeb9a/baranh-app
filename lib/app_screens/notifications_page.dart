import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        heightBox(context, 0.05),
        text(context, "Notifications", 0.05, myWhite),
        const Divider(
          thickness: 1,
          color: myWhite,
        ),
        heightBox(context, 0.03),
        Align(
            alignment: Alignment.centerLeft,
            child: text(context, "Nothing Found!!", 0.04, myWhite))
      ],
    );
  }
}
