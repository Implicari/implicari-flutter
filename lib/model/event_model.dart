class Event {

  late int id;
  late String description;
  late String message;
  late DateTime date;
  late String time;

  Event({
      required this.id,
      required this.description,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    message = json['message'];
    date = DateTime.parse(json['date']);
    time = json['time'].substring(0, 5);
  }

}
