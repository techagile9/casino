import 'package:casinocoin/service/services.dart';
import 'package:easy_ads_flutter/easy_ads_flutter.dart'
    show EasyBannerAd, AdNetwork, AdSize;
import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

class NativeAdWidget1 extends StatelessWidget {
  final NativeAdController controller;

  const NativeAdWidget1({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Services.showAds) {
      return NativeAd(
        controller: controller,
        height: 60,
        builder: (context, child) {
          return Material(
            elevation: 0,
            child: child,
          );
        },
        buildLayout: (ratingBar, media, icon, headline, advertiser, body, price,
            store, attribution, button) {
          return AdLinearLayout(
            decoration: AdDecoration(
              gradient: AdGradient(
                colors: [
                  const Color(0XFF73bdf8),
                  Colors.white,
                  const Color(0XFFba68c8),
                ],
                type: 'linear',
              ),
            ),
            width: MATCH_PARENT,
            height: MATCH_PARENT,
            orientation: HORIZONTAL,
            gravity: LayoutGravity.center_vertical,
            children: [
              icon,
              AdExpanded(
                flex: 2,
                child: AdLinearLayout(
                  width: WRAP_CONTENT,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  children: [
                    headline,
                    AdLinearLayout(
                      orientation: HORIZONTAL,
                      children: [attribution, advertiser],
                    ),
                  ],
                ),
              ),
              AdExpanded(flex: 4, child: button),
            ],
          );
        },
        loading: const Text('Ad Loading'),
        error: const Text(''),
        icon: AdImageView(padding: const EdgeInsets.only(left: 6)),
        headline: AdTextView(style: const TextStyle(color: Colors.black)),
        advertiser: AdTextView(style: const TextStyle(color: Colors.black)),
        body: AdTextView(
            style: const TextStyle(color: Colors.black), maxLines: 1),
        media: AdMediaView(height: 70, width: 120),
        button: AdButtonView(
          text: 'Claim',
          decoration: AdDecoration(backgroundColor: Colors.blue),
          margin: const EdgeInsets.only(left: 6, right: 6),
          textStyle: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

enum AdPosition { list, bottom }

class BannerAdWidget1 extends StatelessWidget {
  final AdPosition adPosition;
  const BannerAdWidget1({Key? key, required this.adPosition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Services.showAds) {
      return Center(
          child: EasyBannerAd(
              adNetwork: AdNetwork.admob,
              adSize: adPosition == AdPosition.list
                  ? AdSize.banner
                  : AdSize.leaderboard));
    } else {
      return const SizedBox.shrink();
    }
  }
}
