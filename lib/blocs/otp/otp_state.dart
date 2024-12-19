abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSent extends OtpState {
  final int remainingTime; // Time remaining for the resend button

  OtpSent(this.remainingTime);
}

class OtpError extends OtpState {
  final String message;

  OtpError(this.message);
}
