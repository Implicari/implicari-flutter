import 'dart:async';

import 'package:implicari/model/message_model.dart';
import 'package:implicari/repository/implicari_repository.dart';

class MessageRepository extends ImplicariRepository {
  Future<List<Message>> getMessages(int courseId) async {
    final data = await getAuth('/api/courses/$courseId/messages/');
    final List results = data['results'];

    return results.map((e) => Message.fromJson(e)).toList();
  }

  Future<Message> getMessage(int courseId, int messageId) async {
    final Map<String, dynamic> data = await getAuth('/api/courses/$courseId/events/$messageId');

    return Message.fromJson(data);
  }

  Future<Message> create({required int courseId, required Message message}) async {
    final Map<String, dynamic> data =
        await postAuth('/api/courses/$courseId/messages/create/', message.toJson());

    return Message.fromJson(data);
  }
}
