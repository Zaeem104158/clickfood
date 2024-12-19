import 'package:clickfood/blocs/otp/otp_bloc.dart';
import 'package:clickfood/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'repositories/auth_repository.dart';
import 'screens/login_screen.dart';
import 'screens/sign_up_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository = AuthRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider(
              create: (context) => AuthBloc(authRepository: authRepository),
              child: LoginScreen(),
            ),
        '/sign-up': (context) => BlocProvider(
              create: (context) => AuthBloc(authRepository: authRepository),
              child: SignUpScreen(),
            ),
        '/otp': (context) => BlocProvider(
              create: (context) => OtpBloc(authRepository: authRepository),
              child: OtpVerificationScreen(),
            ),
      },
    );
  }
}
