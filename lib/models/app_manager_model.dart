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
