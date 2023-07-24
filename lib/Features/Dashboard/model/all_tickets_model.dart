class AllMyTicketModel {
  bool? success;
  List<Data>? data;
  String? errorMsg ;

  AllMyTicketModel({this.success, this.data});
  AllMyTicketModel.withError(String errorMsg){
      errorMsg = errorMsg;
  }

  AllMyTicketModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? ticketId;
  String? barCode;
  String? qrCode;
  String? status;
  String? date;
  String? createdAt;
  int? iV;
  int? sEM;

  Data(
      {this.sId,
      this.ticketId,
      this.barCode,
      this.qrCode,
      this.status,
      this.date,
      this.createdAt,
      this.iV,
      this.sEM});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ticketId = json['ticketId'];
    barCode = json['barCode'];
    qrCode = json['qrCode'];
    status = json['status'];
    date = json['date'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    sEM = json['SEM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['ticketId'] = this.ticketId;
    data['barCode'] = this.barCode;
    data['qrCode'] = this.qrCode;
    data['status'] = this.status;
    data['date'] = this.date;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['SEM'] = this.sEM;
    return data;
  }
}
