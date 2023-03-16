import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class ImplicariRepository {
  final String baseUrl = 'http://implicari.localhost:8000';

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

  Future<dynamic> post(String uri, Object body, {Map<String, String>? headers}) async {
    final http.Response response = await http.post(
      Uri.parse(baseUrl + uri),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception(utf8.decode(response.bodyBytes));
    }
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
      Uri.parse(baseUrl + uri),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception(utf8.decode(response.bodyBytes));
    }
  }

  Future<dynamic> postAuth(String uri, Object body) async {
    String token = await getToken();

    return await post(
      uri,
      body,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
    );
  }


}
