import 'dart:developer';

import 'package:clickfood/core/image_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../component/custome_texfield.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Image.asset(ImagePath.arrowBack),
      // ),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Sign in with',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImagePath.googleIcon),
              Image.asset(ImagePath.appleIcon)
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: context.read<AuthBloc>().formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Image.asset(ImagePath.arrowBack),
                Image.asset(
                  ImagePath.loginPageWelcomeImage,
                  height: 160,
                  width: 160,
                ),
                Text(
                  "Log in with email",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  "Let’s log in into your Click To Food account",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomeTextFormField(
                  hintText: "Enter your email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  controller: context.read<AuthBloc>().emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null; // No error
                  },
                ),
                const SizedBox(height: 16),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthAuthenticated) {
                      Navigator.pushNamed(context, '/dashboard');
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    } else if (state is CheckEmailVerified) {
                      state.checkEmailVerifyModel.success!
                          ? Navigator.pushNamed(context, '/otp')
                          : showCustomDialog(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(13, 16, 13, 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: const Color(
                                0xFFA1045A,
                              ),
                            ),
                            child: const Center(
                                child: CircularProgressIndicator())),
                      );
                    } else if (state is EmailVerified) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding:
                                WidgetStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.fromLTRB(13, 16, 13, 16),
                            ),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: const BorderSide(
                                  color: Color(
                                    0xFFA1045A,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  LoginRequested(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          },
                          child: const Text('Login'),
                        ),
                      );
                    }
                    return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color?>(
                          const Color(
                            0xFFA1045A,
                          ),
                        ),
                        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.fromLTRB(13, 16, 13, 16),
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              CheckEmailExist(
                                email: emailController.text,
                              ),
                            );
                      },
                      child: const Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                'Continue',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Icon(Icons.email_outlined, color: Colors.white)
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Log in with phone number',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showCustomDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.zero,
        content: PopScope(
          canPop: false,
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon at the top
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        shape: BoxShape.rectangle,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Icon(
                        Icons.person_off,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.close,
                        size: 24,
                      ),
                      color: Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Title
                const Text(
                  'Account not found!!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  "It looks like there's no account associated with this phone number. Click continue to open a new account.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Back Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: BorderSide(color: Colors.grey.shade400),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          'Back',
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Create Account Button
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context.read<AuthBloc>().add(SetEmail(
                              context.read<AuthBloc>().emailController.text));
                          Navigator.pushNamed(
                            context,
                            '/otp',
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFA1045A,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                        ),
                        label: const Row(children: [
                          Expanded(
                            child: Text(
                              'Create Account',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Icon(
                            Icons.mail_outline,
                            color: Colors.white,
                            size: 20,
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
