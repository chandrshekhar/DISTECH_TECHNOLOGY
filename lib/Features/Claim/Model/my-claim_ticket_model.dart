class MyClaimTicketModel {
  bool? success;
  List<Claims>? claims;
  int? count;
  List<ClaimsData>? claimsData;
  ClaimCounts? claimCounts;
  String? errorMsg;

  MyClaimTicketModel(
      {this.success,
      this.claims,
      this.count,
      this.claimsData,
      this.claimCounts,
      this.errorMsg});

  MyClaimTicketModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['claims'] != null) {
      claims = <Claims>[];
      json['claims'].forEach((v) {
        claims!.add(Claims.fromJson(v));
      });
    }
    count = json['count'];
    if (json['claimsData'] != null) {
      claimsData = <ClaimsData>[];
      json['claimsData'].forEach((v) {
        claimsData!.add(ClaimsData.fromJson(v));
      });
    }
    claimCounts = json['claimCounts'] != null
        ? ClaimCounts.fromJson(json['claimCounts'])
        : null;
  }

  MyClaimTicketModel.withError(String err) {
    errorMsg = err;
  }
}

class Claims {
  String? ticketDate;
  int? count;

  Claims({this.ticketDate, this.count});

  Claims.fromJson(Map<String, dynamic> json) {
    ticketDate = json['ticketDate'];
    count = json['count'];
  }
}

class ClaimsData {
  int? claimCount;
  String? date;
  int? all;
  int? approved;
  int? modified;
  int? pending;
  int? rejected;
  int? claims;

  ClaimsData(
      {this.claimCount,
      this.date,
      this.all,
      this.approved,
      this.modified,
      this.pending,
      this.rejected,
      this.claims});

  ClaimsData.fromJson(Map<String, dynamic> json) {
    claimCount = json['claimCount'];
    date = json['date'];
    all = json['all'];
    approved = json['approved'];
    modified = json['modified'];
    pending = json['pending'];
    rejected = json['rejected'];
    claims = json['claims'];
  }
}

class ClaimCounts {
  int? total;
  int? pending;
  int? approved;

  ClaimCounts({this.total, this.pending, this.approved});

  ClaimCounts.fromJson(Map<String, dynamic> json) {
    total = json['Total'];
    pending = json['Pending'];
    approved = json['Approved'];
  }
}
