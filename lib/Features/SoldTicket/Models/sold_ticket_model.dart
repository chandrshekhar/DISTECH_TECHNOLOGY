class SoldTicketModel {
  bool? success;
  List<Sales>? sales;
  int? count;

  SoldTicketModel({this.success, this.sales, this.count});
  SoldTicketModel.withError(String errorMsg) {
    errorMsg = errorMsg;
  }

  SoldTicketModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['sales'] != null) {
      sales = <Sales>[];
      json['sales'].forEach((v) {
        sales!.add( Sales.fromJson(v));
      });
    }
    count = json['count'];
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
  String? createdAt;
  Ticket? ticket;

  Sales({this.sId, this.createdAt, this.ticket});

  Sales.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdAt = json['createdAt'];
    ticket =
        json['ticket'] != null ? new Ticket.fromJson(json['ticket']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    if (this.ticket != null) {
      data['ticket'] = this.ticket!.toJson();
    }
    return data;
  }
}

class Ticket {
  String? sId;
  String? ticketId;
  String? barCode;
  String? qrCode;

  Ticket({this.sId, this.ticketId, this.barCode, this.qrCode});

  Ticket.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ticketId = json['ticketId'];
    barCode = json['barCode'];
    qrCode = json['qrCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['ticketId'] = this.ticketId;
    data['barCode'] = this.barCode;
    data['qrCode'] = this.qrCode;
    return data;
  }
}
