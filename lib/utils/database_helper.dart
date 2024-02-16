import 'dart:io' show Directory;
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;

class DatabaseHelper {
  static final _databaseName = 'MyDatabase.db';
  static final _databaseVersion = 1;

  static final table = 'my_table';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnDOB = 'dob';
  static final columnPhone = 'Telephone';
  
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    var sqlQuery = "CREATE TABLE $table ($columnId INTEGER PRIMARY KEY, $columnName TEXT NOT NULL, $columnDOB TEXT NOT NULL, $columnPhone TEXT NOT NULL, `dt` DATETIME DEFAULT CURRENT_TIMESTAMP)";
    await db.execute(sqlQuery);
  }
}