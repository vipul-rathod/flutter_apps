import 'package:flutter/material.dart';


class CustomeDateTimePicker extends StatefulWidget {
  const CustomeDateTimePicker({super.key});

  @override
  State<CustomeDateTimePicker> createState() => _CustomeDateTimePickerState();
}

class _CustomeDateTimePickerState extends State<CustomeDateTimePicker>{

  DateTime _dateTime = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
      ).then((value) {
        setState(() {
          _dateTime = value!;
        });
      }
    );
  }

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(_dateTime.toString(), style: const TextStyle(fontSize: 20)),
        MaterialButton(
        onPressed: _showDatePicker,
        color: Colors.blue,
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Text('Choose Date', style: TextStyle(color: Colors.white, fontSize: 25)),
        ),
        
        ),
      ],);
  }
}


// class CustomeDateTimePicker extends StatefulWidget {
//   const CustomeDateTimePicker({super.key, this.labelText, this.hintText, this.onValidate, this.onSaved});

//   final String? labelText;
//   final String? hintText;
//   final String? Function(String?)? onValidate;
//   final Function(String?)? onSaved;

//   @override
//   State<CustomeDateTimePicker> createState() => _CustomeDateTimePickerState();
// }

// class _CustomeDateTimePickerState extends State<CustomeDateTimePicker>{
//   DateTime? _selectedDate;
//   @override
//   Widget build(BuildContext context){
//     return CalendarDatePicker(initialDate: DateTime.now(), firstDate: DateTime(1947), lastDate: DateTime.now().add(const Duration(days: 365)), onDateChanged: (val) {setState((){_selectedDate=val;});},);
//   }
// }
