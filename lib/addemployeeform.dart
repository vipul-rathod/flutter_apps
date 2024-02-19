import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:owner_form_app/models/data_model.dart';
import 'package:owner_form_app/myscaffold.dart';
import 'dart:async';
import 'package:owner_form_app/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:owner_form_app/models/employee.dart';
import 'package:owner_form_app/employeelist1.dart';
import 'package:hive/hive.dart';

List<String> list = <String>['Fresher', 'Experienced'];

// Form creation to add employees to the app.
class AddEmployeeForm extends StatefulWidget {
  const AddEmployeeForm({super.key});

  @override
  AddEmployeeFormState createState() => AddEmployeeFormState();
}

class AddEmployeeFormState extends State<AddEmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  // Define variables and assign default value for submitting to database
  var selectedGender = 'male';
  var confirmationBool = false;
  var expLevel = 'Fresher';
// SQFlite database instance
  final DatabaseHelper instance = DatabaseHelper.instance;
// Hive Box constraint declaration
  Box<DataModel>? userBox;

// TextEditingController to get and update the value of textfields
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

//Query data from SQFlite database
  Future<List<Employee>> getEmployees() async{
    return await instance.getApplication();
  }

  @override
  Widget build(BuildContext context){
    return MyScaffold(
        title: 'Employee Form',
        body: Container(
          padding: const EdgeInsets.symmetric(vertical:16),
          color: const Color.fromARGB(255, 254, 252, 239),
          height: 900,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: nameController,
                            autocorrect: false,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"),)],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.teal),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              labelText: 'Employee Name',
                              hintText: 'Enter name of employee',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty){
                                return "Please enter some text in the field";
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                          ),
                    ),
                    ],),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      focusNode: AlwaysDisabledFocusNode(),
                      controller: dobController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3)
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Select the date of birth',
                        hintText: 'Date Of Birth format is DD/MM/YYYY',

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty){
                          return "Please enter numbers in the field";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onTap: () {
                        // DateTime dateTime = DateTime.now();
                        void showDatePickerTool() {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2025),
                            ).then((value) {
                              if (value != null){
                                dobController.text = '${value.day}-${value.month}-${value.year}';
                              }
                            }
                          );
                        }
                        showDatePickerTool();
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: phoneController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Telephone No.',
                        hintText: 'Enter phone number',

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty){
                          return "Please enter numbers in the field";
                        }
                        if (value.length >= 11 || value.length <= 9){
                          return " ${10 - value.length} digit more to go..";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  DropDownBoxExample(
                    onChanged: (value){
                      expLevel = value;
                    },
                  ),
                  RadioBtn(
                    onChanged: (value){
                      selectedGender = value;
                    }
                  ),
                  CheckboxExample(
                    onChanged: (value){
                      confirmationBool = value;
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Column(
                      children: <Widget>[ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // SQFlite submit
                            _insert(nameController.text, dobController.text, phoneController.text, expLevel, selectedGender, confirmationBool);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ApplicationBuilder(future: getEmployees())));

                            // HIVE submit
                            _insertHive(nameController.text, dobController.text, phoneController.text, expLevel, selectedGender, confirmationBool);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AppBuilder(future: _getDataHive())));

                          }
                        },
                        child: const Text('Submit', style: TextStyle(color: Colors.black)),
                        ),]
                    ),),
                ],),
          ),
        ),
      ),
    );
  }

// Function to insert data to sqflite database.
  _insert(name, dob, phone, expLevel, gender, confirmation) async {
    Database db = await DatabaseHelper.instance.database;
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : name,
      DatabaseHelper.columnDOB : dob,
      DatabaseHelper.columnPhone : phone,
      DatabaseHelper.columnExpLevel: expLevel,
      DatabaseHelper.columnGender: gender,
      DatabaseHelper.columnConfirmation: confirmation,
    };
    int id = await db.insert(DatabaseHelper.table, row);
    return id;
  }

// Function to insert data to hive database.
  _insertHive(name, dob, phone, expLevel, gender, confirmation) async {
    DataModel dataModel = DataModel(name: name, dob: dob, phone: phone, expLevel: expLevel, gender: gender, confirmation: confirmation);
    Box<DataModel> dbBox = Hive.box('employee_box');
    dbBox.add(dataModel);
  }

// Future function to get data from Hive box
  Future<List<DataModel>> _getDataHive()async{
    Box<DataModel> userBox = Hive.box('employee_box');
    List<DataModel> items = userBox.values.toList();
    return items;
  }
}

// Dropdown creation to select Experience Level.
class DropDownBoxExample extends StatefulWidget {
  final Function(String) onChanged;
  const DropDownBoxExample({super.key, required this.onChanged});

  @override
  State<DropDownBoxExample> createState() => _DropDownBoxExampleState();
}

class _DropDownBoxExampleState extends State<DropDownBoxExample> {
  String dropdownvalue = list.first;

  @override
  Widget build(BuildContext context){
    return DropdownButton<String>(
      value: dropdownvalue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String? value) {
        widget.onChanged.call(value!);
        setState((){
          dropdownvalue = value;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(fontSize: 20)),
        );
      }).toList(),
    );
  }
}

// Radio Button class creation to add buttons for Gender.
enum Gender {male, female}
class RadioBtn extends StatefulWidget {
  final Function(String)? onChanged;
  const RadioBtn({super.key, required this.onChanged});
  @override
  RadioBtnState createState() => RadioBtnState();
}

class RadioBtnState extends State<RadioBtn> {
  Gender? _gender = Gender.male;

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          const Expanded(child: ListTile(contentPadding: EdgeInsets.all(0.0), title: Text('Select gender: '))),
          Expanded(
            child: ListTile(
              contentPadding: const EdgeInsets.all(0.0),
              title: const Text('Male'),
              leading: Radio<Gender>(
                value: Gender.male,
                groupValue: _gender,
                onChanged: (Gender? value) {
                  widget.onChanged?.call(value!.name);
                  setState((){
                    _gender = value;
                  });
                },
              ),
            ),),
          Expanded(
            child: ListTile(
              contentPadding: const EdgeInsets.all(0.0),
              title: const Text('Female'),
              leading: Radio<Gender>(
                value: Gender.female,
                groupValue: _gender,
                onChanged: (Gender? value){
                  widget.onChanged?.call(value!.name);
                  setState(() {
                    _gender = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Checkbox class creation to add checkbox to the UI.
class CheckboxExample extends StatefulWidget {
  final Function(bool) onChanged;
  const CheckboxExample({super.key, required this.onChanged});
  @override
  State<CheckboxExample> createState() => CheckboxExampleState();
}

class CheckboxExampleState extends State<CheckboxExample>{
  bool isChecked = false;
  @override
  Widget build(BuildContext context){
    return CheckboxListTile(
      title: const Text('Confirm the above details'),
      value: isChecked,
      onChanged: (bool? value){
        widget.onChanged.call(value!);
        setState((){
          isChecked = value;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

// Set focus of any fields to readonly.
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

