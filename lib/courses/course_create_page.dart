import 'package:flutter/material.dart';
import 'package:implicari/home/home.dart';
import 'package:implicari/repository/course_repository.dart';

class CourseCreatePage extends StatefulWidget {
  const CourseCreatePage({super.key});

  @override
  State<CourseCreatePage> createState() => _CourseCreatePage();
}

class _CourseCreatePage extends State<CourseCreatePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CourseRepository courseRepository = CourseRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear curso'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return 'Escriba un nombre para su curso';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      courseRepository.createCourse(_nameController.text).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Curso creado: ${value.name}')),
                        );

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const HomePage(),
                          ),
                          (Route<dynamic> route) => false,
                        );
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
