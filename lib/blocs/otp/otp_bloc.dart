import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth_repository.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  static const int resendTimeout = 120; // 2 minutes for the resend timer
  final AuthRepository authRepository;
  Timer? _timer;

  OtpBloc({required this.authRepository}) : super(OtpInitial()) {
    on<SendOtp>(_onSendOtp); // Register the handler
    on<ResendOtp>(_onResendOtp);

    // Delay the SendOtp event until the handlers are registered
    Future.microtask(() {
      final email =
          authRepository.getEmail(); // Retrieve the email from repository
      add(SendOtp(email)); // Dispatch SendOtp after handlers are registered
    });
  }

  Future<void> _onSendOtp(SendOtp event, Emitter<OtpState> emit) async {
    log("------------------------");
    emit(OtpLoading());
    try {
      final response = await authRepository.sendOtp(event.email);
      log("OTP sent successfully: $response");

      // Start the resend timer
      _startCountdown(emit);
    } catch (e) {
      emit(OtpError('Failed to send OTP. Please try again.'));
    }
  }

  Future<void> _onResendOtp(ResendOtp event, Emitter<OtpState> emit) async {
    emit(OtpLoading());
    try {
      final email = authRepository.getEmail();
      final response = await authRepository.sendOtp(email);
      print("OTP resent successfully: ${response['message']}");

      // Restart the resend timer
      _startCountdown(emit);
    } catch (e) {
      emit(OtpError('Failed to resend OTP. Please try again.'));
    }
  }

  void _startCountdown(Emitter<OtpState> emit) {
    int remainingTime = resendTimeout;
    emit(OtpSent(remainingTime));

    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingTime--;

      if (emit.isDone) {
        // Stop emitting if the event handler is already completed
        _timer?.cancel();
        return;
      }

      if (remainingTime <= 0) {
        _timer?.cancel();
      }

      emit(OtpSent(remainingTime)); // Emit countdown updates
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
