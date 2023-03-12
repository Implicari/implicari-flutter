import 'package:flutter/material.dart';
import 'package:implicari/messages/message_summary.dart';
import 'package:implicari/model/message_model.dart';
import 'package:implicari/repository/message_repository.dart';

class LastMessages extends StatelessWidget {
  final int courseId;

  const LastMessages({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    final MessageRepository messageRepository = MessageRepository();

    return FutureBuilder<List<Message>>(
      future: messageRepository.getMessages(courseId),
      builder: (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
        List<Widget> children;

        if (snapshot.hasData && snapshot.data != null) {
          children = snapshot.data!
              .map((message) => MessageSummary(message: message))
              .toList();
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            ),
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            ),
          ];
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 20),
              child: Text(
                'Últimos mensajes',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            Column(children: children),
          ],
        );
      },
    );
  }
}
