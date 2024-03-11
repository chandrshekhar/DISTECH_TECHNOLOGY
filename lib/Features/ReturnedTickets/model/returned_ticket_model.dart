class ReturnedTicketModel {
  bool? success;
  List<AllReturnedTickets>? allReturnedTickets;
  int? returnedCount;
  int? unsoldCount;
  int? remainingReturns;
  int? pageCount;
  String? errorMsg;

  ReturnedTicketModel(
      {this.success,
      this.allReturnedTickets,
      this.returnedCount,
      this.unsoldCount,
      this.remainingReturns,
      this.pageCount,
      this.errorMsg});

  ReturnedTicketModel.withError(String error) {
    errorMsg = error;
  }

  ReturnedTicketModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['allReturnedTickets'] != null) {
      allReturnedTickets = <AllReturnedTickets>[];
      json['allReturnedTickets'].forEach((v) {
        allReturnedTickets!.add(AllReturnedTickets.fromJson(v));
      });
    }
    returnedCount = json['returnedCount'];
    unsoldCount = json['unsoldCount'];
    remainingReturns = json['remainingReturns'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (allReturnedTickets != null) {
      data['allReturnedTickets'] =
          allReturnedTickets!.map((v) => v.toJson()).toList();
    }
    data['returnedCount'] = returnedCount;
    data['unsoldCount'] = unsoldCount;
    data['remainingReturns'] = remainingReturns;
    data['pageCount'] = pageCount;
    return data;
  }
}

class AllReturnedTickets {
  String? sId;
  String? uid;
  String? returnedBy;
  String? owner;
  String? fromLetter;
  String? toLetter;
  String? fromNumber;
  String? toNumber;
  int? count;
  String? ticketDate;
  String? createdAt;
  String? status;
  bool? isManual;

  AllReturnedTickets(
      {this.sId,
      this.uid,
      this.returnedBy,
      this.owner,
      this.fromLetter,
      this.toLetter,
      this.fromNumber,
      this.toNumber,
      this.count,
      this.ticketDate,
      this.createdAt,
      this.status,
      this.isManual});

  AllReturnedTickets.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    uid = json['uid'];
    returnedBy = json['returnedBy'];
    owner = json['owner'];

    fromLetter = json['fromLetter'];
    toLetter = json['toLetter'];
    fromNumber = json['fromNumber'];
    toNumber = json['toNumber'];
    count = json['count'];
    ticketDate = json['ticketDate'];
    createdAt = json['createdAt'];
    status = json['status'];
    isManual = json['isManual'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['uid'] = uid;
    data['returnedBy'] = returnedBy;
    data['owner'] = owner;

    data['fromLetter'] = fromLetter;
    data['toLetter'] = toLetter;
    data['fromNumber'] = fromNumber;
    data['toNumber'] = toNumber;
    data['count'] = count;
    data['ticketDate'] = ticketDate;
    data['createdAt'] = createdAt;
    data['status'] = status;
    data['isManual'] = isManual;
    return data;
  }
}
