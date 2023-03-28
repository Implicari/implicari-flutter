class Message {
  int? id;
  late String subject;
  late String body;
  DateTime? creationTimestamp;

  Message({
    required this.subject,
    required this.body,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    body = json['body'];
    creationTimestamp = DateTime.parse(json['creation_timestamp']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'body': body,
    };
  }
}
