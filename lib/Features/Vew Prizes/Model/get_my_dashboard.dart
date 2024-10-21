class GetMyDashboardModel {
  bool? success;
  UserTypeCount? userTypeCount;
  UserTicketCounts? userTicketCounts;
  Earnings? earnings;
  List<PrizeList>? prizeList;
  List<List>? topTickets;
  PrevDayEarning? prevDayEarning;

  GetMyDashboardModel(
      {this.success,
      this.userTypeCount,
      this.userTicketCounts,
      this.earnings,
      this.prizeList,
      this.topTickets,
      this.prevDayEarning});

  GetMyDashboardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    userTypeCount = json['userTypeCount'] != null
        ? UserTypeCount.fromJson(json['userTypeCount'])
        : null;
    userTicketCounts = json['userTicketCounts'] != null
        ? UserTicketCounts.fromJson(json['userTicketCounts'])
        : null;
    earnings =
        json['earnings'] != null ? Earnings.fromJson(json['earnings']) : null;

    if (json['prizeList'] != null) {
      prizeList = <PrizeList>[];
      json['prizeList'].forEach((v) {
        prizeList!.add(PrizeList.fromJson(v));
      });
    }
  }
}

class UserTypeCount {
  StockistCounts? stockistCounts;

  UserTypeCount({this.stockistCounts});

  UserTypeCount.fromJson(Map<String, dynamic> json) {
    stockistCounts = json['stockistCounts'] != null
        ? StockistCounts.fromJson(json['stockistCounts'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stockistCounts != null) {
      data['stockistCounts'] = stockistCounts!.toJson();
    }
    return data;
  }
}

class StockistCounts {
  int? total;

  StockistCounts({this.total});

  StockistCounts.fromJson(Map<String, dynamic> json) {
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    return data;
  }
}

class UserTicketCounts {
  TicketsCount? ticketsCount;

  UserTicketCounts({this.ticketsCount});

  UserTicketCounts.fromJson(Map<String, dynamic> json) {
    ticketsCount = json['ticketsCount'] != null
        ? TicketsCount.fromJson(json['ticketsCount'])
        : null;
  }
}

class TicketsCount {
  int? unsold;
  int? sold;
  int? returned;
  int? total;

  TicketsCount({this.unsold, this.sold, this.returned, this.total});

  TicketsCount.fromJson(Map<String, dynamic> json) {
    unsold = json['Unsold'];
    sold = json['Sold'];
    returned = json['Returned'];
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Unsold'] = unsold;
    data['Sold'] = sold;
    data['Returned'] = returned;
    data['Total'] = total;
    return data;
  }
}

class Earnings {
  String? ticketDate;
  int? totalPrizeAmount;
  int? totalAgentAmount;

  Earnings({this.ticketDate, this.totalPrizeAmount, this.totalAgentAmount});

  Earnings.fromJson(Map<String, dynamic> json) {
    ticketDate = json['ticketDate'];
    totalPrizeAmount = json['totalPrizeAmount'];
    totalAgentAmount = json['totalAgentAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticketDate'] = ticketDate;
    data['totalPrizeAmount'] = totalPrizeAmount;
    data['totalAgentAmount'] = totalAgentAmount;
    return data;
  }
}

class PrizeList {
  String? sId;
  int? count;
  int? totalPrizeAmount;
  int? totalAgentAmount;

  PrizeList(
      {this.sId, this.count, this.totalPrizeAmount, this.totalAgentAmount});

  PrizeList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    count = json['count'];
    totalPrizeAmount = json['totalPrizeAmount'];
    totalAgentAmount = json['totalAgentAmount'];
  }
}

class PrevDayEarning {
  String? sId;
  String? userId;
  String? ticketDate;
  String? drawSlotId;
  List<String>? tickets;
  int? totalTickets;
  int? totalPrizeAmount;
  int? totalAgentAmount;
  bool? isTransacted;
  bool? isRedeemed;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PrevDayEarning(
      {this.sId,
      this.userId,
      this.ticketDate,
      this.drawSlotId,
      this.tickets,
      this.totalTickets,
      this.totalPrizeAmount,
      this.totalAgentAmount,
      this.isTransacted,
      this.isRedeemed,
      this.createdAt,
      this.updatedAt,
      this.iV});

  PrevDayEarning.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    ticketDate = json['ticketDate'];
    drawSlotId = json['drawSlotId'];
    tickets = json['tickets'].cast<String>();
    totalTickets = json['totalTickets'];
    totalPrizeAmount = json['totalPrizeAmount'];
    totalAgentAmount = json['totalAgentAmount'];
    isTransacted = json['isTransacted'];
    isRedeemed = json['isRedeemed'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
