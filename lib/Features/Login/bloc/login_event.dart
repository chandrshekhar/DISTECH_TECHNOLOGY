part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class UserLoginEvent extends LoginEvent{
  String email ;
  String password;

  UserLoginEvent({required this.email, required this.password});
    @override
  List<Object> get props => [email, password];
}
