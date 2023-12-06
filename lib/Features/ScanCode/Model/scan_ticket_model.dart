class ScanTicketModel {
  bool? success;
  Ticket? ticket;
  String? error;

  ScanTicketModel({this.success, this.ticket, this.error});

  ScanTicketModel.withError(String? err) {
    error = err;
  }

  ScanTicketModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    ticket = json['ticket'] != null ? Ticket.fromJson(json['ticket']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (ticket != null) {
      data['ticket'] = ticket!.toJson();
    }
    return data;
  }
}

class Ticket {
  String? sId;
  String? ticketId;
  String? ticketLetter;
  String? ticketNumber;
  int? sEM;
  String? status;
  List<Sellers>? sellers;
  String? date;
  String? createdAt;
  CurrOwner? currOwner;
  Order? order;
  Prize? prize;

  Ticket(
      {this.sId,
      this.ticketId,
      this.ticketLetter,
      this.ticketNumber,
      this.sEM,
      this.status,
      this.sellers,
      this.date,
      this.createdAt,
      this.currOwner,
      this.order,
      this.prize});

  Ticket.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ticketId = json['ticketId'];
    ticketLetter = json['ticketLetter'];
    ticketNumber = json['ticketNumber'];
    sEM = json['SEM'];
    status = json['status'];
    if (json['sellers'] != null) {
      sellers = <Sellers>[];
      json['sellers'].forEach((v) {
        sellers!.add(Sellers.fromJson(v));
      });
    }
    date = json['date'];
    createdAt = json['createdAt'];
    currOwner = json['currOwner'] != null
        ? CurrOwner.fromJson(json['currOwner'])
        : null;
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    prize = json['prize'] != null ? Prize.fromJson(json['prize']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['ticketId'] = ticketId;
    data['ticketLetter'] = ticketLetter;
    data['ticketNumber'] = ticketNumber;
    data['SEM'] = sEM;
    data['status'] = status;
    if (sellers != null) {
      data['sellers'] = sellers!.map((v) => v.toJson()).toList();
    }
    data['date'] = date;
    data['createdAt'] = createdAt;
    if (currOwner != null) {
      data['currOwner'] = currOwner!.toJson();
    }
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (prize != null) {
      data['prize'] = prize!.toJson();
    }
    return data;
  }
}

class Sellers {
  String? sId;
  String? fullName;
  String? address1;
  String? address2;
  String? email;
  String? userType;
  String? city;
  String? state;

  Sellers(
      {this.sId,
      this.fullName,
      this.address1,
      this.address2,
      this.email,
      this.userType,
      this.city,
      this.state});

  Sellers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    address1 = json['address1'];
    address2 = json['address2'];
    email = json['email'];
    userType = json['userType'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fullName'] = fullName;
    data['address1'] = address1;
    data['address2'] = address2;
    data['email'] = email;
    data['userType'] = userType;
    data['city'] = city;
    data['state'] = state;
    return data;
  }
}

class CurrOwner {
  String? sId;
  String? fullName;
  String? address1;
  String? address2;
  String? email;
  String? userType;
  String? city;
  String? userName;

  CurrOwner(
      {this.sId,
      this.fullName,
      this.address1,
      this.address2,
      this.email,
      this.userType,
      this.city,
      this.userName});

  CurrOwner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    address1 = json['address1'];
    address2 = json['address2'];
    email = json['email'];
    userType = json['userType'];
    city = json['city'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fullName'] = fullName;
    data['address1'] = address1;
    data['address2'] = address2;
    data['email'] = email;
    data['userType'] = userType;
    data['city'] = city;
    data['userName'] = userName;
    return data;
  }
}

class Order {
  String? sId;

  Order({this.sId});

  Order.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    data['prizeAmount'] = prizeAmount;
    data['agentAmount'] = agentAmount;
    return data;
  }
}
