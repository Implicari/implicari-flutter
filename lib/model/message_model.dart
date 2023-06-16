import 'package:implicari/model/user_model.dart';

class Message {
  int? id;
  late String subject;
  String? body;
  DateTime? createdAt;
  User? sender;

  Message({
    required this.subject,
    required this.body,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    body = json['body'];
    createdAt = DateTime.parse(json['created_at']);
    sender = User.fromJson(json['sender']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'body': body,
    };
  }
}
