import 'package:flutter/material.dart';
import 'package:owner_form_app/mydrawer.dart';

class MyScaffold extends StatelessWidget{
  final Widget body;
  final String title;
  const MyScaffold({super.key, required this.body, required this.title});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.amber,
      ),
      drawer: const MyDrawer(),
      bottomNavigationBar: const BottomAppBar(color: Colors.amber,),
      body: body,
    );
  }
}