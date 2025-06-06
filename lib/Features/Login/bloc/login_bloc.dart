import 'dart:developer';
import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/Login/model/login_model.dart';
import 'package:distech_technology/Utils/storage/local_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    ApiProvider apiProvider = ApiProvider();
    on<UserLoginEvent>((event, emit) async {
      LoginRequestModel reqModel =
          LoginRequestModel(email: event.email, password: event.password);
      try {
        emit(LoginLoadingState());
        final mData = await apiProvider.loginApiCall(reqModel);
        if (mData.success == true) {
          print("login token--> ${mData.user}");
           LocalStorageService()
              .saveToDisk(LocalStorageService.ACCESS_TOKEN_KEY, mData.jWT);
               LocalStorageService()
              .saveToDisk(LocalStorageService.USER_NAME, mData.user!.fullName);
          emit(LoginSuccessState(loginResponseModel: mData));
        } else {
          emit(LoginErrorState(
              errorMsg: mData.error ?? "Something Went Wrong"));
          emit(LoginInitial());
        }
      } catch (e) {
        log(e.toString());
        emit(LoginErrorState(errorMsg: e.toString()));
        emit(LoginInitial());
      }
    });
  }
}
