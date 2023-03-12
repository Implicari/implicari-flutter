import 'dart:async';

import 'package:sqflite/sqflite.dart';

const userTable = 'userTable';

class DatabaseProvider {
  late Database database;

  Future open() async {
    database = await openDatabase(
      'db.sqlite',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $userTable (
            id integer primary key autoincrement, 
            email text not null,
            token text not null
          )
        ''');
      },
    );
  }
}
