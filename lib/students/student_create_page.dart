import 'package:flutter/material.dart';
import 'package:implicari/repository/student_repository.dart';

class StudentCreatePage extends StatefulWidget {
  final int courseId;

  const StudentCreatePage({super.key, required this.courseId});

  @override
  State<StudentCreatePage> createState() => _StudentCreatePage();
}

class _StudentCreatePage extends State<StudentCreatePage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _runController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final StudentRepository studentRepository = StudentRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear estudiante'),
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
                    return 'Escriba un nombre de su estudiante';
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
                    return 'Escriba los apellidos de su estudiante';
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
                    return 'Escriba el RUN de su estudiante';
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
                      studentRepository
                          .create(
                        courseId: widget.courseId,
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        run: _runController.text,
                      )
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Estudiante creado: ${value.firstName}')),
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
