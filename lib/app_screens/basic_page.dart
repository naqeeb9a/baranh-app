import 'dart:io' show Platform;

import 'package:baranh/app_functions/fcm_service.dart';
import 'package:baranh/app_functions/notification_class.dart';
import 'package:baranh/app_screens/all_reservations.dart';
import 'package:baranh/app_screens/arrived_guests.dart';
import 'package:baranh/app_screens/call_back_url.dart';
import 'package:baranh/app_screens/dine_in_orders.dart';
import 'package:baranh/app_screens/new_reservations.dart';
import 'package:baranh/app_screens/waiting_for_arrival.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:upgrader/upgrader.dart';

class BasicPage extends StatefulWidget {
  const BasicPage({Key? key}) : super(key: key);

  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> with TickerProviderStateMixin {
  var hintText = "mm/dd/yyy";

  fcmListen() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      if (event.data['id'] == userResponse['id']) {
        LocalNotificationsService.instance
            .showChatNotification(
          title: '${event.notification!.title}',
          body: '${event.notification!.body}',
        )
            .then((value) async {
          await FlutterRingtonePlayer.play(
            android: AndroidSounds.ringtone,
            ios: IosSounds.bell,
            looping: true,
            volume: 1.0,
            asAlarm: true,
          );
          return CoolAlert.show(
            context: customContext,
            title: '${event.notification!.title}',
            text: '${event.notification!.body}',
            type: CoolAlertType.info,
            confirmBtnText: "OK",
            backgroundColor: myOrange,
            barrierDismissible: false,
            showCancelBtn: false,
            confirmBtnColor: myOrange,
            lottieAsset: "assets/bell.json",
            confirmBtnTextStyle: TextStyle(
              fontSize: dynamicWidth(context, 0.04),
              color: myWhite,
            ),
            onConfirmBtnTap: () {
              FlutterRingtonePlayer.stop();
              Navigator.of(context, rootNavigator: true).pop();
            },
          );
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    FCMServices.fcmGetTokenAndSubscribe();
    fcmListen();
  }

  @override
  Widget build(BuildContext context) {
    customContext = context;
    return Scaffold(
      
      backgroundColor: myBlack,
      body: UpgradeAlert(
        showIgnore: false,
        showLater: false,
        showReleaseNotes: true,
        canDismissDialog: false,
        shouldPopScope: () => false,
        dialogStyle: Platform.isAndroid
            ? UpgradeDialogStyle.material
            : UpgradeDialogStyle.cupertino,
        child: bodyPage(pageDecider),
      ),
    );
  }

  bodyPage(String page) {
    switch (page) {
      case "All Reservations":
        return const AllReservationsPage();
      case "Waiting For Arrival":
        return const WaitingForArrival();
      case "Arrived Guests":
        return const ArrivedGuest();
      case "Dine In Orders":
        return const DineInOrders();
      case "New Reservations":
        return const NewReservationsPage();
      case "Callback Url":
        return const CallBackUrl();

      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            text(context, "error", .06, myWhite),
          ],
        );
    }
  }
}
