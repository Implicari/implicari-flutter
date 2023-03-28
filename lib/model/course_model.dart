import 'package:implicari/model/event_model.dart';

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
  Event? nextEvent;

  CourseRetrieve({
    required this.id,
    required this.name,
    required this.nextEvent,
  });

  CourseRetrieve.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    if (json['next_event'] != null) {
      nextEvent = Event.fromJson(json['next_event']);
    }
  }
}
