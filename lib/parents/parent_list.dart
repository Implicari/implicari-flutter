import 'package:flutter/material.dart';
import 'package:implicari/parents/parent_summary.dart';
import 'package:implicari/model/parent_model.dart';
import 'package:implicari/repository/parent_repository.dart';

import 'parent_create_page.dart';

class ParentList extends StatefulWidget {
  final int studentId;

  const ParentList({super.key, required this.studentId});

  @override
  State<ParentList> createState() => _ParentList();
}

class _ParentList extends State<ParentList> {
  @override
  Widget build(BuildContext context) {
    final ParentRepository parentRepository = ParentRepository();

    return FutureBuilder<List<Parent>>(
      future: parentRepository.getParents(widget.studentId),
      builder: (BuildContext context, AsyncSnapshot<List<Parent>> snapshot) {
        List<Widget> children;

        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            children = <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.grey,
                      size: 24,
                    ),
                    SizedBox(width: 16),
                    Text('No hay apoderados', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              )
            ];
          } else {
            children = snapshot.data!.map((parent) => ParentSummary(parent: parent)).toList();
          }
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            ),
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            ),
          ];
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Apoderados',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  ElevatedButton(
                    child: const Text('crear'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParentCreatePage(studentId: widget.studentId),
                        ),
                      ).then((value) => setState(() {}));
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: children),
            ),
          ],
        );
      },
    );
  }
}
