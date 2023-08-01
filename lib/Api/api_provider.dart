import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:distech_technology/Api/urls.dart';
import 'package:distech_technology/Features/Dashboard/model/all_tickets_model.dart';
import 'package:distech_technology/Features/Login/model/login_model.dart';
import 'package:distech_technology/Features/Profile/model/profile_model.dart';
import 'package:distech_technology/Utils/storage/local_storage.dart';
import 'package:flutter/foundation.dart';
import '../Features/PurchaseHistory/Model/purchase_hostory_model.dart';
import '../Features/SoldTicket/Models/sold_ticket_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  LocalStorageService localStorageService = LocalStorageService();

  ///--------- Login -----///
  Future<LoginResponseModel> loginApiCall(LoginRequestModel reqModel) async {
    Response response;
    if (kDebugMode) {
      print(reqModel.toJson());
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
    print("token $token");
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
      return SoldTicketModel.withError(
          error.toString());
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

  /// ----------  return Ticket --------------///
  Future<Map<String, dynamic>> soldTciket(
      List<String> returnTicketIdList) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";
    Map<String, dynamic> resData = {
      "success": false,
      "message": "No Tickets Found"
    };

    Map<String, dynamic> reqModel = {"tickets": returnTicketIdList};
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

  Future<Map<String, dynamic>> retunTicketUnsold(
      List<String> returnTicketIdList) async {
    Response response;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";
    Map<String, dynamic> resData = {
      "success": false,
      "message": "No Tickets Found"
    };

    Map<String, dynamic> reqModel = {"tickets": returnTicketIdList};
    try {
      _dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "access-token": token
      };
      response = await _dio.post(Urls.returnTicket, data: reqModel);
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

  ///--------- get User Details -----///
  Future<UserProfileModel> getUserDetails() async {
    Response response;
    String? authToken;
    String token = await localStorageService
            .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
        "";
    print("token $token");
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
}
