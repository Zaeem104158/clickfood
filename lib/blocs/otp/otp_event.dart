abstract class OtpEvent {}

class SendOtp extends OtpEvent {
  final String email;

  SendOtp(this.email);
}

class ResendOtp extends OtpEvent {
  final String email;

  ResendOtp(this.email);
}
