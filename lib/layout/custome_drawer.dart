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
      onTap: (){
        FocusScope.of(context).unfocus();
        // Scaffold.of(context).openEndDrawer();
      },
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.transparent,
        body: Drawer(
          child: Container(
            padding: EdgeInsets.only(
                left: 30.w,
                top: 60.h
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Row(
                     children: [
                       Container(
                         margin: EdgeInsets.only(right: 15.w),
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(5),
                             border: Border.all(color: Colors.black),
                         ),
                         child: Container(
                           height: 60.w,
                           width: 60.w,
                           margin: const EdgeInsets.all(3),
                           // decoration: BoxDecoration(
                           //   borderRadius: BorderRadius.circular(5),
                           //   image: DecorationImage(
                           //       fit: BoxFit.fill,
                           //     image: AssetImage(AppImage.download1)
                           //   )
                           // ),
                           // child:  ImageWidget(
                           //     placeholder: AppImage.placeholder2,
                           //     url: ApiConstant.baseProfileImageDomain+User.currentUser.profile!,
                           //   )
                         ),
                       ),
                       const Text(
                           'User.currentUser.fullName',
                       ),
                     ],
                   ),
                Padding(
                  padding: EdgeInsets.only(top: 30.h,bottom: 30.h),
                  child: Divider(color: Colors.black),
                ),

                GestureDetector(
                  onTap: (){
                    Scaffold.of(context).openEndDrawer();
                      // Navigator.pushNamed(context, RouteName.yourProfileScreen);
                  },
                  child: const Text(
                    'Translations.of(context).strYourProfile',
                  ),
                ),
                SizedBox(height: 23.h,),

                GestureDetector(
                  onTap: (){
                    Scaffold.of(context).openEndDrawer();
                    // Navigator.pushNamed(context, RouteName.yourBalanceScreen);
                  },
                  child: const Text(
                    'Translations.of(context).strYourBalance',
                  ),
                ),
                SizedBox(height: 23.h,),

                GestureDetector(
                  onTap: (){
                    Scaffold.of(context).openEndDrawer();
                    // Navigator.pushNamed(context, RouteName.paymentScreen);
                  },
                  child: const Text(
                    'Translations.of(context).strPaymentMethod',
                  ),
                ),
                SizedBox(height: 23.h,),

                GestureDetector(
                  onTap: (){
                    Scaffold.of(context).openEndDrawer();
                    // Navigator.pushNamed(context, RouteName.connectWithUsScreen);
                  },
                  child: const Text(
                    'Translations.of(context).strConnectWithUs',
                  ),
                ),
                SizedBox(height: 23.h,),

                GestureDetector(
                  onTap: (){

                    // Navigator.pushNamedAndRemoveUntil(
                    //   context, RouteName.signUpNumberScreen, (route) => false,
                    // ).then((value) {
                    //   User.currentUser.resetUserDetail();
                    // });
                  },
                  child: const Text(
                    'Translations.of(context).strLogout',
                  ),
                ),
                SizedBox(height: 23.h,),
                GestureDetector(
                  onTap: (){
                    Scaffold.of(context).openEndDrawer();
                    // Navigator.pushNamed(context, RouteName.deleteAccountScreen);
                  },
                  child: Text(
                    'Translations.of(context).strDeleteAccount',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 26.h,bottom: 44.h),
                  child: Divider(color: Colors.black,),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  /*_handleEditProfile() {
    /// Close Drawer
    Scaffold.of(context).openEndDrawer();
    // Navigator.pushNamed(context, RouteName.editProfileCustomer);
  }*/


  _handleShareEvent(){
    Share.share('check out this amazing app. Download now ${''}');
  }
}
