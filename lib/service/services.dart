import 'package:casinocoin/models/app_manager_model.dart';
import 'package:casinocoin/models/claimed_model.dart';
import 'package:casinocoin/service/easy_ad_manager.dart';
import 'package:casinocoin/service/strings.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:easy_ads_flutter/easy_ads_flutter.dart'
    hide AppOpenAd, MobileAds;
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart' as nad;
import 'package:url_launcher/url_launcher.dart';
import '../models/coupon_list_model.dart';

class Services {
  Services() {
    loadFullScreenAd();
  }
  static bool _showAds = true;
  static bool get showAds => _showAds;
  static const int _currentAppVersion = 1;
  static bool isAppUpdateRequired = false;

  static AppData _appManagerModel = AppData();
  static AppData get appManager => _appManagerModel;

  static Future<void> performInitialSetup() async {
    await Firebase.initializeApp();

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String deviceId = androidInfo.androidId;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('deviceId', deviceId);

    final res = await Dio().get(
        "https://app-manager2021.herokuapp.com/app?package=${Strings.appPackage}");

    if (res.statusCode == 200) {
      AppManagerModel data = AppManagerModel.fromJson(res.data);
      _showAds = data.data?.showAds ?? true;
      _appManagerModel = data.data!;
      isAppUpdateRequired =
          _currentAppVersion != _appManagerModel.currentAppVersion;
      if (_showAds) {
        const IAdIdManager easyAdManager = EasyAdManager();

        await nad.MobileAds.initialize(
            appOpenAdUnitId: data.data!.appOpen,
            nativeAdUnitId: data.data!.native,
            bannerAdUnitId: data.data!.banner,
            interstitialAdUnitId: data.data!.interstitial,
            rewardedAdUnitId: data.data!.rewarded,
            rewardedInterstitialAdUnitId: data.data!.rewardedInterstitial);
        EasyAds.instance.initialize(easyAdManager,
            adMobAdRequest: const AdRequest(), unityTestMode: true);
      }
    }
  }

  static showAppOpenAd() async {
    if (_showAds && _appManagerModel.showAppOpenAd) {
      final nad.AppOpenAd appOpenAd = nad.AppOpenAd()..load();
      if (!appOpenAd.isAvailable) await appOpenAd.load();
      if (appOpenAd.isAvailable) {
        await appOpenAd.show();
        appOpenAd.load();
      }
    }
  }

  static loadFullScreenAd() {
    if (_showAds &&
        (_appManagerModel.showInterstitialAd ||
            _appManagerModel.showRewardedAd)) {
      EasyAds.instance.loadAd(adNetwork: AdNetwork.admob);
    }
  }

  static showFullScreenAd({required AdUnitType type, required bool showAds}) {
    if (_showAds && showAds) {
      EasyAds.instance.showAd(type, adNetwork: AdNetwork.admob);
    }
  }

  static Future<CouponListModel> callCodeListApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceId = prefs.getString('deviceId')!;

    var response = await Dio().post(
        'http://varnisofttech.com/doubleu/public/admin/claim_records?device_id=$deviceId',
        options: Options(headers: headers));

    if (response.statusCode == 200) {
      return CouponListModel.fromJson(response.data);
    } else {
      return CouponListModel(data: [
        Data(
            id: 0,
            claimCount: '',
            createdAt: '',
            isActive: '',
            isClaim: 1,
            link: '',
            title: '',
            updatedAt: '')
      ], success: false);
    }
  }

  static Future<ClaimedModel> claimCodeApi(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceId = prefs.getString('deviceId')!;

    var response = await Dio().post(
        'http://varnisofttech.com/doubleu/public/admin/update_count?device_id=$deviceId&id=$id',
        options: Options(headers: headers));

    if (response.statusCode == 200) {
      return ClaimedModel.fromJson(response.data);
    } else {
      return ClaimedModel(data: 1, success: false);
    }
  }

  /// Open app store - Google Play / Apple Store
  Future<void> openAppStore({required AppPackage package}) async {
    String url =
        'https://play.google.com/store/apps/details?id=${package == AppPackage.newPackage ? _appManagerModel.newAppPackage : _appManagerModel.appPackage}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not open app store url....";
    }
  }

  Future<void> openPrivacyPage() async {
    if (_appManagerModel.privacyPolicyUrl != null &&
        await canLaunch(_appManagerModel.privacyPolicyUrl!)) {
      await launch(_appManagerModel.privacyPolicyUrl!);
    } else {
      throw "Could not launch url";
    }
  }
}

enum AppPackage { currentPackage, newPackage }
dynamic get headers => {
      'version': '1.0.3',
      'Content-Length': '0',
      'Host': 'varnisofttech.com',
      'Connection': 'Keep-Alive',
      'Accept-Encoding': 'gzip',
      'User-Agent': 'okhttp/3.10.0',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
