import 'package:clickfood/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../blocs/otp/otp_bloc.dart';
import '../blocs/otp/otp_event.dart';
import '../blocs/otp/otp_state.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String? email;

  const OtpVerificationScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFA1045A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            // Perform OTP verification logic
          },
          child: const Text(
            "Verify Phone Number",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: BlocConsumer<OtpBloc, OtpState>(
            listener: (context, state) {
              if (state is OtpError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              int remainingTime = 0;
              if (state is OtpSent) {
                remainingTime = state.remainingTime;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  RichText(
                    text: TextSpan(
                      text: "We've sent an OTP to ",
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                      children: [
                        TextSpan(
                          text: email,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // OTP Input
                  Pinput(
                    length: 4,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    showCursor: true,
                    onCompleted: (pin) => print(pin),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Didn't receive the OTP?",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      TextButton(
                        onPressed: remainingTime > 0
                            ? null
                            : () {
                                context.read<OtpBloc>().add(ResendOtp(email!));
                              },
                        child: Text(
                          remainingTime > 0
                              ? "Resend in ${remainingTime}s"
                              : "Resend OTP",
                          style: TextStyle(
                            color:
                                remainingTime > 0 ? Colors.grey : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
