class LoginResponseModel {
  bool? success;
  Data? data;
  String? error;

  LoginResponseModel({this.success, this.data, this.error});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }


  LoginResponseModel.withError(String errorMsg) {
    error = errorMsg;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  String? jWT;

  Data({this.user, this.jWT});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
    jWT = json['JWT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['JWT'] = this.jWT;
    return data;
  }
}

class User {
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
  String? entryDate;
  int? iV;

  User(
      {this.sId,
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
      this.entryDate,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
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
    entryDate = json['entryDate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
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
    data['entryDate'] = entryDate;
    data['__v'] = iV;
    return data;
  }
}


class LoginRequestModel{
  final String email;
  final String password;

  const LoginRequestModel({required this.email, required this.password});

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
   
    return data;
  }
}