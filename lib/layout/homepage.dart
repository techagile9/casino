import 'package:casinocoin/models/coupon_list_model.dart';
import 'package:casinocoin/service/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

typedef buttonCallback = void Function();
typedef ActionCallback = void Function(ActionType type);
enum ActionType {
  claim,
  share,
}

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
                height: 80,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.blueGrey,
                        Colors.purple,
                      ],
                    )
                ),
                child: const Text("Coupons",style: TextStyle(color: Colors.white,fontSize: 20),)),
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
                        padding: const EdgeInsets.all(15),
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
                        height: 100,
                        width: 100,
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
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          boxShadow: kElevationToShadow[1],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(data.title!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text('${data.claimCount!} people claimed',
              style: TextStyle(fontSize: 15),),
          SizedBox(height: 10,),
          Text(data.createdAt!,style: TextStyle(fontSize: 17),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /*TextButton(
                  onPressed: (){
                    actionCallback(ActionType.claim);
                  },
                  child: Text(
                    data.claimText,
                    style: TextStyle(color: data.claimTextColor),
                  )),*/
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
              ElevatedButton(
                  onPressed: ()=>actionCallback(ActionType.share),
                  style:ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                  child: Text('Share')),
            ],
          )
        ],
      ),
    );
  }
}
