import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:owner_form_app/models/employee.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database? _database;

  String employeeTable = 'employee_table';
  String colId = 'id';
  String colName = 'name';
  String colDob = 'dob';
  String colPhone = 'phone';
  String colQualification = 'qualification';
  String colGender = 'gender';
  String colDate = 'date';

  Future<Database> get database async {
      return _database ??= await initDB();
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "EmployeeDB.db");
    return await openDatabase(
      path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE $employeeTable ($colId INTEGER PRIMARY_KEY, $colName TEXT, $colDob TEXT, $colPhone TEXT, $colQualification TEXT, $colGender TEXT, $colDate DATETIME DEFAULT CURRENT_TIMESTAMP)');
        await db.execute("INSERT INTO $employeeTable ($colName, $colDob, $colPhone, $colQualification, $colGender) values (?, ?, ?, ?, ?)", ['Vipul Rathod', '22/4/1989', '9004687768', 'Experienced', 'Male']);
      }
    );
  }

  Future<List<Employee>> getAllEmployees() async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query("employee_table", columns: Employee.columns, orderBy: "id ASC");
    List<Employee> employees = List.empty();
    for(var result in results) {
      Employee employee = Employee.fromMap(result);
      employees.add(employee);
    }
    return employees;
  }

  Future<Employee> getProductById(int id) async {
    final db = await database;

    var result = await db.query(employeeTable, where: "id = ", whereArgs: [id]);
    // return result.isNotEmpty ? Employee.fromMap(result.first) : Null;
    if (result.isNotEmpty){
      return Employee.fromMap(result.first);
    }
    throw '';
  }

  insert(Employee employee) async {
    final db = await database;

    var result = await db.rawInsert("INSERT INTO $employeeTable ($colName, $colDob, $colPhone, $colQualification, $colGender) VALUES (?, ?, ?, ?, ?)", [employee.name, employee.dob, employee.phone, employee.qualification, employee.gender]);
    return result;
  }

  update(Employee employee) async {
    final db = await database;

    var result = await db.update(employeeTable, employee.toMap(), where: "name = ?", whereArgs: [employee.name]);
    return result;
  }

  delete(int id) async {
    final db = await database;

    db.delete(employeeTable, where: "id = ?", whereArgs: [id]);
  }
}

