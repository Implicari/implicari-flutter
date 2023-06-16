import 'package:flutter/material.dart';
import 'package:implicari/model/message_model.dart';
import 'package:implicari/repository/message_repository.dart';

class MessageDetailPage extends StatefulWidget {
  final int messageId;

  const MessageDetailPage({super.key, required this.messageId});

  @override
  State<MessageDetailPage> createState() => _MessageDetailPage();
}

class _MessageDetailPage extends State<MessageDetailPage> {
  @override
  Widget build(BuildContext context) {
    final MessageRepository messageRepository = MessageRepository();

    Future<Message> getMessage = messageRepository.getMessage(widget.messageId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de mensaje'),
      ),
      body: FutureBuilder(
        future: getMessage,
        builder: (BuildContext context, AsyncSnapshot<Message> snapshot) {
          if (snapshot.hasData) {
            return MessageDetail(message: snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class MessageDetail extends StatelessWidget {
  final Message message;

  const MessageDetail({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.subject,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.email, color: Colors.grey, size: 14),
                      const SizedBox(width: 5),
                      Text(message.sender!.email),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.calendar_month, color: Colors.grey, size: 14),
                      const SizedBox(width: 5),
                      Text(message.createdAt.toString().split(' ')[0]),
                      const SizedBox(width: 20),
                      const Icon(Icons.access_time, color: Colors.grey, size: 14),
                      const SizedBox(width: 5),
                      Text(message.createdAt!.toLocal().toString().split(' ')[1]),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                child: Text(message.body!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
