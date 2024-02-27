import 'dart:convert';

class SoldTicketModel {
  bool? success;
  List<Sales>? sales;
  int? count;
  int? totalCount;
  String? error;

  SoldTicketModel(
      {this.success, this.sales, this.count, this.error, this.totalCount});

  SoldTicketModel.withError(String err) {
    error = err;
  }

  SoldTicketModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['sales'] != null) {
      sales = <Sales>[];
      json['sales'].forEach((v) {
        sales!.add(Sales.fromJson(v));
      });
    }
    count = json['count'];
    totalCount = json['totalQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (sales != null) {
      data['sales'] = sales!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    data['totalQuantity'] = totalCount;
    return data;
  }
}

class Sales {
  String? sId;
  String? uid;
  String? seller;
  String? fromLetter;
  String? toLetter;
  String? fromNumber;
  String? toNumber;
  int? count;
  String? ticketDate;
  String? createdAt;
  int? iV;

  Sales(
      {this.sId,
      this.uid,
      this.seller,
      this.fromLetter,
      this.toLetter,
      this.fromNumber,
      this.toNumber,
      this.count,
      this.ticketDate,
      this.createdAt,
      this.iV});

  Sales.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    uid = json['uid'];
    seller = json['seller'];

    fromLetter = json['fromLetter'];
    toLetter = json['toLetter'];
    fromNumber = json['fromNumber'];
    toNumber = json['toNumber'];
    count = json['count'];
    ticketDate = json['ticketDate'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['uid'] = uid;
    data['seller'] = seller;

    data['fromLetter'] = fromLetter;
    data['toLetter'] = toLetter;
    data['fromNumber'] = fromNumber;
    data['toNumber'] = toNumber;
    data['count'] = count;
    data['ticketDate'] = ticketDate;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}
