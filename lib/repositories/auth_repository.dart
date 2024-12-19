import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl = 'https://demo-api.devdata.top/api';

  // Shared email storage
  String? _email;

  void setEmail(String email) {
    _email = email;
  }

  String getEmail() {
    if (_email == null) {
      throw Exception('Email is not set');
    }
    return _email!;
  }

  Future<Map<String, dynamic>> checkEmailExist(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Administrator/CheckUserExists'),
      headers: {
        'Content-Type': 'application/json', // Set the correct content type
      },
      body: jsonEncode({
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Email verify failed: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> sendOtp(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Administrator/SendOTPToEmail'),
      headers: {
        'Content-Type': 'application/json', // Ensure the correct content type
      },
      body: jsonEncode({
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Successful response
    } else {
      throw Exception('Send OTP failed: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Administrator/Login'),
      body: {'userName': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> signUp(
      String email, String password, String username) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Administrator/SaveUser'),
      body: {
        'email': email,
        'password': password,
        'username': username,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Sign-Up failed: ${response.body}');
    }
  }

  Future<void> logout() async {
    await http.post(Uri.parse('$baseUrl/Administrator/Logout'));
  }
}
