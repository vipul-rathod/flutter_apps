import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:owner_form_app/myhomepage.dart';
import 'package:owner_form_app/myscaffold.dart';

List<String> list = <String>['Fresher', 'Experienced'];
List controllerList = [];

class AddEmployeeForm extends StatefulWidget {
  const AddEmployeeForm({super.key});
  @override
  AddEmployeeFormState createState() => AddEmployeeFormState();
}

class AddEmployeeFormState extends State<AddEmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController checkboxController = TextEditingController();
  
  @override
  Widget build(BuildContext context){

  Future<bool> exitConfirm() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text("Exit"),
          content: const Text('Are you sure to go back?'),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop(true);
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyHomePage()));
            },
                        child: const Text('Yes')),
            TextButton(onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('No')),
          ],
        ),
    );
  }

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop){return;} exitConfirm();
      },

      child: MyScaffold(
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
                        // if (value.length > 3 || double.parse(value) > 100){
                        //   return 'Age cannot be more than 100years';
                        // }
                        // if (double.parse(value) < 21){
                        //   return 'Age should be above 21++';
                        // }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onTap: () {
                        DateTime _dateTime = DateTime.now();
                        void _showDatePicker() {
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
                        _showDatePicker();
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
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  const DropDownBoxExample(),
                  const RadioBtn(),
                  const CheckboxExample(),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Column(
                      children: <Widget>[ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controllerList = [nameController.text, dobController.text, phoneController.text];
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar (content: Text('$controllerList')),
                            );
                          }
                        },
                        child: const Text('Submit', style: TextStyle(color: Colors.black)),
                        ),]
                    ),),

                ],),
          ),
        ),
      ),
      ),
    );
  }
}

enum Gender {male, female}
class RadioBtn extends StatefulWidget {
  const RadioBtn({super.key});
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
              leading: Radio(
                value: Gender.male,
                groupValue: _gender,
                onChanged: (Gender? value) {
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
              leading: Radio(
                value: Gender.female,
                groupValue: _gender,
                onChanged: (Gender? value){
                  setState((){
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

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({super.key});
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
        setState((){
          isChecked = value!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class DropDownBoxExample extends StatefulWidget {
  const DropDownBoxExample({super.key});


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
        setState((){
          dropdownvalue = value!;
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
