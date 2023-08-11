class PurchaesModel {
  bool? success;
  List<Purchases>? purchases;
  int? count;
  String? errorMsg;

  PurchaesModel({this.success, this.purchases, this.count, this.errorMsg});
  PurchaesModel.withError(String errorMsg) {
    errorMsg = errorMsg;
  }

  PurchaesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['purchases'] != null) {
      purchases = <Purchases>[];
      json['purchases'].forEach((v) {
        purchases!.add(new Purchases.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.purchases != null) {
      data['purchases'] = this.purchases!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Purchases {
  String? sId;
  Seller? seller;
  String? qrCode;
  String? createdAt;
  String? fromTicket;
  String? toTicket;
  int? count;

  Purchases(
      {this.sId,
      this.seller,
      this.qrCode,
      this.createdAt,
      this.fromTicket,
      this.toTicket,
      this.count});

  Purchases.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    seller =
        json['seller'] != null ? new Seller.fromJson(json['seller']) : null;
    qrCode = json['qrCode'];
    createdAt = json['createdAt'];
    fromTicket = json['fromTicket'];
    toTicket = json['toTicket'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.seller != null) {
      data['seller'] = this.seller!.toJson();
    }
    data['qrCode'] = this.qrCode;
    data['createdAt'] = this.createdAt;
    data['fromTicket'] = this.fromTicket;
    data['toTicket'] = this.toTicket;
    data['count'] = this.count;
    return data;
  }
}

class Seller {
  String? sId;
  String? fullName;
  String? mobileNumber;
  String? email;

  Seller({this.sId, this.fullName, this.mobileNumber, this.email});

  Seller.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    return data;
  }
}
