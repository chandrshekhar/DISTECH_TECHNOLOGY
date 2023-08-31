class PurchaesModel {
  bool? success;
  List<Purchases>? purchases;
  int? count;
  String? errorMsg;

  PurchaesModel({
    this.success,
    this.purchases,
    this.count,
    this.errorMsg,
  });
  PurchaesModel.withError(String errorMsg) {
    errorMsg = errorMsg;
  }

  PurchaesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['purchases'] != null) {
      purchases = <Purchases>[];
      json['purchases'].forEach((v) {
        purchases!.add(Purchases.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (purchases != null) {
      data['purchases'] = purchases!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
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
  String? fromNumber;
  String? toNumber;
  int? count;

  Purchases(
      {this.sId,
      this.seller,
      this.qrCode,
      this.createdAt,
      this.fromTicket,
      this.fromNumber,
      this.toNumber,
      this.toTicket,
      this.count});

  Purchases.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    qrCode = json['qrCode'];
    createdAt = json['createdAt'];
    fromTicket = json['fromLetter'];
    fromNumber = json['fromNumber'];
    toNumber = json['toNumber'];
    toTicket = json['toLetter'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (seller != null) {
      data['seller'] = seller!.toJson();
    }
    data['qrCode'] = qrCode;
    data['createdAt'] = createdAt;
    data['fromTicket'] = fromTicket;
     data['fromNumber'] = fromNumber;
    data['toNumber'] = toNumber;
    data['toTicket'] = toTicket;
    data['count'] = count;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fullName'] = fullName;
    data['mobileNumber'] = mobileNumber;
    data['email'] = email;
    return data;
  }
}
