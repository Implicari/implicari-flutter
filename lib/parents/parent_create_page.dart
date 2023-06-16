import 'package:flutter/material.dart';
import 'package:implicari/repository/parent_repository.dart';

class ParentCreatePage extends StatefulWidget {
  final int studentId;

  const ParentCreatePage({super.key, required this.studentId});

  @override
  State<ParentCreatePage> createState() => _ParentCreatePage();
}

class _ParentCreatePage extends State<ParentCreatePage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _runController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ParentRepository parentRepository = ParentRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear apoderado'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _firstNameController,
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return 'Escriba un nombre de su apoderado';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombres',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _lastNameController,
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return 'Escriba los apellidos de su apoderado';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Apellidos',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _runController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return 'Escriba el RUN de su apoderado';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'RUN',
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      parentRepository
                          .create(
                        studentId: widget.studentId,
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        run: _runController.text,
                      )
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Apoderado creado: ${value.firstName}')),
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
