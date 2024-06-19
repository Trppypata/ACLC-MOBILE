import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecommerce/models/user_model.dart';

class RegisterController {
  Future<void> register(User user) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.132:4040/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception(
          'Registration failed, status code: ${response.statusCode}');
    }
  }
}
