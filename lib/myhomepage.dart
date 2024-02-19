
import 'package:flutter/material.dart';
import 'package:owner_form_app/myhomeviewsmall.dart';
import 'package:owner_form_app/myhomeviewlarge.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          if (constraints.maxWidth < 600){
            return const MyHomeViewSmall();
          }
          else{
            return const MyHomeViewLarge();
          }
        },
      ),
    );
  }
}
