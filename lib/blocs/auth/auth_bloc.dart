import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/check_email_verify.dart';
import '../../repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<CheckEmailExist>((event, emit) async {
      log("message: ${formKey.currentState!.validate()}");
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        emit(AuthLoading());
        try {
          final response = await authRepository.checkEmailExist(event.email);

          emit(CheckEmailVerified(
              checkEmailVerifyModel: CheckEmailVerifyModel.fromJson(response)));
        } catch (e) {
          emit(CheckEmailVerifyError(message: e.toString()));
        }
      } else {}
    });

    on<SetEmail>((event, emit) {
      authRepository.setEmail(event.email);
    });
    
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.login(event.email, event.password);
        emit(AuthAuthenticated(user: user));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.signUp(
            event.email, event.password, event.username);
        emit(AuthAuthenticated(user: user));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await authRepository.logout();
      emit(AuthInitial());
    });
  }
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
