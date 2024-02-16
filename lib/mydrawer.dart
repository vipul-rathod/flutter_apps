import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:owner_form_app/addemployeeform.dart';
import 'package:owner_form_app/myhomepage.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';

class MyDrawer extends StatefulWidget{
  const MyDrawer({super.key});
  
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer>{
  String _platformVersion = 'Unknown';

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



