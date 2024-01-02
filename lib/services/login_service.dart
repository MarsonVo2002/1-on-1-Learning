import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lettutor/model/account-dto.dart';
import 'package:lettutor/model/user/user.dart';

class LoginService {
  static Future<http.Response> login(AccountDTO account) async {
    String apiUrl =
        'https://sandbox.api.lettutor.com/auth/login';
    final Map<String, dynamic> requestBody = {
      'email': account.email,
      'password': account.password,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );
    final jsonDecode = json.decode(response.body);
    return response;
  }
  static Future<http.Response> GoogleLogin(
    String accessToken,
    
  ) async {
    final response = await http.post(
      Uri.parse("https://sandbox.api.lettutor.com/auth/google"),
      body: {
        'access_token': accessToken,
      },
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
    return response;
  }
  static Future<http.Response> FacebookLogin(
     String accessToken,
   
  ) async {
    final response = await http.post(
      Uri.parse("https://sandbox.api.lettutor.com/auth/facebook"),
      body: {
        'access_token': accessToken,
      },
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
    return response;
  }
  static Future<void> Register(
      String email, String password) async {
     final response = await http.post(
      Uri.parse("https://sandbox.api.lettutor.com/auth/register"),
      body: json.encode({
        'email': email,
        'password': password,
        "source": null,
      
      }),
      headers: {'Content-Type': 'application/json'},
    );
     final jsonDecode = json.decode(response.body);
    if (response.statusCode != 201) {
      throw Exception(jsonDecode['message']);
    }
  }
   static Future<void> ForgotPassword(String email) async {
    //https://sandbox.app.lettutor.com/password?....
    final response = await http.post(
      Uri.parse("https://sandbox.api.lettutor.com/user/forgotPassword"),
      body: {
        'email': email,
      },
    );

    final body = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(body['message']);
    }
  }
}
