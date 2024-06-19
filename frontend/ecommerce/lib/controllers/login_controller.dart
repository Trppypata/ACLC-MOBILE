import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecommerce/models/user_model.dart';

class LoginController {
  Future<Map<String, dynamic>> login(User user) async {
    final response = await http.post(
      Uri.parse('http://192.168.168.224:4040/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }
}
