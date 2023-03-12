import 'package:flutter/material.dart';
import 'package:implicari/model/message_model.dart';

class MessageSummary extends StatelessWidget {
  final Message message;

  const MessageSummary({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Icon(Icons.email),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(message.subject),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.access_time,
                            color: Colors.grey, size: 14),
                        const SizedBox(width: 8),
                        Text(message.creationTimestamp.toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
