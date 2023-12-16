import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lettutor/model/user/user.dart';
class UserInfoService
{
  static Future<User> GetUserData(String token) async {
    String apiUrl = 'https://sandbox.api.lettutor.com/user/info';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    final body = json.decode(response.body);

    return User.fromJson(body['user']);
  }
}