part of 'login_bloc.dart';
abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}
class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
 final LoginResponseModel loginResponseModel;

const LoginSuccessState({required this.loginResponseModel});
 @override
  List<Object> get props => [loginResponseModel];
  
}


class LoginErrorState extends LoginState {
  final String errorMsg;
   const LoginErrorState({required this.errorMsg});
    @override
  List<Object> get props => [errorMsg];
}


