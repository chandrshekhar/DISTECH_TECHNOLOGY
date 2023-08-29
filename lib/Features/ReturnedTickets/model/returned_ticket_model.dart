class ReturnedTicketModel {
  bool? success;
  List<AllReturnedTickets>? allReturnedTickets;
  int? returnedCount;
  int? unsoldCount;
  int? remainingReturns;
  String? errorMsg;
  ReturnedTicketModel(
      {this.success,
      this.allReturnedTickets,
      this.returnedCount,
      this.unsoldCount,
      this.remainingReturns, this.errorMsg});
  ReturnedTicketModel.withError(String error) {
    errorMsg = error;
  }
  ReturnedTicketModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['allReturnedTickets'] != null) {
      allReturnedTickets = <AllReturnedTickets>[];
      json['allReturnedTickets'].forEach((v) {
        allReturnedTickets!.add(new AllReturnedTickets.fromJson(v));
      });
    }

    returnedCount = json['returnedCount'];
    unsoldCount = json['unsoldCount'];
    remainingReturns = json['remainingReturns'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.allReturnedTickets != null) {
      data['allReturnedTickets'] =
          this.allReturnedTickets!.map((v) => v.toJson()).toList();
    }
    data['returnedCount'] = this.returnedCount;
    data['unsoldCount'] = this.unsoldCount;
    data['remainingReturns'] = this.remainingReturns;
    return data;
  }
}

class AllReturnedTickets {
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
  int? iV;
  Null? currOwner;

  AllReturnedTickets(
      {this.sId,
      this.ticketId,
      this.ticketLetter,
      this.ticketNumber,
      this.barCode,
      this.qrCode,
      this.sEM,
      this.status,
      this.date,
      this.createdAt,
      this.iV,
      this.currOwner});

  AllReturnedTickets.fromJson(Map<String, dynamic> json) {
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
    iV = json['__v'];
    currOwner = json['currOwner'];
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
    data['__v'] = this.iV;
    data['currOwner'] = this.currOwner;
    return data;
  }
}
