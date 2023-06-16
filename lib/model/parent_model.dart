import 'package:implicari/model/user_model.dart';

class Parent {
  late int id;
  late String run;
  late String firstName;
  late String lastName;
  User? user;

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    run = json['run'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}
