class Message {
  late int id;
  late String subject;
  late String message;
  late DateTime creationTimestamp;

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    message = json['message'];
    creationTimestamp = DateTime.parse(json['creation_timestamp']);
  }
}
