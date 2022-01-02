import 'package:casinocoin/models/coupon_list_model.dart';
import 'package:casinocoin/service/services.dart';
import 'package:casinocoin/utils/ad_widget.dart';
import 'package:casinocoin/utils/button_widget.dart';
import 'package:casinocoin/utils/enum.dart';
import 'package:casinocoin/utils/image_widget.dart';
import 'package:easy_ads_flutter/easy_ads_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:after_layout/after_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final controller = NativeAdController();

  @override
  void initState() {
    super.initState();

    if (Services.showAds &&
        (Services.appManager.showBottomNativeAd ||
            Services.appManager.showNativeAdsInListAdapter)) {
      controller.load();
      controller.onEvent.listen((event) {
        if (mounted) {
          setState(() {});
        }
      });
    }
    Services.loadFullScreenAd();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.blue,
          Colors.white,
          Colors.purple,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                width: double.infinity,
                height: 80.h,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.purple,
                    Colors.white,
                    Colors.blue,
                  ],
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/left3.gif", height: 30.h),
                    Image.asset("assets/left3.gif", height: 30.h),
                    const Text(
                      "Coupons",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Image.asset("assets/right3.gif", height: 30.h),
                    Image.asset("assets/right3.gif", height: 30.h),
                  ],
                )),
            Expanded(
              child: FutureBuilder<CouponListModel>(
                future: Services.callCodeListApi(),
                builder: (context, snapshot) {
                  List<Data>? couponList = snapshot.data?.data;
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                      onRefresh: Services.callCodeListApi,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(15.w),
                        itemCount: couponList?.length ?? 0,
                        itemBuilder: (context, index) {
                          Data singleCoupon = couponList![index];
                          return CardAdapter(
                            actionCallback: (type) {
                              if (type == ActionType.claim) {
                                _handleClaimClickEvent(singleCoupon);
                              } else {
                                Services.showFullScreenAd(
                                    type: AdUnitType.rewarded,
                                    showAds:
                                        Services.appManager.showRewardedAd);
                                Future.delayed(
                                    Duration(
                                        seconds:
                                            (Services.appManager.showAds! &&
                                                    Services.appManager
                                                        .showRewardedAd)
                                                ? 3
                                                : 0), () {
                                  Share.share(
                                      'Hey, I\'m sharing this coupon with you. click ${singleCoupon.link}');
                                });
                              }
                            },
                            data: singleCoupon,
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Image.asset(
                        "assets/wheel1.gif",
                        height: 100.w,
                        width: 100.w,
                      ),
                    );
                  }
                },
              ),
            ),

            //  ad
            if (controller.isLoaded && Services.appManager.showBottomNativeAd)
              NativeAdWidget1(controller: controller),

            if (Services.appManager.showBottomBannerAd)
              const BannerAdWidget1(adPosition: AdPosition.bottom),
          ],
        ),
      ),
    );
  }

  // _handleClaimClickEvent(Data couponData) async {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('casino royale'),
  //         content: const Text('Claim the coupon now'),
  //         actions: [
  //           TextButton(
  //               onPressed: () async {
  //                 if (couponData.isClaim != 1) {
  //                   if (!await launch(couponData.link!)) {
  //                     throw 'Could not launch ${couponData.link!}';
  //                   }
  //                   await Services.claimCodeApi(couponData.id!).then((value) {
  //                     setState(() {});
  //                   });
  //                 }
  //               },
  //               child: const Text('Claim')),
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('Cancel')),
  //         ],
  //       );
  //     },
  //   );
  // }

  _handleClaimClickEvent(Data couponData) async {
    Services.showFullScreenAd(
        type: AdUnitType.interstitial,
        showAds: Services.appManager.showInterstitialAd);
    BeautifulPopup(
      context: context,
      template: TemplateCoin,
    ).show(
        title: 'Redeem Coupon',
        actions: [
          ButtonWidget(
              onPressed: () async {
                if (couponData.isClaim != 1) {
                  if (!await launch(couponData.link!)) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Something went wrong. please try again later')));
                  }
                  await Services.claimCodeApi(couponData.id!).then((value) {
                    if (mounted) {
                      setState(() {});
                    }
                  });
                }
              },
              color: Colors.orange,
              title: 'Redeem')
        ],
        content: Text(
            couponData.isClaim != 1
                ? 'Redeem button will redirect you to game and you will get coins. Enjoy and come back tomorrow to get new coins.'
                : 'You have already redeemed this coupon. Please come back tomorrow.',
            textAlign: TextAlign.center));
  }
}

class CardAdapter extends StatefulWidget {
  final Data data;
  final ActionCallback actionCallback;
  const CardAdapter(
      {Key? key, required this.data, required this.actionCallback})
      : super(key: key);

  @override
  State<CardAdapter> createState() => _CardAdapterState();
}

class _CardAdapterState extends State<CardAdapter> {
  final controller = NativeAdController();

  @override
  void initState() {
    super.initState();

    if (Services.showAds &&
        (Services.appManager.showBottomNativeAd ||
            Services.appManager.showNativeAdsInListAdapter)) {
      controller.load();
      controller.onEvent.listen((event) {
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[1],
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.purple,
            Colors.white,
            Colors.blue,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.data.title!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.h,
          ),
          // Text('${data.claimCount!} people claimed',
          //     style: const TextStyle(fontSize: 15),),
          SizedBox(
            height: 10.h,
          ),
          Text(
            widget.data.createdAt!,
            style: const TextStyle(fontSize: 17),
          ),
          SizedBox(
            height: 10.h,
          ),
          if (controller.isLoaded &&
              Services.appManager.showNativeAdsInListAdapter)
            NativeAdWidget1(controller: controller),
          if (Services.appManager.showBannerAdsInListAdapter)
            const BannerAdWidget1(adPosition: AdPosition.list),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        widget.actionCallback(ActionType.claim);
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        primary: widget.data.claimButtonColor,
                      ),
                      child: Text(
                        widget.data.claimText,
                        style: TextStyle(color: widget.data.claimTextColor),
                      )),
                  SizedBox(
                    width: 5.w,
                  ),
                  Visibility(
                    visible: widget.data.claimButtonColor == Colors.blue,
                    child: ImageWidget(
                      url: "assets/left2.gif",
                      placeholder: "assets/wheel1.gif",
                      height: 30.h,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  widget.actionCallback(ActionType.share);
                },
                child: Column(
                  children: [
                    const Text('Share'),
                    ImageWidget(
                      url: "assets/share2.gif",
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
