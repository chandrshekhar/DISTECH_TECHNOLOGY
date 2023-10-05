class ReturnTicketsResponseModel {
  bool success = false;
  String? error;
  List<ReturnedSeriesList>? returnedSeriesList;
  List<FailedSeriesList>? failedSeriesList;

  ReturnTicketsResponseModel(
      {required this.success,
      this.returnedSeriesList,
      this.failedSeriesList,
      this.error});

  ReturnTicketsResponseModel.withError(String errorMsg) {
    error = errorMsg;
  }

  ReturnTicketsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['returnedSeriesList'] != null) {
      returnedSeriesList = <ReturnedSeriesList>[];
      json['returnedSeriesList'].forEach((v) {
        returnedSeriesList!.add(ReturnedSeriesList.fromJson(v));
      });
    }
    if (json['failedSeriesList'] != null) {
      failedSeriesList = <FailedSeriesList>[];
      json['failedSeriesList'].forEach((v) {
        failedSeriesList!.add(FailedSeriesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (returnedSeriesList != null) {
      data['returnedSeriesList'] =
          returnedSeriesList!.map((v) => v.toJson()).toList();
    }
    if (failedSeriesList != null) {
      data['failedSeriesList'] =
          failedSeriesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReturnedSeriesList {
  String? fromLetter;
  String? toLetter;
  String? fromNumber;
  String? toNumber;
  bool? success;
  String? date;

  ReturnedSeriesList(
      {this.fromLetter,
      this.toLetter,
      this.fromNumber,
      this.toNumber,
      this.success,
      this.date});

  ReturnedSeriesList.fromJson(Map<String, dynamic> json) {
    fromLetter = json['fromLetter'];
    toLetter = json['toLetter'];
    fromNumber = json['fromNumber'];
    toNumber = json['toNumber'];
    success = json['success'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromLetter'] = fromLetter;
    data['toLetter'] = toLetter;
    data['fromNumber'] = fromNumber;
    data['toNumber'] = toNumber;
    data['success'] = success;
    data['date'] = date;
    return data;
  }
}

class FailedSeriesList {
  String? fromLetter;
  String? toLetter;
  String? fromNumber;
  String? toNumber;
  bool? success;
  String? date;
  String? userId;

  FailedSeriesList(
      {this.fromLetter,
      this.toLetter,
      this.fromNumber,
      this.toNumber,
      this.success,
      this.date,
      this.userId});

  FailedSeriesList.fromJson(Map<String, dynamic> json) {
    fromLetter = json['fromLetter'];
    toLetter = json['toLetter'];
    fromNumber = json['fromNumber'];
    toNumber = json['toNumber'];
    success = json['success'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromLetter'] = fromLetter;
    data['toLetter'] = toLetter;
    data['fromNumber'] = fromNumber;
    data['toNumber'] = toNumber;
    data['success'] = success;
    data['date'] = date;
    data['userId'] = userId;
    return data;
  }
}
