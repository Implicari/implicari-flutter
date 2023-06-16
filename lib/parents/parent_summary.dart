import 'package:flutter/material.dart';
import 'package:implicari/parents/parent_detail_page.dart';
import 'package:implicari/model/parent_model.dart';

class ParentSummary extends StatelessWidget {
  final Parent parent;

  const ParentSummary({super.key, required this.parent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ParentDetailPage(parentId: parent.id)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Icon(Icons.child_care),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${parent.firstName} ${parent.lastName}'),
                      Text(parent.run),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
