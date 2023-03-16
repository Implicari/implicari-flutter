import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:implicari/model/token_model.dart';
import 'package:implicari/model/user_model.dart';
import 'package:implicari/repository/implicari_repository.dart';

class UserRepository extends ImplicariRepository {
  Future<Token> authenticate({
    required String email,
    required String password,
  }) async {
    String token = await auth(email, password);
    Token user = Token(
      id: 0,
      email: email,
      token: token,
    );
    return user;
  }

  Future<bool> hasToken() async {
    bool result = await isAuthenticated();
    return result;
  }

  Future<void> logout() async {}

  Future<String> auth(String email, String password) async {
    final http.Response response = await http.post(
      Uri.parse('$baseUrl/api/auth/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes))['token'];
    } else {
      throw Exception(json.decode(response.body));
    }
  }

  Future<bool> isAuthenticated() async {
    String token = await getToken();
    return token.isNotEmpty;
  }

  Future<User> getUser() async {
    final Map<String, dynamic> data = await getAuth('/api/user/');

    return User.fromJson(data);
  }
}
