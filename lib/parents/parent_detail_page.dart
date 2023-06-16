import 'package:flutter/material.dart';
import 'package:implicari/model/parent_model.dart';
import 'package:implicari/repository/parent_repository.dart';

class ParentDetailPage extends StatefulWidget {
  final int parentId;

  const ParentDetailPage({super.key, required this.parentId});

  @override
  State<ParentDetailPage> createState() => _ParentDetailPage();
}

class _ParentDetailPage extends State<ParentDetailPage> {
  @override
  Widget build(BuildContext context) {
    final ParentRepository parentRepository = ParentRepository();

    Future<Parent> getParent = parentRepository.getParent(widget.parentId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de estudiante'),
      ),
      body: FutureBuilder(
        future: getParent,
        builder: (BuildContext context, AsyncSnapshot<Parent> snapshot) {
          if (snapshot.hasData) {
            return ParentDetail(parent: snapshot.data!);
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

class ParentDetail extends StatelessWidget {
  final Parent parent;

  const ParentDetail({super.key, required this.parent});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
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
                  const Text('Nombre completo'),
                  Text(
                    '${parent.firstName} ${parent.lastName}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text('RUN'),
                  Text(
                    parent.run,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
