import 'package:flutter/material.dart';

class CouponListModel {
  CouponListModel({
    this.success,
    this.data,
  });

  CouponListModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.title,
    this.link,
    this.claimCount,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.isClaim,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    link = json['link'];
    claimCount = json['claim_count'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isClaim = json['is_claim'];
  }
  int? id;
  String? title;
  String? link;
  String? claimCount;
  String? isActive;
  String? createdAt;
  String? updatedAt;
  int? isClaim;

  String get claimText => isClaim == 1 ? 'Claimed' : 'Claim';
  Color get claimTextColor => isClaim == 1 ? Colors.grey : Colors.green;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['link'] = link;
    map['claim_count'] = claimCount;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_claim'] = isClaim;
    return map;
  }
}
