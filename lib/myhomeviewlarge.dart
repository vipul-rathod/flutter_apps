
import 'package:flutter/material.dart';
import 'package:owner_form_app/mydrawer.dart';
import 'package:owner_form_app/addemployeeform.dart';

class MyHomeViewLarge extends StatefulWidget {
  const MyHomeViewLarge({super.key});
  @override
  State<MyHomeViewLarge> createState() => MyHomeViewLargeState();
}

class MyHomeViewLargeState extends State<MyHomeViewLarge> {
  final int _index = 0;

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Expanded(
            flex: 2,
            child: MyDrawer(),
          ),
          Expanded(
            flex: 3,
            child: IndexedStack(
              index: _index,
              children: [
                Padding(
                  padding: EdgeInsets.zero,
                  child: Center(
                    child:TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.grey,),
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                    onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const AddEmployeeForm()));},
                    child: const Text('Application Form'),
                    )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}