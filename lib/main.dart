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

// Use of media query and split into 2 screen using LayoutBuilder

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});
//   @override
//   Widget build(BuildContext context){
//     Size screenSize = MediaQuery.of(context).size;
//     Orientation orientation = MediaQuery.of(context).orientation;
//     return Scaffold(
//       body: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: LayoutBuilder(
//               builder: (context, BoxConstraints constraints) => Container(
//                 color: Colors.lightBlue,
//                 child: Center(
//                   child: Text(
//                     'View 1\n\n[MediaQuery]: ${screenSize.width.toStringAsFixed(2)}\n\n[LayoutBuilder]: ${constraints.maxWidth.toStringAsFixed(2)}',
//                     style: const TextStyle(color: Colors.white, fontSize: 25),
//                   ),
//                 ),
//           ),
//           ),
//           ),
//           Expanded(
//             flex:3,
//             child: LayoutBuilder(
//               builder: (context, BoxConstraints constraints) => Container(
//                 color: Colors.white,
//                 child: Center(
//                   child: Text(
//                     'View 2\n\n[MediaQuery]: ${screenSize.width.toStringAsFixed(2)}\n\n[LayoutBuilder]: ${constraints.maxWidth.toStringAsFixed(2)}',
//                     style: const TextStyle(color: Colors.black, fontSize: 25),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],),
//       );
//   }
// }
