class PwtListModel {
  bool? success;
  List<Tickets>? tickets;
  int? count;
  Stockist? stockist;
  String? error;

  PwtListModel(
      {this.success, this.tickets, this.count, this.stockist, this.error});

  PwtListModel.withError(String e) {
    error = e;
  }

  PwtListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets!.add(Tickets.fromJson(v));
      });
    }
    count = json['count'];
    stockist =
        json['stockist'] != null ? Stockist.fromJson(json['stockist']) : null;
  }
}

class Tickets {
  String? sId;
  int? seriesCount;
  String? ticketDate;
  String? ticketNumber;
  String? firstTicketLetter;
  String? firstTicketId;
  String? lastTicketLetter;
  String? prizeName;
  int? totalAgentAmount;
  int? totalPrizeAmount;
  int? prizeAmount;

  Tickets(
      {this.sId,
      this.seriesCount,
      this.ticketDate,
      this.ticketNumber,
      this.firstTicketLetter,
      this.firstTicketId,
      this.lastTicketLetter,
      this.prizeName,
      this.totalAgentAmount,
      this.totalPrizeAmount,
      this.prizeAmount});

  Tickets.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    seriesCount = json['seriesCount'];
    ticketDate = json['ticketDate'];
    ticketNumber = json['ticketNumber'];
    firstTicketLetter = json['firstTicketLetter'];
    firstTicketId = json['firstTicketId'];
    lastTicketLetter = json['lastTicketLetter'];
    prizeName = json['prizeName'];
    totalAgentAmount = json['totalAgentAmount'];
    totalPrizeAmount = json['totalPrizeAmount'];
    prizeAmount = json['prizeAmount'];
  }
}

class Stockist {
  String? sId;
  String? fullName;
  String? aadhaarId;
  String? panNumber;
  String? address1;
  String? address2;
  String? district;
  String? pinCode;
  String? mobileNumber;
  String? userName;
  String? tradeLicenseNumber;
  String? gstNumber;
  String? purchaseRateUs;
  String? billRatePrice;
  String? email;
  String? userType;
  String? status;
  List<String>? creators;
  int? returnPercentage;
  String? city;
  String? state;
  WalletBalance? walletBalance;
  bool? acceptedTermsAndConditions;
  bool? isLocked;
  Null? lockUntil;
  String? role;
  int? loginAttempts;

  Stockist(
      {this.sId,
      this.fullName,
      this.aadhaarId,
      this.panNumber,
      this.address1,
      this.address2,
      this.district,
      this.pinCode,
      this.mobileNumber,
      this.userName,
      this.tradeLicenseNumber,
      this.gstNumber,
      this.purchaseRateUs,
      this.billRatePrice,
      this.email,
      this.userType,
      this.status,
      this.creators,
      this.returnPercentage,
      this.city,
      this.state,
      this.walletBalance,
      this.acceptedTermsAndConditions,
      this.isLocked,
      this.lockUntil,
      this.role,
      this.loginAttempts});

  Stockist.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    aadhaarId = json['aadhaarId'];
    panNumber = json['panNumber'];
    address1 = json['address1'];
    address2 = json['address2'];
    district = json['district'];
    pinCode = json['pinCode'];
    mobileNumber = json['mobileNumber'];
    userName = json['userName'];
    tradeLicenseNumber = json['tradeLicenseNumber'];
    gstNumber = json['gstNumber'];
    purchaseRateUs = json['purchaseRateUs'];
    billRatePrice = json['billRatePrice'];
    email = json['email'];
    userType = json['userType'];
    status = json['status'];
    creators = json['creators'].cast<String>();
    returnPercentage = json['returnPercentage'];
    city = json['city'];
    state = json['state'];
    walletBalance = json['walletBalance'] != null
        ? WalletBalance.fromJson(json['walletBalance'])
        : null;
    acceptedTermsAndConditions = json['acceptedTermsAndConditions'];
    isLocked = json['isLocked'];
    lockUntil = json['lockUntil'];
    role = json['role'];
    loginAttempts = json['loginAttempts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fullName'] = fullName;
    data['aadhaarId'] = aadhaarId;
    data['panNumber'] = panNumber;
    data['address1'] = address1;
    data['address2'] = address2;
    data['district'] = district;
    data['pinCode'] = pinCode;
    data['mobileNumber'] = mobileNumber;
    data['userName'] = userName;
    data['tradeLicenseNumber'] = tradeLicenseNumber;
    data['gstNumber'] = gstNumber;
    data['purchaseRateUs'] = purchaseRateUs;
    data['billRatePrice'] = billRatePrice;
    data['email'] = email;
    data['userType'] = userType;
    data['status'] = status;
    data['creators'] = creators;
    data['returnPercentage'] = returnPercentage;
    data['city'] = city;
    data['state'] = state;
    if (walletBalance != null) {
      data['walletBalance'] = walletBalance!.toJson();
    }
    data['acceptedTermsAndConditions'] = acceptedTermsAndConditions;
    data['isLocked'] = isLocked;
    data['lockUntil'] = lockUntil;
    data['role'] = role;
    data['loginAttempts'] = loginAttempts;
    return data;
  }
}

class WalletBalance {
  String? numberDecimal;

  WalletBalance({this.numberDecimal});

  WalletBalance.fromJson(Map<String, dynamic> json) {
    numberDecimal = json['$numberDecimal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$numberDecimal'] = numberDecimal;
    return data;
  }
}
