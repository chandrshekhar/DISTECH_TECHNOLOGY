class UserProfileModel {
  bool? success;
  User? user;
  String? errorMsg;
  UserProfileModel({this.success, this.user, this.errorMsg});
  UserProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  UserProfileModel.withError(String error){
     errorMsg = error;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
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
  String? userType;
  String? status;
  List<String>? creators;
  String? entryDate;

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
      this.userType,
      this.status,
      this.creators,
      this.entryDate});

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
    userType = json['userType'];
    status = json['status'];
    creators = json['creators'].cast<String>();
    entryDate = json['entryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['forgetPassword'] = this.forgetPassword;
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['aadhaarId'] = this.aadhaarId;
    data['panNumber'] = this.panNumber;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['pinCode'] = this.pinCode;
    data['mobileNumber'] = this.mobileNumber;
    data['tradeLicenseNumber'] = this.tradeLicenseNumber;
    data['gstNumber'] = this.gstNumber;
    data['purchaseRateUs'] = this.purchaseRateUs;
    data['billRatePrice'] = this.billRatePrice;
    data['email'] = this.email;
    data['userType'] = this.userType;
    data['status'] = this.status;
    data['creators'] = this.creators;
    data['entryDate'] = this.entryDate;
    return data;
  }
}
