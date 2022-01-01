import 'package:casinocoin/models/claimed_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/coupon_list_model.dart';

class Services {
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
}

dynamic get headers => {
      'version': '1.0.3',
      'Content-Length': '0',
      'Host': 'varnisofttech.com',
      'Connection': 'Keep-Alive',
      'Accept-Encoding': 'gzip',
      'User-Agent': 'okhttp/3.10.0',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
