import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:owner_form_app/addemployeeform.dart';
import 'package:owner_form_app/employeelist1.dart';
import 'package:owner_form_app/myhomepage.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:owner_form_app/models/employee.dart';
import 'package:owner_form_app/utils/database_helper.dart';
import 'package:hive/hive.dart';
import 'package:owner_form_app/models/data_model.dart';

class MyDrawer extends StatefulWidget{
  const MyDrawer({super.key});
  
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer>{
  String _platformVersion = 'Unknown';
  final DatabaseHelper instance = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try{
      platformVersion = await FlutterExitApp.platformVersion ?? 'Unknown platform version';
    }
    on PlatformException {
      platformVersion = 'Failed to get platform version';
    }
    if (!mounted) return;
    setState((){
      _platformVersion = platformVersion;
    });

  }

  Future<List<Employee>> getEmployees() async {
    return await instance.getApplication();
  }

  Future<List<DataModel>> _getDataHive()async{
    Box<DataModel> userBox = Hive.box('employee_box');
    List<DataModel> items = userBox.values.toList();
    return items;
  }

  @override
  Widget build(BuildContext context){
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 254, 252, 239),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              accountName: Text('Vipul Rathod', style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),),
              accountEmail: Text('rathodvipul2204@gmail.com', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              currentAccountPicture: FlutterLogo(),
            ),
            ListTile(
              hoverColor: Colors.blue,
              tileColor: Colors.amber,
              leading: const Icon(Icons.home),
              title: const Text('Home Page'),
              onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const MyHomePage()));}
            ),

            ListTile(
              hoverColor: Colors.blue,
              tileColor: Colors.amber,
              leading: const Icon(Icons.emoji_people_rounded),
              title: const Text('Application Page'),
              onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const AddEmployeeForm()));}
            ),

            ListTile(
              hoverColor: Colors.blue,
              tileColor: Colors.amber,
              leading: const Icon(Icons.emoji_people_rounded),
              title: const Text('List SQL Data'),
              onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ApplicationBuilder(future: getEmployees())));}
            ),

            ListTile(
              hoverColor: Colors.blue,
              tileColor: Colors.amber,
              leading: const Icon(Icons.emoji_people_rounded),
              title: const Text('List Hive Data'),
              onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AppBuilder(future: _getDataHive())));}
            ),

            ListTile(
              tileColor: Colors.amber,
              leading: const Icon(Icons.exit_to_app),
              title: Text('Exit App from $_platformVersion'),
              onTap: () {FlutterExitApp.exitApp(iosForceExit: true);}
            ),
          ],
        ),
      );
  }
}



