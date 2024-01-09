import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:distech_technology/Api/urls.dart';
import 'package:distech_technology/Features/Claim/Model/claim_from_ticket_model.dart';
import 'package:distech_technology/Features/Claim/Model/claim_to_tickets_model.dart';
import 'package:distech_technology/Features/Claim/Model/my-claim_ticket_model.dart';
import 'package:distech_technology/Features/Dashboard/model/all_tickets_model.dart';
import 'package:distech_technology/Features/Login/model/login_model.dart';
import 'package:distech_technology/Features/Profile/model/profile_model.dart';
import 'package:distech_technology/Features/PurchaseHistory/Model/purchase_history_details_model.dart';
import 'package:distech_technology/Features/ReturnUnsoldTicket/Model/return_tickets_response_model.dart';
import 'package:distech_technology/Utils/storage/local_storage.dart';
import 'package:flutter/foundation.dart';

import '../Features/PurchaseHistory/Model/purchase_hostory_model.dart';
import '../Features/ReturnedTickets/model/returned_ticket_model.dart';
import '../Features/ScanCode/Model/scan_ticket_model.dart';
import '../Features/SoldTicket/Models/sold_ticket_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  LocalStorageService localStorageService = LocalStorageService();

  ///--------- Login -----///
  Future<LoginResponseModel> loginApiCall(Map<String, dynamic> reqModel) async {
    Response response;
    if (kDebugMode) {
      print("login reqModel--> $reqModel");
    }
    try {
      _dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
      response = await _dio.post(Urls.loginUrl, data: reqModel);
      if (kDebugMode) {
        log('--------Response Login : $response');
      }
      return response.statusCode == 200
          ? LoginResponseModel.fromJson(response.data)
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return LoginResponseModel.withError(
          "You are offline. Please check your internet connection.");
    }
  }

  ///--------- Forget password-----///
  Future<Map> forgetPassword(String email) async {
    Map<String, dynamic> reqModel = {"email": email.trim()};
    Response response;
    try {
      _dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
      response = await _dio.post(Urls.forgetPassword, data: reqModel);
      if (kDebugMode) {
        log('--------Response forgetPassword : ${response.data}');
      }
      return response.statusCode == 200
          ? response.data
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return {"success": false, "error": error};
    }
  }

  ///--------- veryfie otp-----///
  Future<Map> verifyOtp(String email, String otp) async {
    Map<String, dynamic> reqModel = {"email": email.trim(), 'otp': otp};
    Response response;
    try {
      _dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
      response = await _dio.post(Urls.verifyOtp, data: reqModel);
      if (kDebugMode) {
        log('--------Response forgetPassword : ${response.data}');
      }
      return response.statusCode == 200
          ? response.data
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return {"success": false, "error": error};
    }
  }

  ///--------- veryfie otp-----///
  Future<Map> resetPassword(String email, String password,
      String confirmPassword, String slug) async {
    Map<String, dynamic> reqModel = {
      'slug': slug,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword
    };
    Response response;
    try {
      _dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
      response = await _dio.post(Urls.resetPassword, data: reqModel);
      if (kDebugMode) {
        log('--------Response forgetPassword : ${response.data}');
      }
      return response.statusCode == 200
          ? response.data
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return {"success": false, "error": error};
    }
  }

  ///--------- get all Ticket -----///
  Future<AllMyTicketModel> getAllTicket(Map<String, dynamic> reqModel) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";
    try {
      _dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "access-token": token
      };
      response = await _dio.post(Urls.getAllTicket, data: reqModel);
      if (kDebugMode) {
        log('--------Response Login : $response');
      }
      return response.statusCode == 200
          ? AllMyTicketModel.fromJson(response.data)
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return AllMyTicketModel.withError(
          "You are offline. Please check your internet connection.");
    }
  }

  Future<SoldTicketModel> getAllSoldTicket(
      Map<String, dynamic> reqModel) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";

    try {
      _dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "access-token": token
      };
      response = await _dio.post(Urls.soldTicketList, data: reqModel);
      if (kDebugMode) {
        log('--------Response sold : $response');
      }
      return response.statusCode == 200
          ? SoldTicketModel.fromJson(response.data)
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return SoldTicketModel.withError(error.toString());
    }
  }

  Future<PurchaesModel> getAllPurcHistoryTicket(
      Map<String, dynamic> reqModel) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";

    try {
      _dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "access-token": token
      };
      response = await _dio.post(Urls.purchaseHistory, data: reqModel);
      if (kDebugMode) {
        log('--------Response sold : $response');
      }
      return response.statusCode == 200
          ? PurchaesModel.fromJson(response.data)
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return PurchaesModel.withError(
          "You are offline. Please check your internet connection.");
    }
  }

  Future<MyClaimTicketModel> getMyClaims(Map<String, dynamic> reqModel) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";

    try {
      _dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "access-token": token
      };
      log("req --> $reqModel");
      response = await _dio.post(Urls.getMyclaims, data: reqModel);
      if (kDebugMode) {
        log('--------Response sold : $response');
      }
      return response.statusCode == 200
          ? MyClaimTicketModel.fromJson(response.data)
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return MyClaimTicketModel.withError(
          "You are offline. Please check your internet connection.");
    }
  }

  /// get purchase details ------- ///
  Future<PurchaseHistoryTicketDetailsModel> getAllPurcHistoryTicketDetails(
      Map<String, dynamic> reqModel) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";

    try {
      _dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "access-token": token
      };
      response = await _dio.post(Urls.getAllPurchaseDetails, data: reqModel);
      if (kDebugMode) {
        log('--------Response sold : $response');
      }
      return response.statusCode == 200
          ? PurchaseHistoryTicketDetailsModel.fromJson(response.data)
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return PurchaseHistoryTicketDetailsModel.withError(
          "You are offline. Please check your internet connection.");
    }
  }

  /// ----------  sold  Ticket --------------///
  Future<Map<String, dynamic>> soldTciket(
      List<String> returnTicketIdList, String? date) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";
    Map<String, dynamic> resData = {
      "success": false,
      "message": "No Tickets Found"
    };

    Map<String, dynamic> reqModel = (date == null || date.isEmpty)
        ? {
            "tickets": returnTicketIdList,
          }
        : {"tickets": returnTicketIdList, "date": date};
    try {
      _dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "access-token": token
      };
      response = await _dio.post(Urls.markAsSold, data: reqModel);
      if (kDebugMode) {
        log('--------Response Login : $response');
      }

      if (response.statusCode == 200) {
        resData = response.data;
        return resData;
      } else {
        return resData;
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return resData;
    }
  }

  Future<ReturnTicketsResponseModel> retunTicketUnsold(
      List<FailedSeriesList> returnTicketIdList,
      String date,
      String userId) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";
    Map<String, dynamic> resData = {
      "success": false,
      "message": "No Tickets Found"
    };

    Map<String, dynamic> reqModel = {
      "userId": userId,
      "returnList": returnTicketIdList,
      "date": date
    };
    try {
      _dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "access-token": token
      };
      response = await _dio.post(Urls.returnSeriesList, data: reqModel);
      if (kDebugMode) {
        log('--------Response returnTicket : $response');
      }

      if (response.statusCode == 200) {
        resData = response.data;
        return ReturnTicketsResponseModel.fromJson(resData);
      } else {
        return ReturnTicketsResponseModel.withError("Something went wrong");
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return ReturnTicketsResponseModel.withError(error.toString());
    }
  }

  ///------------- get server Time---------------///
  Future<Map<String, dynamic>> getServerTime() async {
    Response response;
    String? authToken;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";

    try {
      _dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "access-token": token
      };
      response = await _dio.get(
        Urls.serverTime,
      );
      if (kDebugMode) {
        log('--------Response time : $response');
      }
      return response.statusCode == 200
          ? response.data
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return {};
    }
  }

  ///--------- get User Details -----///
  Future<UserProfileModel> getUserDetails() async {
    Response response;
    String? authToken;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";

    try {
      _dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "access-token": token
      };
      response = await _dio.get(
        Urls.getUserDetails,
      );
      if (kDebugMode) {
        log('--------Response Login : $response');
      }
      return response.statusCode == 200
          ? UserProfileModel.fromJson(response.data)
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return UserProfileModel.withError(
          "You are offline. Please check your internet connection.");
    }
  }

  Future<bool> editProfile(Map<String, dynamic> reqModel) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";
    try {
      _dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "access-token": token
      };
      response = await _dio.post(Urls.editProfile, data: jsonEncode(reqModel));
      if (kDebugMode) {
        log('--------Response : $response');
      }

      return response.statusCode == 200
          ? true
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return false;
    }
  }

  /// check ticket avaliabilty
  Future<Map<String, dynamic>> verifyTicket(String barCode, String date) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";
    Map reqModel = {"id": barCode.trim(), 'date': date};

    log("reqModel-- >$reqModel");
    try {
      _dio.options.headers = {"access-token": token};
      response = await _dio.post(Urls.verifyTickets, data: reqModel);
      if (kDebugMode) {
        log('--------Response : $response');
      }
      return response.statusCode == 200
          ? response.data
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return {"success": true, "valid": false, "type": "Ticket", "ticket": {}};
    }
  }

  /// verify ticket avaliabilty
  Future<ClaimToTicketModel> verifyToTicket(String barCode, String date) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";
    Map reqModel = {"barCode": barCode.trim(), 'date': date};

    log("reqModel-- >$reqModel");
    try {
      _dio.options.headers = {"access-token": token};
      response = await _dio.post(Urls.scanPwt, data: reqModel);
      if (kDebugMode) {
        log('--------Response : $response');
      }
      return response.statusCode == 200
          ? ClaimToTicketModel.fromJson(response.data)
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return ClaimToTicketModel.withError(error.toString());
    }
  }

  /// verify ticket fromTickey
  Future<ClaimFromTicketModel> verifyFromTicket(
      String barCode, String date) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";
    Map reqModel = {"barCode": barCode.trim(), 'date': date};

    log("reqModel-- >$reqModel");
    try {
      _dio.options.headers = {"access-token": token};
      response = await _dio.post(Urls.scanPwt, data: reqModel);
      if (kDebugMode) {
        log('--------Response : $response');
      }
      return response.statusCode == 200
          ? ClaimFromTicketModel.fromJson(response.data)
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return ClaimFromTicketModel.withError(error.toString());
    }
  }

  // claim scan ticket value
  Future<Map> claimScannedticket({required Map reqModel}) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";
    log("reqModel-- >$reqModel");

    try {
      _dio.options.headers = {"access-token": token};
      response = await _dio.post(Urls.claimTicket, data: jsonEncode(reqModel));
      if (kDebugMode) {
        log('--------Response : $response');
      }
      return response.statusCode == 200
          ? response.data
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return {"error": error};
    }
    // return {};
  }

  /// check ticket avaliabilty
  Future<ScanTicketModel> verifyTicketbyID(
      {String? ticketId, String? date}) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";
    Map reqModel = {"ticketId": ticketId ?? "".trim(), 'date': date};
    print("req-> $reqModel");
    try {
      _dio.options.headers = {"access-token": token};
      response = await _dio.post(Urls.verifyTicketById, data: reqModel);

      log('--------Response : $response');

      //  Map resData = {};
      print(response.statusCode);

      return response.statusCode == 200
          ? ScanTicketModel.fromJson(response.data)
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }

      return ScanTicketModel.withError(error.toString());
    }
  }

  /// app support api
  Future<bool> userSupportApimethod(Map<String, dynamic> reqModel) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";

    try {
      _dio.options.headers = {"access-token": token};
      response = await _dio.post(Urls.contactUs, data: reqModel);
      if (kDebugMode) {
        log('--------Response : $response');
      }
      return response.statusCode == 200
          ? true
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return false;
    }
  }

  /// get my returns ticket
  ///
  /// app support api
  Future<ReturnedTicketModel> getMyReturn(Map<String, dynamic> reqModel) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";

    try {
      _dio.options.headers = {"access-token": token};
      response = await _dio.post(Urls.getMyreturn, data: reqModel);
      if (kDebugMode) {
        log('--------Response : $response');
      }
      return response.statusCode == 200
          ? ReturnedTicketModel.fromJson(response.data)
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return ReturnedTicketModel.withError("Someting went wrong");
    }
  }

  Future<Map<String, dynamic>> varidateReturnTicket(
      Map<String, dynamic> reqModel) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";
    print("req-> $reqModel");
    try {
      _dio.options.headers = {"access-token": token};
      response = await _dio.post(Urls.validateReturnTicket, data: reqModel);

      if (kDebugMode) {
        log('--------Response valid : $response');
      }
      return response.statusCode == 200
          ? response.data
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return {"success": false, "error": error};
    }
  }

  /// get my CNF
  Future<Map> getMyCnf() async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";

    try {
      _dio.options.headers = {"access-token": token};
      response = await _dio.get(Urls.getmycnf);
      if (kDebugMode) {
        log('--------Response : $response');
      }
      return response.statusCode == 200
          ? response.data
          : throw Exception('Something Went Wrong');
    } catch (error, stacktrace) {
      if (kDebugMode) {
        log('$error');
      }
      if (kDebugMode) {
        log("Exception occurred: $error stackTrace: $stacktrace");
      }
      return {"success": false};
    }
  }
}
