import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'screens/home_slideshow_screen.dart';
import 'package:flutter/services.dart';

const String IOS_APP_ID = "ca-app-pub-1136808748888024~2566324176";
const String ANDROID_APP_ID = "ca-app-pub-1136808748888024~6501699753";
const String IOS_AD_UNIT_BANNER = "ca-app-pub-1136808748888024/4559074456";
const String ANDROID_AD_UNIT_BANNER = "ca-app-pub-1136808748888024/3875536416";
const String IOS_AD_UNIT_INTERSTITIAL =
    "ca-app-pub-1136808748888024/5583547369";
const String ANDROID_AD_UNIT_INTERSTITIAL =
    "ca-app-pub-1136808748888024/2503756758";

String getAppId() {
  if (Platform.isIOS) {
    return IOS_APP_ID;
  } else if (Platform.isAndroid) {
    return ANDROID_APP_ID;
  }
  return null;
}

String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return IOS_AD_UNIT_BANNER;
  } else if (Platform.isAndroid) {
    return ANDROID_AD_UNIT_BANNER;
  }
  return null;
}

String getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return IOS_AD_UNIT_INTERSTITIAL;
  } else if (Platform.isAndroid) {
    return ANDROID_AD_UNIT_INTERSTITIAL;
  }
  return null;
}

BannerAd _bannerAd;
InterstitialAd _interstitialAd;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['fashion', 'clothes'],
  );

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: getBannerAdUnitId(),
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: getInterstitialAdUnitId(),
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: getAppId());
    _bannerAd = createBannerAd()
      ..load()
      ..show(anchorType: AnchorType.bottom);
    _interstitialAd = createInterstitialAd()..load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Oferta',
        theme: ThemeData(primaryColor: Colors.teal, accentColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Slideshow()));
  }
}
