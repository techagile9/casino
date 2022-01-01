class ClaimedModel {
  ClaimedModel({
    required this.success,
    required this.data,
  });
  bool? success;
  int? data;

  ClaimedModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data;
    return _data;
  }
}
