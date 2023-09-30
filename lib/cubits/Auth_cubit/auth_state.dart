part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginErrorState extends AuthState {
  String error;
  LoginErrorState({required this.error});
}

class LogoutSuccessState extends AuthState {}

class LogoutLoadingState extends AuthState {}

class LogoutErrorState extends AuthState {
  String error;
  LogoutErrorState({required this.error});
}

class RegisterSuccessState extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterErrorState extends AuthState {
  String error;
  RegisterErrorState({required this.error});
}

class UserCreatedSuccessStates extends AuthState {}

class UserCreatedErrorStates extends AuthState {
  String error;
  UserCreatedErrorStates(this.error);
}

class ChangePasswordVisibilityStates extends AuthState {}
