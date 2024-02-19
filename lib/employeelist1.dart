import 'package:flutter/material.dart';
import 'package:owner_form_app/models/employee.dart';
import 'package:owner_form_app/myscaffold.dart';
import 'package:owner_form_app/addemployeeform.dart';
import 'package:owner_form_app/models/data_model.dart';

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
        return Scaffold(
          body: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final employee = snapshot.data![index];
              return buildEmployeeCard(employee, context);
            },
            ),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const AddEmployeeForm()));
            },
            tooltip: 'Add Employee',
            child: const Icon(Icons.add),
          ),

          );
        },
      ),
    );
  }

  Widget buildEmployeeCard(Employee employee, BuildContext context){
    return Card(
            color:  Colors.white,
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Text('${employee.id}'),
              ),
              title: Text(employee.name.toString()),
              subtitle: Text(employee.phone.toString()),
              trailing: const Icon(Icons.delete, color: Colors.deepOrangeAccent),
              onTap: () {
                debugPrint(employee.name);
              }
            ),
          );
        }

}

class AppBuilder extends StatelessWidget {
  const AppBuilder({super.key, required this.future});
  final Future<List<DataModel>> future;

  @override
  Widget build(BuildContext context){
    return MyScaffold(
      title: 'Employee List Hive',
      body: FutureBuilder<List<DataModel>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            print(snapshot.data);
            return const Center(child: CircularProgressIndicator(),);
          }
          return Scaffold(
            body: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                final dataModel = snapshot.data![index];
                return buildEmployeeCard(dataModel, context);
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildEmployeeCard(DataModel dataModel, BuildContext context){
    return Card(
      color: Colors.white,
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.yellow,
          child: Text('${dataModel.key}'),
        ),
        title: Text(dataModel.name.toString()),
        subtitle: Text(dataModel.phone.toString()),
        trailing: const Icon(Icons.delete, color: Colors.deepOrangeAccent),
        onTap: () {
          debugPrint(dataModel.name);
        },
      ),
    );
  }
}