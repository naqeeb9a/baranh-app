import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const kAndroidBannerUnitId = "ca-app-pub-8720578012805805/4837330496";
const kAndroidInterstitialAdUnitId = "ca-app-pub-8720578012805805/5465485069";
const kIosBannerUnitId = "ca-app-pub-8720578012805805/1244218777";

// The id of your own device will log to the console
const kTestDeviceId = "1630739AA7A907A2D01D5D2C47268D3F";

class AdService {
  final MobileAds _mobileAds;

  AdService(this._mobileAds);
  InterstitialAd? _interstitialAd;
  int attempt = 0;

  Future<void> init() async {
    await _mobileAds.initialize();
    if (kDebugMode) {
      final cfg = RequestConfiguration(testDeviceIds: [kTestDeviceId]);
      await MobileAds.instance.updateRequestConfiguration(cfg);
    }
  }

  BannerAd getBannerAd() {
    return BannerAd(
      adUnitId: _bannerUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          debugPrint("New banner ad loaded");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          debugPrint("Ad error: $error");
        },
      ),
      // You can fire-and-forget the call to .load(),
      // it does not need to be awaited
    )..load();
  }

  void getInterstitialAd() {
    InterstitialAd.load(
        adUnitId: _interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
            attempt = 0;
            debugPrint("New InterstitialAd ad loaded");
          },
          onAdFailedToLoad: (LoadAdError error) {
            attempt += 1;
            _interstitialAd = null;
            debugPrint('InterstitialAd failed to load: $error');
            if (attempt >= 2) {
              getInterstitialAd();
            }
          },
        ));
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      return;
    } else {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) =>
            debugPrint('%ad onAdShowedFullScreenContent.'),
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          debugPrint('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
        },
        onAdImpression: (InterstitialAd ad) =>
            debugPrint('$ad impression occurred.'),
      );
    }
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  String get _bannerUnitId {
    if (kDebugMode) {
      return BannerAd.testAdUnitId;
    }

    if (Platform.isAndroid) {
      return kAndroidBannerUnitId;
    }

    if (Platform.isIOS) {
      return kIosBannerUnitId;
    }

    throw UnimplementedError(
        "${Platform.operatingSystem} is not implemented for banner ads");
  }

  String get _interstitialAdUnitId {
    if (kDebugMode) {
      return InterstitialAd.testAdUnitId;
    }

    if (Platform.isAndroid) {
      return kAndroidInterstitialAdUnitId;
    }

    if (Platform.isIOS) {
      return kIosBannerUnitId;
    }

    throw UnimplementedError(
        "${Platform.operatingSystem} is not implemented for InterstitialAd ads");
  }
}
