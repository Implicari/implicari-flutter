import 'package:flutter/material.dart';
import 'package:implicari/messages/message_summary.dart';
import 'package:implicari/model/message_model.dart';
import 'package:implicari/repository/message_repository.dart';
import 'package:implicari/widgets/empty_list_feedback.dart';

class LastMessages extends StatefulWidget {
  final int courseId;

  const LastMessages({super.key, required this.courseId});

  @override
  State<LastMessages> createState() => _LastMessages();
}

class _LastMessages extends State<LastMessages> {
  @override
  Widget build(BuildContext context) {
    final MessageRepository messageRepository = MessageRepository();

    return FutureBuilder<List<Message>>(
      future: messageRepository.getMessages(widget.courseId),
      builder: (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
        Widget body;

        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            body = const EmptyListFeedback(message: 'No hay mensajes');
          } else {
            body = Column(
              children: snapshot.data!.map((message) => MessageSummary(message: message)).toList(),
            );
          }
        } else if (snapshot.hasError) {
          body = Column(
            children: <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ],
          );
        } else {
          body = const SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Últimos mensajes',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            body,
          ],
        );
      },
    );
  }
}
