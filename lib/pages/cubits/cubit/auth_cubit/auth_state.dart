part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterFaliuer extends AuthState {
  String errorMessage;
  RegisterFaliuer({required this.errorMessage});
}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFaliure extends AuthState {
  String errorMessage;
  LoginFaliure({required this.errorMessage});
}
