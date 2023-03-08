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

}

class CourseRetrieve {

  late int id;
  late String name;
  late Event nextEvent;

  CourseRetrieve({
      required this.id,
      required this.name,
      required this.nextEvent,
  });

  CourseRetrieve.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nextEvent = Event.fromJson(json['next_event']);
  }

}
