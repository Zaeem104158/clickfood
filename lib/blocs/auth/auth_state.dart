part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {
 
}

class AuthLoading extends AuthState {}

class EmailVerified extends AuthState {}

class AuthAuthenticated extends AuthState {
  final Map<String, dynamic> user;

  AuthAuthenticated({required this.user});
}

class CheckEmailVerified extends AuthState {
  final CheckEmailVerifyModel checkEmailVerifyModel;

  CheckEmailVerified({required this.checkEmailVerifyModel});
}

class CheckEmailVerifyError extends AuthState {
  final String message;

  CheckEmailVerifyError({required this.message});
}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
