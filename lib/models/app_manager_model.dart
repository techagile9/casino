class AppManagerModel {
  AppManagerModel({
    this.data,
  });

  AppManagerModel.fromJson(dynamic json) {
    data = json['data'] != null ? AppData.fromJson(json['data']) : null;
  }
  AppData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// id : 53
/// created_at : "2021-12-18T03:38:48.234303+00:00"
/// app_package : "app.free_food"
/// interstitial : "/6499/example/interstitial"
/// banner : "/6499/example/banner"
/// native : ""
/// app_open : "/6499/example/app-open"
/// new_app_package : "com.amanotes.beathopper"
/// show_ads : false
/// rewarded : ""
/// current_app_version : 1
/// app_email : "nikhilvala269@gmail.com"
/// privacy_policy_url : "https://www.termsfeed.com/live/92fbfbe7-942c-4e41-a24e-95948136f9fc"
/// terms_of_service_url : "https://www.termsfeed.com/live/92fbfbe7-942c-4e41-a24e-95948136f9fc"
/// extras : ""
/// rewarded_interstitial : ""
/// app_name : "Free Food"
/// isDeleted : false

class AppData {
  AppData({
    this.id,
    this.createdAt,
    this.appPackage,
    this.interstitial,
    this.banner,
    this.native,
    this.appOpen,
    this.newAppPackage,
    this.showAds,
    this.rewarded,
    this.currentAppVersion,
    this.appEmail,
    this.privacyPolicyUrl,
    this.termsOfServiceUrl,
    this.extras,
    this.rewardedInterstitial,
    this.appName,
    this.isDeleted,
  });

  bool get showNativeAdsInListAdapter => extras!.contains('1') != true;
  bool get showBannerAdsInListAdapter => extras!.contains('2') != true;
  bool get showBottomNativeAd => extras!.contains('3') != true;
  bool get showBottomBannerAd => extras!.contains('4') != true;
  bool get showAppOpenAd => extras!.contains('5') != true;
  bool get showInterstitialAd => extras!.contains('6') != true;
  bool get showRewardedAd => extras!.contains('7') != true;

  AppData.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    appPackage = json['app_package'];
    interstitial = json['interstitial'];
    banner = json['banner'];
    native = json['native'];
    appOpen = json['app_open'];
    newAppPackage = json['new_app_package'];
    showAds = json['show_ads'];
    rewarded = json['rewarded'];
    currentAppVersion = json['current_app_version'];
    appEmail = json['app_email'];
    privacyPolicyUrl = json['privacy_policy_url'];
    termsOfServiceUrl = json['terms_of_service_url'];
    extras = json['extras'];
    rewardedInterstitial = json['rewarded_interstitial'];
    appName = json['app_name'];
    isDeleted = json['isDeleted'];
  }
  int? id;
  String? createdAt;
  String? appPackage;
  String? interstitial;
  String? banner;
  String? native;
  String? appOpen;
  String? newAppPackage;
  bool? showAds;
  String? rewarded;
  int? currentAppVersion;
  String? appEmail;
  String? privacyPolicyUrl;
  String? termsOfServiceUrl;
  String? extras;
  String? rewardedInterstitial;
  String? appName;
  bool? isDeleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['app_package'] = appPackage;
    map['interstitial'] = interstitial;
    map['banner'] = banner;
    map['native'] = native;
    map['app_open'] = appOpen;
    map['new_app_package'] = newAppPackage;
    map['show_ads'] = showAds;
    map['rewarded'] = rewarded;
    map['current_app_version'] = currentAppVersion;
    map['app_email'] = appEmail;
    map['privacy_policy_url'] = privacyPolicyUrl;
    map['terms_of_service_url'] = termsOfServiceUrl;
    map['extras'] = extras;
    map['rewarded_interstitial'] = rewardedInterstitial;
    map['app_name'] = appName;
    map['isDeleted'] = isDeleted;
    return map;
  }
}
