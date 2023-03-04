import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:implicari/model/course_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class ImplicariApi {

  final String _url = "http://implicari.localhost:8000";

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '';

    return token;
  }

  Future<void> setToken(String token) async {
    debugPrint(token);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    return;
  }

  /// Borrar token
  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    return;
  }

 
  Future<http.Response> get(String uri) async {
      String token = await getToken();

      final http.Response response = await http.get(
        Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        },
      );

      return response;
    }
}


class UserAPI extends ImplicariApi {

  Future<String> auth(String email, String password) async {

      final http.Response response = await http.post(
        Uri.parse('$_url/api/auth/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({ 'email': email, 'password': password }),
      );

      debugPrint(json.decode(response.body).toString());

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

}



class CourseAPI extends ImplicariApi {

  Future<List<Course>> getTeacherCourses() async {

    final http.Response response = await get('$_url/api/courses/teacher/');

    if (response.statusCode == 200) {
      final List result = jsonDecode(utf8.decode(response.bodyBytes))['results'];
      return result.map((e) => Course.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }

  }

  Future<List<Course>> getParentCourses() async {

    final http.Response response = await get('$_url/api/courses/parent/');

    if (response.statusCode == 200) {
      final List result = jsonDecode(utf8.decode(response.bodyBytes))['results'];
      return result.map((e) => Course.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }

  }

}
