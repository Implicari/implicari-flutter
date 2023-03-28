import 'package:flutter/material.dart';
import 'package:implicari/home/home.dart';
import 'package:implicari/repository/message_repository.dart';

import '../model/message_model.dart';

class MessageCreatePage extends StatefulWidget {
  final int courseId;

  const MessageCreatePage({super.key, required this.courseId});

  @override
  State<MessageCreatePage> createState() => _MessageCreatePage();
}

class _MessageCreatePage extends State<MessageCreatePage> {
  final _formKey = GlobalKey<FormState>();

  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final MessageRepository messageRepository = MessageRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear mensaje'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _subjectController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return 'Escriba un asunto para su mensaje';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Asunto',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                maxLines: 6,
                controller: _messageController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return 'Escriba su mensaje';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mensaje',
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );

                      Message message = Message(
                        subject: _subjectController.text,
                        body: _messageController.text,
                      );

                      messageRepository.create(
                        courseId: widget.courseId,
                        message: message,
                      );

                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('crear'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
