class SuccessReturnTicketModel {
  String? fromLetter;
  String? toLetter;
  String? fromNumber;
  String? toNumber;
  String? date;
  bool? success;
  String? message;
  int? count;

  SuccessReturnTicketModel({
    this.fromLetter,
    this.toLetter,
    this.fromNumber,
    this.toNumber,
    this.date,
    this.success,
    this.message,
    this.count,
  });

  SuccessReturnTicketModel.fromJson(Map<String, dynamic> json) {
    fromLetter = json['fromLetter'];
    toLetter = json['toLetter'];
    fromNumber = json['fromNumber'];
    toNumber = json['toNumber'];
    date = json['date'];
    success = json['success'];
    message = json['message'];
    count = json['count'];
  }
   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromLetter'] = fromLetter;
    data['toLetter'] = toLetter;
    data['fromNumber'] = fromNumber;
    data['toNumber'] = toNumber;
    data['date'] = date;
    data['success'] = success;
    data['message'] = message;
    data['count'] = count;
    return data;
  }
}
