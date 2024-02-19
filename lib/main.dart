import 'dart:io';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:owner_form_app/models/data_model.dart';
import 'package:owner_form_app/myhomepage.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  // Initialize Hive Adapter
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(DataModelAdapter());
  Box<DataModel> box = await Hive.openBox('employee_box');

  //Run Main App
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Owner Application form",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}
