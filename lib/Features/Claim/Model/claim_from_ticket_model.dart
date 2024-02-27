class ClaimFromTicketModel {
  bool? success;
  String? message;
  Ticket? ticket;
  String? error;
  

  ClaimFromTicketModel({this.success, this.message, this.ticket, this.error});

  ClaimFromTicketModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    ticket = json['ticket'] != null ? Ticket.fromJson(json['ticket']) : null;
  }

  ClaimFromTicketModel.withError(String msg) {
    error = msg;
  }
}

class Ticket {
  String? sId;
  String? ticketId;
  String? ticketLetter;
  String? ticketNumber;
  Prize? prize;
  String? drawSlotId;

  Ticket(
      {this.sId,
      this.ticketId,
      this.ticketLetter,
      this.ticketNumber,
      this.prize, this.drawSlotId});

  Ticket.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ticketId = json['ticketId'];
    ticketLetter = json['ticketLetter'];
    ticketNumber = json['ticketNumber'];
    drawSlotId=json['drawSlotId'];
    prize = json['prize'] != null ? Prize.fromJson(json['prize']) : null;
  }
}

class Prize {
  String? name;
  int? value;
  int? prizeAmount;
  int? agentAmount;

  Prize({this.name, this.value, this.prizeAmount, this.agentAmount});

  Prize.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    prizeAmount = json['prizeAmount'];
    agentAmount = json['agentAmount'];
  }
}
