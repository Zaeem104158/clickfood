part of 'auth_bloc.dart';

abstract class AuthEvent {}

class CheckEmailExist extends AuthEvent {
  final String email;

  CheckEmailExist({
    required this.email,
  });
}

class SetEmail extends AuthEvent {
  final String email;

  SetEmail(this.email);
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String username;

  SignUpRequested(
      {required this.email, required this.password, required this.username});
}

class LogoutRequested extends AuthEvent {}
