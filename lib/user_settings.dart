import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Night Owl",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Pacifico',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF123456),
        ),

        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 0),
          decoration: const BoxDecoration(
            color: Colors.black87,
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [

            ],
          ),
        )
    );
  }
}

class DatePickerButton extends StatefulWidget {
  @override
  _DatePickerButtonState createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Date Picker Button")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _selectDate(context),
          child: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
        ),
      ),
    );
  }
}
