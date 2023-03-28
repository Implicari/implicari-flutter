import 'package:flutter/material.dart';
import 'package:implicari/model/course_model.dart';
import 'package:implicari/repository/course_repository.dart';

class CourseEditPage extends StatefulWidget {
  final int id;

  const CourseEditPage({super.key, required this.id});

  @override
  // ignore: no_logic_in_create_state
  State<CourseEditPage> createState() => _CourseEditPage();
}

class _CourseEditPage extends State<CourseEditPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final CourseRepository courseRepository = CourseRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar curso'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Icon(Icons.confirmation_num),
          ),
        ],
      ),
      body: FutureBuilder<CourseRetrieve>(
        future: courseRepository.getCourse(widget.id),
        builder: (BuildContext context, AsyncSnapshot<CourseRetrieve> snapshot) {
          return buildBody(context, snapshot);
        },
      ),
    );
  }

  Widget buildBody(BuildContext context, AsyncSnapshot<CourseRetrieve> snapshot) {
    if (snapshot.hasError) {
      return const Text('Error');
    } else if (snapshot.hasData) {
      _nameController.text = snapshot.data!.name;

      return Padding(
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
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );

                      courseRepository.updateCourse(widget.id, _nameController.text);

                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('editar'),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
