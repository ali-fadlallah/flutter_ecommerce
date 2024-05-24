class WishListEntity {
  WishListEntity({
    this.status,
    this.statusMsg,
    this.message,
  });

  WishListEntity.fromJson(dynamic json) {
    status = json['status'];
    statusMsg = json['statusMsg'];
    message = json['message'];
  }

  String? status;
  String? statusMsg;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['statusMsg'] = statusMsg;
    map['message'] = message;
    return map;
  }
}
