import 'package:flutter/material.dart';
import 'package:owner_form_app/myscaffold.dart';
import 'package:owner_form_app/addemployeeform.dart';

class MyHomeViewSmall extends StatefulWidget {
  const MyHomeViewSmall({super.key});
  @override
  State<MyHomeViewSmall> createState() => MyHomeViewSmallState();
}

class MyHomeViewSmallState extends State<MyHomeViewSmall>{
  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context){
    return MyScaffold(
      body: Container(
        color: const Color.fromARGB(255, 254, 252, 239),
        child: IndexedStack(
          index: _currentIndex,
          children: [
            Padding(
              padding: EdgeInsets.zero,
              child: Center(
                child:TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.grey,),
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const AddEmployeeForm()));},
                child: const Text('Application Form'),
              ))),],
        ),
      ),
    );
  }
}