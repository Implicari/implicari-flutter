class Event {
  int? id;
  late String name;
  String? description;
  late DateTime date;
  String? time;

  Event({
    required this.name,
    required this.description,
    required this.date,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    date = DateTime.parse(json['date']);

    if (json['time'] != null) time = json['time'].substring(0, 5);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'date': date.toIso8601String().split('T')[0],
      'time': time,
    };
  }
}
