import 'package:flutter/material.dart';
import 'package:implicari/repository/event_repository.dart';

import '../model/event_model.dart';

class EventCreatePage extends StatefulWidget {
  final int courseId;

  const EventCreatePage({super.key, required this.courseId});

  @override
  State<EventCreatePage> createState() => _EventCreatePage();
}

class _EventCreatePage extends State<EventCreatePage> {
  final _formKey = GlobalKey<FormState>();

  final _descriptionController = TextEditingController();
  final _messageController = TextEditingController();
  late DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final EventRepository eventRepository = EventRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _descriptionController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return 'Escriba un asunto para su evento';
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
                    return 'Escriba su evento';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mensaje',
                ),
              ),
              const SizedBox(height: 20),
              InputDatePickerFormField(
                firstDate: DateTime(2019),
                lastDate: DateTime(2030, 12, 12),
                initialDate: DateTime.now(),
                onDateSubmitted: (date) {
                  setState(() {
                    _date = date;
                  });
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      Event event = Event(
                        name: _descriptionController.text,
                        description: _messageController.text,
                        date: _date,
                      );

                      eventRepository
                          .create(
                        courseId: widget.courseId,
                        event: event,
                      )
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Evento creado: ${value.name}')),
                        );
                        Navigator.of(context).pop();
                      });
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
