part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFaliure extends LoginState {
  String errorMessage;
  LoginFaliure({required this.errorMessage});
}
