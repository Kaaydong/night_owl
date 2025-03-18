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
              UserProfile(username: "Kayden"),
              TwentyFourHourSelector(is_24_hours_enabled: true),
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
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blueGrey, // Selected date highlight
              onPrimary: Colors.white54, // Text color on selected date
              onSurface: Colors.blueGrey, // Default text color
              surface: Color(0xFF123456),
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _selectDate(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        DateFormat('MM-dd-yyyy').format(selectedDate),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.white54,
        ),
      ),
    );
  }
}

class UserProfile extends StatefulWidget {
  final String username;

  const UserProfile({
    super.key,
    required this.username,
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 340,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38, width: 2.0),
          borderRadius: BorderRadius.circular(14.0),
          color: Color(0xFF123456),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [
            SizedBox(
              width: 370,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white30,
                      ),
                    ),
                    TextFormField(
                      initialValue: widget.username,
                      readOnly: true,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white54,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey, // Background color
                        hintText: 'Enter text',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.blueGrey, // Border color when not focused
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.blueGrey, // Border color when focused
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25,),
                    Text(
                      "Birthday",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white30,
                      ),
                    ),
                    DatePickerButton(),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

class TwentyFourHourSelector extends StatefulWidget {
  final bool is_24_hours_enabled;
  const TwentyFourHourSelector({
    super.key,
    required this.is_24_hours_enabled,
  });

  @override
  State<TwentyFourHourSelector> createState() => _TwentyFourHourSelectorState();
}

class _TwentyFourHourSelectorState extends State<TwentyFourHourSelector> {
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.is_24_hours_enabled; // Set the initial switch state
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38, width: 2.0),
          borderRadius: BorderRadius.circular(14.0),
          color: Color(0xFF123456),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "24-Hour Time",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: isSwitched ? Color(0xFFC6C0C0): Colors.white30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                      activeColor: Colors.white, // Color of the switch handle when on
                      activeTrackColor: Colors.blueGrey, // Background color when switch is on
                      inactiveTrackColor: Colors.white10, // Background color when switch is off
                      inactiveThumbColor: Colors.black87, // Color of the switch handle when off
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

