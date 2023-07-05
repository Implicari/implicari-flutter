import 'package:implicari/model/user_model.dart';

class Course {
  late int id;
  late String name;

  Course({
    required this.id,
    required this.name,
  });

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;

    return data;
  }
}

class CourseRetrieve {
  late int id;
  late String name;
  late User teacher;

  CourseRetrieve({
    required this.id,
    required this.name,
  });

  CourseRetrieve.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    teacher = User.fromJson(json['teacher']);
  }
}
