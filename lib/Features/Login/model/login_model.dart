class LoginResponseModel {
  bool? success;
  User? user;
  String? jWT;
  String? error;

  LoginResponseModel({this.success, this.user, this.jWT, this.error});

  LoginResponseModel.withError(String errorMsg) {
    error = errorMsg;
  }

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    jWT = json['JWT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['JWT'] = jWT;
    return data;
  }
}

class User {
  Object? forgetPassword;
  String? sId;
  String? fullName;
  String? aadhaarId;
  String? panNumber;
  String? address1;
  String? address2;
  String? pinCode;
  String? mobileNumber;
  String? tradeLicenseNumber;
  String? gstNumber;
  String? purchaseRateUs;
  String? billRatePrice;
  String? email;
  String? password;
  String? userType;
  String? status;
  List<String>? creators;
  String? entryDate;
  int? iV;

  User(
      {this.forgetPassword,
      this.sId,
      this.fullName,
      this.aadhaarId,
      this.panNumber,
      this.address1,
      this.address2,
      this.pinCode,
      this.mobileNumber,
      this.tradeLicenseNumber,
      this.gstNumber,
      this.purchaseRateUs,
      this.billRatePrice,
      this.email,
      this.password,
      this.userType,
      this.status,
      this.creators,
      this.entryDate,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    forgetPassword = json['forgetPassword'];
    sId = json['_id'];
    fullName = json['fullName'];
    aadhaarId = json['aadhaarId'];
    panNumber = json['panNumber'];
    address1 = json['address1'];
    address2 = json['address2'];
    pinCode = json['pinCode'];
    mobileNumber = json['mobileNumber'];
    tradeLicenseNumber = json['tradeLicenseNumber'];
    gstNumber = json['gstNumber'];
    purchaseRateUs = json['purchaseRateUs'];
    billRatePrice = json['billRatePrice'];
    email = json['email'];
    password = json['password'];
    userType = json['userType'];
    status = json['status'];
    creators = json['creators'].cast<String>();
    entryDate = json['entryDate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['forgetPassword'] = forgetPassword;
    data['_id'] = sId;
    data['fullName'] = fullName;
    data['aadhaarId'] = aadhaarId;
    data['panNumber'] = panNumber;
    data['address1'] = address1;
    data['address2'] = address2;
    data['pinCode'] = pinCode;
    data['mobileNumber'] = mobileNumber;
    data['tradeLicenseNumber'] = tradeLicenseNumber;
    data['gstNumber'] = gstNumber;
    data['purchaseRateUs'] = purchaseRateUs;
    data['billRatePrice'] = billRatePrice;
    data['email'] = email;
    data['password'] = password;
    data['userType'] = userType;
    data['status'] = status;
    data['creators'] = creators;
    data['entryDate'] = entryDate;
    data['__v'] = iV;
    return data;
  }
}
