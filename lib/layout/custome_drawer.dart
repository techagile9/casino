import 'package:casinocoin/service/services.dart';
import 'package:casinocoin/utils/ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

class CustomerLeftDrawer extends StatefulWidget {
  const CustomerLeftDrawer({Key? key}) : super(key: key);

  @override
  _CustomerLeftDrawerState createState() => _CustomerLeftDrawerState();
}

class _CustomerLeftDrawerState extends State<CustomerLeftDrawer> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.transparent,
        body: Drawer(
          // backgroundColor: Colors.purpleAccent,
          child: Container(
            padding: EdgeInsets.only(top: 60.h),
            color: Colors.purpleAccent,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.h),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 15.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Container(
                          height: 60.w,
                          width: 60.w,
                          margin: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              image: const DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/casino.jpg"))),
                        ),
                      ),
                      Text(
                        'Get More Free Chips',
                        style: commonStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: const Divider(color: Colors.white),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      leading: const Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Home',
                        style: commonStyle,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      leading: const Icon(Icons.share, color: Colors.white),
                      title: Text(
                        'Share app',
                        style: commonStyle,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      leading:
                          const Icon(Icons.mood_rounded, color: Colors.white),
                      title: Text(
                        'More app',
                        style: commonStyle,
                      ),
                      trailing: Image.asset(
                        "assets/emoji2.gif",
                        height: 35.h,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      leading: const Icon(Icons.star_rate, color: Colors.white),
                      title: Text(
                        'Rate',
                        style: commonStyle,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 44.h),
                  child: const Divider(
                    color: Colors.white,
                  ),
                ),
                if (Services.showAds && Services.appManager.showBottomBannerAd)
                  const BannerAdWidget1(adPosition: AdPosition.bottom),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle commonStyle = const TextStyle(color: Colors.white, fontSize: 18);

  /*_handleEditProfile() {
    /// Close Drawer
    Scaffold.of(context).openEndDrawer();
    // Navigator.pushNamed(context, RouteName.editProfileCustomer);
  }*/

  _handleShareEvent() {
    Share.share('check out this amazing app. Download now ${''}');
  }
}
