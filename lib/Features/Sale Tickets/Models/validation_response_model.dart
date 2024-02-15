// class ValidateReturnTickets {
//   bool? success;
//   List<SuccessList>? successList;
//   List<FailedList>? failedList;

//   ValidateReturnTickets({this.success, this.successList, this.failedList});

//   ValidateReturnTickets.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['successList'] != null) {
//       successList = <SuccessList>[];
//       json['successList'].forEach((v) {
//         successList!.add(SuccessList.fromJson(v));
//       });
//     }
//     if (json['failedList'] != null) {
//       failedList = <FailedList>[];
//       json['failedList'].forEach((v) {
//         failedList!.add(FailedList.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['success'] = success;
//     if (successList != null) {
//       data['successList'] = successList!.map((v) => v.toJson()).toList();
//     }
//     if (failedList != null) {
//       data['failedList'] = failedList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class SuccessList {
//   String? fromLetter;
//   String? toLetter;
//   String? fromNumber;
//   String? toNumber;
//   String? date;
//   bool? success;
//   String? message;
//   int? count;
//   UpdateFilter? updateFilter;
//   Query? query;

//   SuccessList(
//       {this.fromLetter,
//       this.toLetter,
//       this.fromNumber,
//       this.toNumber,
//       this.date,
//       this.success,
//       this.message,
//       this.count,
//       this.updateFilter,
//       this.query});

//   SuccessList.fromJson(Map<String, dynamic> json) {
//     fromLetter = json['fromLetter'];
//     toLetter = json['toLetter'];
//     fromNumber = json['fromNumber'];
//     toNumber = json['toNumber'];
//     date = json['date'];
//     success = json['success'];
//     message = json['message'];
//     count = json['count'];
//     updateFilter = json['updateFilter'] != null
//         ? UpdateFilter.fromJson(json['updateFilter'])
//         : null;
//     query = json['query'] != null ? Query.fromJson(json['query']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['fromLetter'] = fromLetter;
//     data['toLetter'] = toLetter;
//     data['fromNumber'] = fromNumber;
//     data['toNumber'] = toNumber;
//     data['date'] = date;
//     data['success'] = success;
//     data['message'] = message;
//     data['count'] = count;
//     if (updateFilter != null) {
//       data['updateFilter'] = updateFilter!.toJson();
//     }
//     if (query != null) {
//       data['query'] = query!.toJson();
//     }
//     return data;
//   }
// }

// class UpdateFilter {
//   TicketLetter? ticketLetter;
//   TicketLetter? ticketNumber;
//   String? date;
//   String? currOwner;
//   List<And>? and;

//   UpdateFilter(
//       {this.ticketLetter,
//       this.ticketNumber,
//       this.date,
//       this.currOwner,
//       this.and});

//   UpdateFilter.fromJson(Map<String, dynamic> json) {
//     ticketLetter = json['ticketLetter'] != null
//         ? TicketLetter.fromJson(json['ticketLetter'])
//         : null;
//     ticketNumber = json['ticketNumber'] != null
//         ? TicketLetter.fromJson(json['ticketNumber'])
//         : null;
//     date = json['date'];
//     currOwner = json['currOwner'];
//     if (json['$and'] != null) {
//       and = <And>[];
//       json['$and'].forEach((v) {
//         and!.add(And.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (ticketLetter != null) {
//       data['ticketLetter'] = ticketLetter!.toJson();
//     }
//     if (ticketNumber != null) {
//       data['ticketNumber'] = ticketNumber!.toJson();
//     }
//     data['date'] = date;
//     data['currOwner'] = currOwner;
//     if (and != null) {
//       data['$and'] = and!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class TicketLetter {
//   String? gte;
//   String? lte;

//   TicketLetter({this.gte, this.lte});

//   TicketLetter.fromJson(Map<String, dynamic> json) {
//     gte = json['$gte'];
//     lte = json['$lte'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['$gte'] = gte;
//     data['$lte'] = lte;
//     return data;
//   }
// }

// class And {
//   Status? status;

//   And({this.status});

//   And.fromJson(Map<String, dynamic> json) {
//     status = json['status'] != null ? Status.fromJson(json['status']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (status != null) {
//       data['status'] = status!.toJson();
//     }
//     return data;
//   }
// }

// class Status {
//   String? ne;

//   Status({this.ne});

//   Status.fromJson(Map<String, dynamic> json) {
//     ne = json['$ne'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['$ne'] = ne;
//     return data;
//   }
// }

// class Query {
//   TicketLetter? ticketLetter;
//   TicketLetter? ticketNumber;
//   String? date;

//   Query({this.ticketLetter, this.ticketNumber, this.date});

//   Query.fromJson(Map<String, dynamic> json) {
//     ticketLetter = json['ticketLetter'] != null
//         ? TicketLetter.fromJson(json['ticketLetter'])
//         : null;
//     ticketNumber = json['ticketNumber'] != null
//         ? TicketLetter.fromJson(json['ticketNumber'])
//         : null;
//     date = json['date'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (ticketLetter != null) {
//       data['ticketLetter'] = ticketLetter!.toJson();
//     }
//     if (ticketNumber != null) {
//       data['ticketNumber'] = ticketNumber!.toJson();
//     }
//     data['date'] = date;
//     return data;
//   }
// }

// class FailedList {
//   String? fromLetter;
//   String? toLetter;
//   String? fromNumber;
//   String? toNumber;
//   String? date;
//   bool? success;
//   String? message;

//   FailedList(
//       {this.fromLetter,
//       this.toLetter,
//       this.fromNumber,
//       this.toNumber,
//       this.date,
//       this.success,
//       this.message});

//   FailedList.fromJson(Map<String, dynamic> json) {
//     fromLetter = json['fromLetter'];
//     toLetter = json['toLetter'];
//     fromNumber = json['fromNumber'];
//     toNumber = json['toNumber'];
//     date = json['date'];
//     success = json['success'];
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['fromLetter'] = fromLetter;
//     data['toLetter'] = toLetter;
//     data['fromNumber'] = fromNumber;
//     data['toNumber'] = toNumber;
//     data['date'] = date;
//     data['success'] = success;
//     data['message'] = message;
//     return data;
//   }
// }
