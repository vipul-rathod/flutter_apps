import 'dart:io' show Directory;
import 'package:owner_form_app/models/employee.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;

// Create database class.
class DatabaseHelper {
  static const _databaseName = 'MyDatabase.db';
  static const _databaseVersion = 1;
  static const table = 'my_table';

// All the column names assigned to variable to upload on database.
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnDOB = 'dob';
  static const columnPhone = 'phone';
  static const columnExpLevel = 'expLevel';
  static const columnGender = 'gender';
  static const columnConfirmation = 'confirmation';

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  DatabaseHelper._privateConstructor();

  static Database? _database;
  // Initialize database.
  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }
// Function to initialize database.
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path, version: _databaseVersion, onCreate: _onCreate);
  }

// Create database function
  Future _onCreate(Database db, int version) async {
    var sqlQuery = "CREATE TABLE $table ($columnId INTEGER PRIMARY KEY, $columnName TEXT NOT NULL, $columnDOB TEXT NOT NULL, $columnPhone TEXT NOT NULL, $columnExpLevel TEXT, $columnGender TEXT, $columnConfirmation TEXT, `dt` DATETIME DEFAULT CURRENT_TIMESTAMP)";
    await db.execute(sqlQuery);
  }

// Query database function
  Future<List<Employee>> getApplication() async {
    final db = await instance.database;
    String sqlQuery = 'SELECT * FROM $table';
    List<Map<String, dynamic>> maps = await db.rawQuery(sqlQuery);
    return List.generate(maps.length, (index) => Employee.fromMap(maps[index]));
  }
}