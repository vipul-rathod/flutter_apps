import 'package:flutter/material.dart';
import 'package:owner_form_app/models/employee.dart';
import 'package:owner_form_app/myscaffold.dart';

class ApplicationBuilder extends StatelessWidget {
  const ApplicationBuilder({super.key, required this.future});

  final Future<List<Employee>> future;

  @override
  Widget build(BuildContext context){
    return MyScaffold(
      title: 'Employee List',
      body: FutureBuilder<List<Employee>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final employee = snapshot.data![index];
              return buildEmployeeCard(employee, context);
            }
          
          ),
        
        );
      },
    ),
    );
  }

  Widget buildEmployeeCard(Employee employee, BuildContext context){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              alignment: Alignment.center,
              child: Text(employee.id.toString(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.name,
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4.0,),
                  Text(employee.phone),
                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}