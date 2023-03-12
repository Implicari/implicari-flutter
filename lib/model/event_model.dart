class Event {
  late int id;
  late String description;
  late String message;
  late DateTime date;
  String? time;

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    message = json['message'];
    date = DateTime.parse(json['date']);

    if (json['time'] != null) time = json['time'].substring(0, 5);
  }
}
