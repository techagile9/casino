import 'package:casinocoin/models/coupon_list_model.dart';
import 'package:casinocoin/service/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coupons"),
      ),
      body: FutureBuilder<CouponListModel>(
        future: Services.callCodeListApi(),
        builder: (context, snapshot) {
          List<Data>? couponList = snapshot.data?.data;
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: Services.callCodeListApi,
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: couponList?.length ?? 0,
                itemBuilder: (context, index) {
                  Data singleCoupon = couponList![index];
                  return GestureDetector(
                    onTap: () => _handleClaimClickEvent(singleCoupon),
                    child: CardAdapter(
                      data: singleCoupon,
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: CupertinoActivityIndicator(animating: true),
            );
          }
        },
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
  const CardAdapter({Key? key, required this.data}) : super(key: key);

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
          Text(data.title!),
          Text('${data.claimCount!} people claimed'),
          Text(data.createdAt!),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: null,
                  child: Text(
                    data.claimText,
                    style: TextStyle(color: data.claimTextColor),
                  )),
              TextButton(
                  onPressed: () {
                    Share.share(
                        'Hey, I\'m sharing this coupon with you. click ${data.link}');
                  },
                  child: const Text('Share')),
            ],
          )
        ],
      ),
    );
  }
}
