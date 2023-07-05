import 'package:flutter/material.dart';

class ErrorFeedback extends StatelessWidget {
  final String message;

  const ErrorFeedback({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('Error: $message'),
        ),
      ],
    );
  }
}
