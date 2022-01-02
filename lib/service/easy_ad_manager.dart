import 'dart:io';

import 'package:casinocoin/service/services.dart';
import 'package:easy_ads_flutter/easy_ads_flutter.dart';

class EasyAdManager extends IAdIdManager {
  const EasyAdManager();

  @override
  AppAdIds? get admobAdIds => AppAdIds(
        appId: 'ca-app-pub-3940256099942544~3347511713',
        bannerId: Services.appManager.banner,
        interstitialId: Services.appManager.interstitial,
        rewardedId: Services.appManager.rewarded,
      );

  @override
  AppAdIds? get unityAdIds => AppAdIds(
        appId: Platform.isAndroid ? '4374881' : '4374880',
        bannerId: Platform.isAndroid ? 'Banner_Android' : 'Banner_iOS',
        interstitialId:
            Platform.isAndroid ? 'Interstitial_Android' : 'Interstitial_iOS',
        rewardedId: Platform.isAndroid ? 'Rewarded_Android' : 'Rewarded_iOS',
      );

  @override
  AppAdIds? get appLovinAdIds => AppAdIds(
        appId:
            'OeKTS4Zl758OIlAs3KQ6-3WE1IkdOo3nQNJtRubTzlyFU76TRWeQZAeaSMCr9GcZdxR4p2cnoZ1Gg7p7eSXCdA',
        interstitialId:
            Platform.isAndroid ? 'c48f54c6ce5ff297' : 'e33147110a6d12d2',
        rewardedId:
            Platform.isAndroid ? 'ffbed216d19efb09' : 'f4af3e10dd48ee4f',
      );
}
