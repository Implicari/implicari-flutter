class Message {
  int? id;
  late String subject;
  String? body;
  DateTime? sentAt;

  Message({
    required this.subject,
    required this.body,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    body = json['body'];
    sentAt = DateTime.parse(json['sent_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'body': body,
    };
  }
}
