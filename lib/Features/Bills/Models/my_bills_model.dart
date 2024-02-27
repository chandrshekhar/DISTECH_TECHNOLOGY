class MyBillModel {
  bool? success;
  List<Bills>? bills;
  int? count;
  String? error;

  MyBillModel({this.success, this.bills, this.count, this.error});

  MyBillModel.withError(String er) {
    error = er;
  }

  MyBillModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['bills'] != null) {
      bills = <Bills>[];
      json['bills'].forEach((v) {
        bills!.add(Bills.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (bills != null) {
      data['bills'] = bills!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class Bills {
  String? sId;
  String? userId;
  String? drawNumber;
  Supply? supply;
  Unsold? unsold;
  Unsold? voucher;
  Pwt? pwt;
  PreviousBills? previousBills;
  int? purchaseRate;
  int? totalPayable;
  int? remainingAmount;
  bool? isRedeemed;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Bills(
      {this.sId,
      this.userId,
      this.drawNumber,
      this.supply,
      this.unsold,
      this.voucher,
      this.pwt,
      this.previousBills,
      this.purchaseRate,
      this.totalPayable,
      this.remainingAmount,
      this.isRedeemed,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Bills.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    drawNumber = json['drawNumber'];
    supply = json['supply'] != null ? Supply.fromJson(json['supply']) : null;
    unsold = json['unsold'] != null ? Unsold.fromJson(json['unsold']) : null;
    voucher = json['voucher'] != null ? Unsold.fromJson(json['voucher']) : null;
    pwt = json['pwt'] != null ? Pwt.fromJson(json['pwt']) : null;
    previousBills = json['previousBills'] != null
        ? PreviousBills.fromJson(json['previousBills'])
        : null;
    purchaseRate = json['purchaseRate'];
    totalPayable = json['totalPayable'];
    remainingAmount = json['remainingAmount'];
    isRedeemed = json['isRedeemed'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['drawNumber'] = drawNumber;
    if (supply != null) {
      data['supply'] = supply!.toJson();
    }
    if (unsold != null) {
      data['unsold'] = unsold!.toJson();
    }
    if (voucher != null) {
      data['voucher'] = voucher!.toJson();
    }
    if (pwt != null) {
      data['pwt'] = pwt!.toJson();
    }
    if (previousBills != null) {
      data['previousBills'] = previousBills!.toJson();
    }
    data['purchaseRate'] = purchaseRate;
    data['totalPayable'] = totalPayable;
    data['remainingAmount'] = remainingAmount;
    data['isRedeemed'] = isRedeemed;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Supply {
  String? fromDate;
  String? toDate;
  int? totalTickets;
  int? totalPrice;

  Supply({
    this.fromDate,
    this.toDate,
    this.totalTickets,
    this.totalPrice,
  });

  Supply.fromJson(Map<String, dynamic> json) {
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    totalTickets = json['totalTickets'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['totalTickets'] = totalTickets;
    data['totalPrice'] = totalPrice;

    return data;
  }
}

class Unsold {
  String? fromDate;
  String? toDate;
  int? totalTickets;
  int? totalPrice;
  List<String>? ids;

  Unsold(
      {this.fromDate,
      this.toDate,
      this.totalTickets,
      this.totalPrice,
      this.ids});

  Unsold.fromJson(Map<String, dynamic> json) {
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    totalTickets = json['totalTickets'];
    totalPrice = json['totalPrice'];
    ids = json['ids'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['totalTickets'] = totalTickets;
    data['totalPrice'] = totalPrice;
    data['ids'] = ids;
    return data;
  }
}

class Pwt {
  int? totalTickets;
  int? totalPrice;
  int? totalPrizes;

  Pwt({this.totalTickets, this.totalPrice, this.totalPrizes});

  Pwt.fromJson(Map<String, dynamic> json) {
    totalTickets = json['totalTickets'];
    totalPrice = json['totalPrice'];
    totalPrizes = json['totalPrizes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalTickets'] = totalTickets;
    data['totalPrice'] = totalPrice;
    data['totalPrizes'] = totalPrizes;

    return data;
  }
}

class PreviousBills {
  int? totalPrice;
  int? totalBills;
  List<Null>? ids;

  PreviousBills({this.totalPrice, this.totalBills, this.ids});

  PreviousBills.fromJson(Map<String, dynamic> json) {
    totalPrice = json['totalPrice'];
    totalBills = json['totalBills'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalPrice'] = totalPrice;
    data['totalBills'] = totalBills;

    return data;
  }
}
