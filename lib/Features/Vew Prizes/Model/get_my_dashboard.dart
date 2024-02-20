class GetMyDashboardModel {
	bool? success;
	UserTypeCount? userTypeCount;
	UserTicketCounts? userTicketCounts;
	Earnings? earnings;

	List<PrizeList>? prizeList;

	PrevDayEarning? prevDayEarning;

  String? error;


	GetMyDashboardModel({this.success, this.userTypeCount, this.userTicketCounts, this.earnings, this.prizeList, this.prevDayEarning,this.error});


  GetMyDashboardModel.withError(String error){
    error = error;
  }

	GetMyDashboardModel.fromJson(Map<String, dynamic> json) {
		success = json['success'];
		userTypeCount = json['userTypeCount'] != null ? UserTypeCount.fromJson(json['userTypeCount']) : null;
		userTicketCounts = json['userTicketCounts'] != null ? UserTicketCounts.fromJson(json['userTicketCounts']) : null;
		earnings = json['earnings'] != null ? Earnings.fromJson(json['earnings']) : null;
		
		if (json['prizeList'] != null) {
			prizeList = <PrizeList>[];
			json['prizeList'].forEach((v) { prizeList!.add(PrizeList.fromJson(v)); });
		}
		
	
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['success'] = success;
		if (userTypeCount != null) {
      data['userTypeCount'] = userTypeCount!.toJson();
    }
		if (userTicketCounts != null) {
      data['userTicketCounts'] = userTicketCounts!.toJson();
    }
		if (earnings != null) {
      data['earnings'] = earnings!.toJson();
    }
	
		if (prizeList != null) {
      data['prizeList'] = prizeList!.map((v) => v.toJson()).toList();
    }
	
		if (prevDayEarning != null) {
      data['prevDayEarning'] = prevDayEarning!.toJson();
    }
	
		return data;
	}
}

class UserTypeCount {
	StockistCounts? stockistCounts;

	UserTypeCount({this.stockistCounts});

	UserTypeCount.fromJson(Map<String, dynamic> json) {
		stockistCounts = json['stockistCounts'] != null ? StockistCounts.fromJson(json['stockistCounts']) : null;
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
		ticketsCount = json['ticketsCount'] != null ? TicketsCount.fromJson(json['ticketsCount']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		if (ticketsCount != null) {
      data['ticketsCount'] = ticketsCount!.toJson();
    }
		return data;
	}
}

class TicketsCount {
	int? unsold;
	int? sold;
	int? returned;
  int? total;

	TicketsCount({this.unsold, this.sold, this.returned});

	TicketsCount.fromJson(Map<String, dynamic> json) {
		unsold = json['Unsold'];
		sold = json['Sold'];
		returned = json['Returned'];
    total=json['Total'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['Unsold'] = unsold;
		data['Sold'] = sold;
		data['Returned'] = returned;
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

	PrizeList({this.sId, this.count, this.totalPrizeAmount, this.totalAgentAmount});

	PrizeList.fromJson(Map<String, dynamic> json) {
		sId = json['_id'];
		count = json['count'];
		totalPrizeAmount = json['totalPrizeAmount'];
		totalAgentAmount = json['totalAgentAmount'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['_id'] = sId;
		data['count'] = count;
		data['totalPrizeAmount'] = totalPrizeAmount;
		data['totalAgentAmount'] = totalAgentAmount;
		return data;
	}
}

class TopTickets {


	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		return data;
	}
}

class PrevDayEarning {
	String? sId;
	String? userId;
	String? ticketDate;
	List<String>? tickets;
	int? totalTickets;
	int? totalPrizeAmount;
	int? totalAgentAmount;
	bool? isTransacted;
	int? iV;
	String? drawSlotId;

	PrevDayEarning({this.sId, this.userId, this.ticketDate, this.tickets, this.totalTickets, this.totalPrizeAmount, this.totalAgentAmount, this.isTransacted, this.iV, this.drawSlotId});

	PrevDayEarning.fromJson(Map<String, dynamic> json) {
		sId = json['_id'];
		userId = json['userId'];
		ticketDate = json['ticketDate'];
		tickets = json['tickets'].cast<String>();
		totalTickets = json['totalTickets'];
		totalPrizeAmount = json['totalPrizeAmount'];
		totalAgentAmount = json['totalAgentAmount'];
		isTransacted = json['isTransacted'];
		iV = json['__v'];
		drawSlotId = json['drawSlotId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['_id'] = sId;
		data['userId'] = userId;
		data['ticketDate'] = ticketDate;
		data['tickets'] = tickets;
		data['totalTickets'] = totalTickets;
		data['totalPrizeAmount'] = totalPrizeAmount;
		data['totalAgentAmount'] = totalAgentAmount;
		data['isTransacted'] = isTransacted;
		data['__v'] = iV;
		data['drawSlotId'] = drawSlotId;
		return data;
	}
}
