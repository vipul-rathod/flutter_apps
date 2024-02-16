import 'package:flutter/material.dart';
import 'package:owner_form_app/mydrawer.dart';

class MyScaffold extends StatelessWidget{
  final Widget body;
  const MyScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Register', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.amber,
      ),
      drawer: const MyDrawer(),
      bottomNavigationBar: const BottomAppBar(color: Colors.amber,),
      body: body,
    );
  }
}