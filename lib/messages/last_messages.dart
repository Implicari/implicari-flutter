import 'package:flutter/material.dart';
import 'package:implicari/messages/message_summary.dart';
import 'package:implicari/model/message_model.dart';
import 'package:implicari/repository/message_repository.dart';

import 'message_create_page.dart';

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
        List<Widget> children;

        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            children = <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.error_outline,
                      color: Colors.grey,
                      size: 24,
                    ),
                    SizedBox(width: 16),
                    Text('No hay mensajes', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              )
            ];
          } else {
            children = snapshot.data!.map((message) => MessageSummary(message: message)).toList();
          }
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Últimos mensajes',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  ElevatedButton(
                    child: const Text('crear'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessageCreatePage(courseId: widget.courseId),
                        ),
                      ).then((value) => setState(() {}));
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: children),
            ),
          ],
        );
      },
    );
  }
}
