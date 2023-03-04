import 'dart:async';
import 'package:implicari/model/user_model.dart';
import 'package:implicari/api_connection/api_connection.dart';

class UserRepository {
  UserAPI api = UserAPI();

  Future<User> authenticate ({
    required String email,
    required String password,
  }) async {
    String token = await api.auth(email, password);
    print(token);
    User user = User(
      id: 0,
      email: email,
      token: token,
    );
    return user;
  }

  Future <bool> hasToken() async {
    bool result = await api.isAuthenticated();
    return result;
  }

  Future<void> setToken(String token) async {
      await api.setToken(token);
  }

  Future<void> logout() async {

  }

}
