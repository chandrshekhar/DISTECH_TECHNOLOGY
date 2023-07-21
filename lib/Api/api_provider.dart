import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:distech_technology/Api/urls.dart';
import 'package:distech_technology/Features/Login/model/login_model.dart';
import 'package:flutter/foundation.dart';

class ApiProvider {
  final Dio _dio = Dio();

  ///--------- Login -----///
  Future<LoginResponseModel> loginApiCall(Map<String, dynamic> reqModel) async {
    Response response;
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
  Future<Map> resetPassword(
      String email, String password, String confirmPassword, String slug) async {
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
}
