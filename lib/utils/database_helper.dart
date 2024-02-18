import 'dart:io' show Directory;
import 'package:owner_form_app/models/employee.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;

class DatabaseHelper {
  static const _databaseName = 'MyDatabase.db';
  static const _databaseVersion = 1;

  static const table = 'my_table';

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnDOB = 'dob';
  static const columnPhone = 'phone';
  static const columnQualification = 'qualification';
  static const columnGender = 'gender';
  
  
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  DatabaseHelper._privateConstructor();

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
    // var sqlQuery = "CREATE TABLE $table ($columnId INTEGER PRIMARY KEY, $columnName TEXT NOT NULL, $columnDOB TEXT NOT NULL, $columnPhone TEXT NOT NULL, $columnQualification TEXT, $columnGender TEXT, `dt` DATETIME DEFAULT CURRENT_TIMESTAMP)";
    var sqlQuery = "CREATE TABLE $table ($columnId INTEGER PRIMARY KEY, $columnName TEXT NOT NULL, $columnPhone TEXT NOT NULL, `dt` DATETIME DEFAULT CURRENT_TIMESTAMP)";
    await db.execute(sqlQuery);
    // await db.execute("INSERT INTO $table ($columnName, $columnDOB, $columnPhone) values (?, ?, ?, ?, ?)", ['Vipul Rathod', '22/4/1989', '9004687768']);
  }


  Future<List<Employee>> getApplication() async {
    final db = await instance.database;
    String sqlQuery = 'SELECT * FROM $table';
    List<Map<String, dynamic>> maps = await db.rawQuery(sqlQuery);
    return List.generate(maps.length, (index) => Employee.fromMap(maps[index]));
  }
}