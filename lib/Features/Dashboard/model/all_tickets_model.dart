class AllMyTicketModel {
  bool? success;
  List<Tickets>? tickets;
  int? count;
  String? errorMsg;

  AllMyTicketModel({this.success, this.tickets, this.count, this.errorMsg});


  AllMyTicketModel.withError(String errorMsg){
    errorMsg = errorMsg;
  }

  AllMyTicketModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets!.add( Tickets.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['success'] = success;
    if (tickets != null) {
      data['tickets'] = tickets!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
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
  String? status;
  String? date;
  String? createdAt;
  String? currOwner;
  int? sEM;

  Tickets(
      {this.sId,
      this.ticketId,
      this.ticketLetter,
      this.ticketNumber,
      this.barCode,
      this.qrCode,
      this.status,
      this.date,
      this.createdAt,
      this.currOwner,
      this.sEM});

  Tickets.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ticketId = json['ticketId'];
    ticketLetter = json['ticketLetter'];
    ticketNumber = json['ticketNumber'];
    barCode = json['barCode'];
    qrCode = json['qrCode'];
    status = json['status'];
    date = json['date'];
    createdAt = json['createdAt'];
    currOwner = json['currOwner'];
    sEM = json['SEM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = sId;
    data['ticketId'] = ticketId;
    data['ticketLetter'] = ticketLetter;
    data['ticketNumber'] = ticketNumber;
    data['barCode'] = barCode;
    data['qrCode'] = qrCode;
    data['status'] = status;
    data['date'] = date;
    data['createdAt'] = createdAt;
    data['currOwner'] = currOwner;
    data['SEM'] = sEM;
    return data;
  }
}
