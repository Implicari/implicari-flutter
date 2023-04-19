import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:implicari/model/course_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ImplicariApi {
  final String _url = 'http://localhost:8000';

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

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    return;
  }

  Future<dynamic> getAuth(String uri) async {
    String token = await getToken();

    return await get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
    );
  }

  Future<dynamic> get(String uri, {Map<String, String>? headers}) async {
    final http.Response response = await http.get(
      Uri.parse(uri),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception(utf8.decode(response.bodyBytes));
    }
  }
}

class UserAPI extends ImplicariApi {
  Future<String> auth(String email, String password) async {
    final http.Response response = await http.post(
      Uri.parse('$_url/api/auth/'),
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
}

class CourseAPI extends ImplicariApi {
  Future<List<Course>> getTeacherCourses() async {
    final data = await getAuth('$_url/api/courses/teacher/');
    final List results = data['results'];

    return results.map((e) => Course.fromJson(e)).toList();
  }

  Future<List<Course>> getParentCourses() async {
    final data = await getAuth('$_url/api/courses/parent/');
    final List results = data['results'];

    return results.map((e) => Course.fromJson(e)).toList();
  }

  Future<CourseRetrieve> getCourse(int id) async {
    final Map<String, dynamic> data = await getAuth('$_url/api/courses/$id/');

    return CourseRetrieve.fromJson(data);
  }
}
