class PurchaseHistoryTicketDetailsModel {
  bool? success;
  List<Tickets>? tickets;
  int? count;
String? errorMsg;
  PurchaseHistoryTicketDetailsModel({this.success, this.tickets, this.count, this.errorMsg});

  PurchaseHistoryTicketDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets!.add(new Tickets.fromJson(v));
      });
    }
    count = json['count'];
  }


  PurchaseHistoryTicketDetailsModel.withError(String errorMsg) {
     errorMsg = errorMsg;
     
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.tickets != null) {
      data['tickets'] = this.tickets!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Tickets {
  String? sId;
  String? ticketId;
  String? ticketLetter;
  String? ticketNumber;
  String? barCode;
  String? qrCode;
  int? sEM;
  String? status;
  String? date;
  String? createdAt;

  Tickets(
      {this.sId,
      this.ticketId,
      this.ticketLetter,
      this.ticketNumber,
      this.barCode,
      this.qrCode,
      this.sEM,
      this.status,
      this.date,
      this.createdAt});

  Tickets.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ticketId = json['ticketId'];
    ticketLetter = json['ticketLetter'];
    ticketNumber = json['ticketNumber'];
    barCode = json['barCode'];
    qrCode = json['qrCode'];
    sEM = json['SEM'];
    status = json['status'];
    date = json['date'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['ticketId'] = this.ticketId;
    data['ticketLetter'] = this.ticketLetter;
    data['ticketNumber'] = this.ticketNumber;
    data['barCode'] = this.barCode;
    data['qrCode'] = this.qrCode;
    data['SEM'] = this.sEM;
    data['status'] = this.status;
    data['date'] = this.date;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
