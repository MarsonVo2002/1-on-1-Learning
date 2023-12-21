import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lettutor/model/account-dto.dart';
import 'package:lettutor/model/user/user.dart';

class LoginService {
  static Future<http.Response> login(AccountDTO account) async {
    String apiUrl =
        'https://sandbox.api.lettutor.com/auth/login'; // Replace with your API endpoint

    final Map<String, dynamic> requestBody = {
      'email': account.email,
      'password': account.password,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }

  static Future<void> Register(
      String email, String password) async {
     final response = await http.post(
      Uri.parse("https://sandbox.api.lettutor.com/auth/register"),
      body: {
        'email': email,
        'password': password,
        "source": 'null',
      },
    );
  }
}
