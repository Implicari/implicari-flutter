class Event {
  int? id;
  late String description;
  late String message;
  late DateTime date;
  String? time;

  Event({
    required this.description,
    required this.message,
    required this.date,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    message = json['message'];
    date = DateTime.parse(json['date']);

    if (json['time'] != null) time = json['time'].substring(0, 5);
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'message': message,
      'date': date.toIso8601String().split('T')[0],
      'time': time,
    };
  }
}
