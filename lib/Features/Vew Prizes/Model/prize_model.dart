class GetPrizeModel {
  bool? success;
  ResultList? resultList;
  String? date;
  Prizes? prizes;
  String? time;
  String? error;

  GetPrizeModel(
      {this.success,
      this.resultList,
      this.date,
      this.prizes,
      this.time,
      this.error});

  GetPrizeModel.withError(String err) {
    error = err;
  }

  GetPrizeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    resultList = json['resultList'] != null
        ? ResultList.fromJson(json['resultList'])
        : null;
    date = json['date'];
    prizes = json['prizes'] != null ? Prizes.fromJson(json['prizes']) : null;
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (resultList != null) {
      data['resultList'] = resultList!.toJson();
    }
    data['date'] = date;
    if (prizes != null) {
      data['prizes'] = prizes!.toJson();
    }
    data['time'] = time;
    return data;
  }
}

class ResultList {
  String? sId;
  String? name;
  String? date;
  String? time;
  String? drawSlotId;
  Result? result;
  int? iV;

  ResultList(
      {this.sId,
      this.name,
      this.date,
      this.time,
      this.drawSlotId,
      this.result,
      this.iV});

  ResultList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    date = json['date'];
    time = json['time'];
    drawSlotId = json['drawSlotId'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['date'] = date;
    data['time'] = time;
    data['drawSlotId'] = drawSlotId;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['__v'] = iV;
    return data;
  }
}

class Result {
  List<String>? firstPrize;
  List<String>? secondPrize;
  List<String>? thirdPrize;
  List<String>? fourthPrize;
  List<String>? fifthPrize;

  Result({
    this.firstPrize,
    this.secondPrize,
    this.thirdPrize,
    this.fourthPrize,
    this.fifthPrize,
  });

  Result.fromJson(Map<String, dynamic> json) {
    firstPrize = json['firstPrize'].cast<String>();
    secondPrize = json['secondPrize'].cast<String>();
    thirdPrize = json['thirdPrize'].cast<String>();
    fourthPrize = json['fourthPrize'].cast<String>();
    fifthPrize = json['fifthPrize'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstPrize'] = firstPrize;
    data['secondPrize'] = secondPrize;
    data['thirdPrize'] = thirdPrize;
    data['fourthPrize'] = fourthPrize;
    data['fifthPrize'] = fifthPrize;

    return data;
  }
}

class Prizes {
  String? sId;
  String? type;
  String? fromDate;
  WinningPrize? winningPrize;
  WinningPrize? agentPrize;
  String? drawSlotId;
  String? createdAt;
  String? updatedAt;

  Prizes(
      {this.sId,
      this.type,
      this.fromDate,
      this.winningPrize,
      this.agentPrize,
      this.drawSlotId,
      this.createdAt,
      this.updatedAt});

  Prizes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    fromDate = json['fromDate'];
    winningPrize = json['winningPrize'] != null
        ? WinningPrize.fromJson(json['winningPrize'])
        : null;
    agentPrize = json['agentPrize'] != null
        ? WinningPrize.fromJson(json['agentPrize'])
        : null;
    drawSlotId = json['drawSlotId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['type'] = type;
    data['fromDate'] = fromDate;
    if (winningPrize != null) {
      data['winningPrize'] = winningPrize!.toJson();
    }
    if (agentPrize != null) {
      data['agentPrize'] = agentPrize!.toJson();
    }
    data['drawSlotId'] = drawSlotId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class WinningPrize {
  int? firstPrize;
  int? secondPrize;
  int? thirdPrize;
  int? fourthPrize;
  int? fifthPrize;

  WinningPrize(
      {this.firstPrize,
      this.secondPrize,
      this.thirdPrize,
      this.fourthPrize,
      this.fifthPrize});

  WinningPrize.fromJson(Map<String, dynamic> json) {
    firstPrize = json['firstPrize'];
    secondPrize = json['secondPrize'];
    thirdPrize = json['thirdPrize'];
    fourthPrize = json['fourthPrize'];
    fifthPrize = json['fifthPrize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstPrize'] = firstPrize;
    data['secondPrize'] = secondPrize;
    data['thirdPrize'] = thirdPrize;
    data['fourthPrize'] = fourthPrize;
    data['fifthPrize'] = fifthPrize;
    return data;
  }
}
