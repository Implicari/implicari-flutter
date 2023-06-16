import 'dart:async';

import 'package:implicari/model/parent_model.dart';
import 'package:implicari/repository/implicari_repository.dart';

class ParentRepository extends ImplicariRepository {
  Future<List<Parent>> getParents(int studentId) async {
    final data = await getAuth('/api/students/$studentId/parents/');
    final List results = data['results'];

    return results.map((e) => Parent.fromJson(e)).toList();
  }

  Future<Parent> getParent(int parentId) async {
    final Map<String, dynamic> data = await getAuth('/api/parents/$parentId/');

    return Parent.fromJson(data);
  }

  Future<Parent> create({
    required int studentId,
    required String firstName,
    required String lastName,
    required String run,
  }) async {
    final Map<String, dynamic> data = await postAuth(
      '/api/students/$studentId/parents/create/',
      {
        'first_name': firstName,
        'last_name': lastName,
        'run': run,
      },
    );

    return Parent.fromJson(data);
  }
}
