import 'package:baranh/app_functions/ad_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BottomBannerAd extends StatefulWidget {
  const BottomBannerAd({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomBannerAdState();
}

class _BottomBannerAdState extends State<BottomBannerAd> {
  final banner = GetIt.instance.get<AdService>().getBannerAd();

  @override
  void dispose() {
    banner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AdWidget(ad: banner),
      height: banner.size.height.toDouble(),
      width: banner.size.width.toDouble(),
    );
  }
}
