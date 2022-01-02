import 'package:casinocoin/models/coupon_list_model.dart';
import 'package:casinocoin/service/services.dart';
import 'package:casinocoin/utils/enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
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
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Image.asset("assets/left3.gif", height: 30.h,),
                    Image.asset("assets/left3.gif", height: 30.h,
                    ),
                    const Text(
                      "Coupons",
                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Image.asset("assets/right3.gif", height: 30.h,),
                    Image.asset("assets/right3.gif", height: 30.h,),
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
                            actionCallback: (type){
                              if(type==ActionType.claim){
                                print('claimed');
                                _handleClaimClickEvent(singleCoupon);
                              }else{
                                Share.share('Hey, I\'m sharing this coupon with you. click ${singleCoupon.link}');
                              }
                            },
                            data: singleCoupon,
                          );
                        },
                      ),
                    );
                  } else {
                    return  Center(
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
          ],
        ),
      ),
    );
  }

  _handleClaimClickEvent(Data couponData) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('casino royale'),
          content: const Text('Claim the coupon now'),
          actions: [
            TextButton(
                onPressed: () async {
                  if (couponData.isClaim != 1) {
                    if (!await launch(couponData.link!)) {
                      throw 'Could not launch ${couponData.link!}';
                    }
                    await Services.claimCodeApi(couponData.id!).then((value) {
                      setState(() {});
                    });
                  }
                },
                child: const Text('Claim')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
          ],
        );
      },
    );
  }

  _openDialog() {}
}

class CardAdapter extends StatelessWidget {
  final Data data;
  ActionCallback actionCallback;
   CardAdapter({Key? key, required this.data,required this.actionCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 10.w,horizontal: 10.w),
      margin:  EdgeInsets.only(bottom: 10.h),
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
          Text(data.title!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 5.h,),
          // Text('${data.claimCount!} people claimed',
          //     style: const TextStyle(fontSize: 15),),
          SizedBox(height: 10.h,),
          Text(data.createdAt!,style: const TextStyle(fontSize: 17),),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  ElevatedButton(
                      onPressed: (){
                        actionCallback(ActionType.claim);
                      },
                      style:ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        primary: data.claimButtonColor,
                      ),
                      child: Text(
                        data.claimText,
                        style: TextStyle(color: data.claimTextColor),
                      )),
                  SizedBox(width: 5.w,),
                  Visibility(
                    visible: data.claimButtonColor==Colors.blue,
                    child: Image.asset(
                      "assets/left2.gif",
                      height: 30.h,
                    ),
                  ),
                ],
              ),

              GestureDetector(
                onTap: (){
                  actionCallback(ActionType.share);
                },
                child: Column(
                  children: [
                    Text('Share'),
                    Image.asset(
                      "assets/share2.gif",
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
