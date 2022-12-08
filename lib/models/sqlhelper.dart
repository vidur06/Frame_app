// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  static const table = 'storage';
  static const colId = 'id';
  static const colImage = 'image';

  Database? db;

  Future<Database?> initDB() async {
    final databasePath = await getDatabasesPath();
    final String path = join(databasePath, 'Storage.db');

    if (db != null) {
      return db;
    } else {
      // ignore: join_return_with_assignment
      db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) {
          const String query =
              "CREATE TABLE IF NOT EXISTS $table($colId INTEGER PRIMARY KEY AUTOINCREMENT , $colImage BLOB)";
          return db.execute(query);
        },
      );
      return db;
    }
  }

  Future<int> insert(Storage data) async {
    db = await initDB();

    const String query = "INSERT INTO $table($colImage) VALUES(?)";

    final List args = [
      data.image,
    ];
    return db!.rawInsert(query, args);
  }

  Future<List<Storage>> fetchAllData() async {
    db = await initDB();

    const String query = "SELECT * FROM $table";

    final List response = await db!.rawQuery(query);
    print('response : $response');

    return response.map((e) => Storage.fromMap(e)).toList();
  }

  Future<int> delete(int? id) async {
    await initDB();

    const String query = "DELETE FROM $table WHERE id = ?";
    final List args = [id];
    return db!.rawDelete(query, args);
  }
}
