class SoldTicketModel {
  bool? success;
  List<Sales>? sales;
  int? count;
  String? errorMsg;
  SoldTicketModel({this.success, this.sales, this.count, this.errorMsg});

  SoldTicketModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['sales'] != null) {
      sales = <Sales>[];
      json['sales'].forEach((v) {
        sales!.add(new Sales.fromJson(v));
      });
    }
    count = json['count'];
  }
  SoldTicketModel.withError(String error) {
    errorMsg = error;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.sales != null) {
      data['sales'] = this.sales!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Sales {
  String? sId;
  String? ticketId;
  String? barCode;
  String? qrCode;
  int? sEM;
  String? date;

  Sales(
      {this.sId,
      this.ticketId,
      this.barCode,
      this.qrCode,
      this.sEM,
      this.date});

  Sales.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ticketId = json['ticketId'];
    barCode = json['barCode'];
    qrCode = json['qrCode'];
    sEM = json['SEM'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['ticketId'] = this.ticketId;
    data['barCode'] = this.barCode;
    data['qrCode'] = this.qrCode;
    data['SEM'] = this.sEM;
    data['date'] = this.date;
    return data;
  }
}
