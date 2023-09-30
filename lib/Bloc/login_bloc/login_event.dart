part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class loginEvent extends LoginEvent{
  String email;
  String password;
  loginEvent({required this.email,required this.password});
}
