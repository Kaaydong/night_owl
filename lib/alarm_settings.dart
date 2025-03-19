import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlarmSettings extends StatefulWidget {
  const AlarmSettings({super.key});

  @override
  State<AlarmSettings> createState() => _AlarmSettingsState();
}

class _AlarmSettingsState extends State<AlarmSettings> {
  // TIME PICKER STUFF
  TimeOfDay? selectedTime = TimeOfDay.now();
  TimePickerEntryMode entryMode = TimePickerEntryMode.dial;
  Orientation? orientation;
  TextDirection textDirection = TextDirection.ltr;
  MaterialTapTargetSize tapTargetSize = MaterialTapTargetSize.padded;
  bool use24HourTime = false;

  // DAY OF WEEK STUFF
  bool mon = false; // Boolean value to be passed to the button
  bool tue = false;
  bool wed = false;
  bool thu = false;
  bool fri = false;
  bool sat = false;
  bool sun = false;

  // SLEEP CYCLE STUFF
  bool useAge = false;
  int sleepCycle = 0;
  final TextEditingController sleepCycleDurationController = TextEditingController(text: "");

  // TARGET SLEEP STUFF
  int hours = 0;
  int minutes = 0;
  final TextEditingController targetSleepHoursController = TextEditingController(text: "");
  final TextEditingController targetSleepMinutesController = TextEditingController(text: "");

  // GO-TO SLEEP STUFF
  bool isReminderEnabled = true;
  int minutesToSleep = 0;
  final TextEditingController minutesToSleepController = TextEditingController(text: "");

  void updateMon(bool newValue) {
    setState(() {
      mon = newValue; // Update the boolean value
    });
  }
  void updateTue(bool newValue) {
    setState(() {
      tue = newValue; // Update the boolean value
    });
  }
  void updateWed(bool newValue) {
    setState(() {
      wed = newValue; // Update the boolean value
    });
  }
  void updateThu(bool newValue) {
    setState(() {
      thu = newValue; // Update the boolean value
    });
  }
  void updateFri(bool newValue) {
    setState(() {
      fri = newValue; // Update the boolean value
    });
  }
  void updateSat(bool newValue) {
    setState(() {
      sat = newValue; // Update the boolean value
    });
  }
  void updateSun(bool newValue) {
    setState(() {
      sun = newValue; // Update the boolean value
    });
  }
  void updateUseAge(bool newValue) {
    setState(() {
      useAge = newValue; // Update the boolean value
      if (newValue) {
        sleepCycleDurationController.text = "70";
      }
      else {
        sleepCycleDurationController.text = "";
      }
    });
  }

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
            Padding(
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Alarm Settings",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white54,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(350,100),
                          backgroundColor: Colors.blueGrey,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          selectedTime == null ? TimeOfDay.now().format(context) : selectedTime!.format(context),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            color: Colors.white54,
                          ),
                        ),
                        onPressed: () async {
                          final TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: selectedTime ?? TimeOfDay.now(),
                            initialEntryMode: entryMode,
                            orientation: orientation,
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  timePickerTheme: TimePickerThemeData(
                                    dayPeriodColor: Colors.blueGrey,
                                    hourMinuteTextStyle: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    helpTextStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey, // Change "Enter Time" text color
                                    ),
                                  ),
                                  colorScheme: ColorScheme.light(
                                    primary: Colors.blueGrey, // Selected date highlight
                                    onPrimary: Colors.white54, // Text color on selected date
                                    onSurface: Colors.blueGrey, // Default text color
                                    surface: Color(0xFF123456),// Text color on body
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white60, // Button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          setState(() {
                            selectedTime = time;
                          });
                        },
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ToggleButton(text: "Mon", value: mon, onChanged: updateMon, width: 70, height: 50,),
                          SizedBox(width: 5,),
                          ToggleButton(text: "Tue", value: tue, onChanged: updateTue, width: 70, height: 50,),
                          SizedBox(width: 5,),
                          ToggleButton(text: "Wed", value: wed, onChanged: updateWed, width: 70, height: 50,),
                          SizedBox(width: 5,),
                          ToggleButton(text: "Thu", value: thu, onChanged: updateThu, width: 70, height: 50,),
                          SizedBox(width: 5,),
                          ToggleButton(text: "Fri", value: fri, onChanged: updateFri, width: 70, height: 50,),
                        ]
                      ),
                      SizedBox(height: 15,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ToggleButton(text: "Sat", value: sat, onChanged: updateSat, width: 150, height: 50,),
                            SizedBox(width: 40,),
                            ToggleButton(text: "Sun", value: sun, onChanged: updateSun, width: 150, height: 50,),
                          ]
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 200,
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sleep Cycle Duration",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white54,
                        ),
                      ),
                      SizedBox(height: 7,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 220,
                            height: 60,
                            child: TextField(
                              controller: sleepCycleDurationController,
                              keyboardType: TextInputType.number, // Numeric keyboard
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white54,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blueGrey,
                                hintText: 'Enter Cycle Duration',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(
                                    color: Colors.white30, // Border color when not focused
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(
                                    color: Colors.white30, // Border color when focused
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16,),
                          Container(
                            width: 100,
                            height: 60,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Minutes",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: ToggleButton(
                          text: "Determine with Age",
                          value: useAge,
                          onChanged: updateUseAge,
                          width: 300,
                          height: 30,
                        ),
                      )
                    ],
                  ),
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 220,
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Target Sleep Amount",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white54,
                        ),
                      ),
                      SizedBox(height: 7,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 220,
                            height: 60,
                            child: TextField(
                              controller: targetSleepHoursController,
                              keyboardType: TextInputType.number, // Numeric keyboard
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white54,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blueGrey,
                                hintText: 'Enter Hours',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(
                                    color: Colors.white30, // Border color when not focused
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(
                                    color: Colors.white30, // Border color when focused
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16,),
                          Container(
                            width: 100,
                            height: 60,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Hours",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 220,
                            height: 60,
                            child: TextField(
                              controller: targetSleepMinutesController,
                              keyboardType: TextInputType.number, // Numeric keyboard
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white54,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blueGrey,
                                hintText: 'Enter Minutes',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(
                                    color: Colors.white30, // Border color when not focused
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(
                                    color: Colors.white30, // Border color when focused
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16,),
                          Container(
                            width: 100,
                            height: 60,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Minutes",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 200,
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38, width: 2.0),
                  borderRadius: BorderRadius.circular(14.0),
                  color: isReminderEnabled ? Color(0xFF123456): Colors.white10,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Go-To Sleep Reminder",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: isReminderEnabled ? Colors.white54: Colors.white30,
                        ),
                      ),
                      SizedBox(height: 7,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 220,
                            height: 60,
                            child: TextField(
                              controller: minutesToSleepController,
                              keyboardType: TextInputType.number, // Numeric keyboard
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white54,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: isReminderEnabled ? Colors.blueGrey: Colors.white30,
                                hintText: 'Enter Minutes',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(
                                    color: Colors.white30, // Border color when not focused
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(
                                    color: Colors.white30, // Border color when focused
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16,),
                          SizedBox(
                            width: 100,
                            height: 60,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Minutes",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: isReminderEnabled ? Colors.white54: Colors.white30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isReminderEnabled ? "Enabled": "Disabled",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: isReminderEnabled ? Colors.white54: Colors.white30,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Switch(
                            value: isReminderEnabled,
                            onChanged: (value) {
                              setState(() {
                                isReminderEnabled = value;
                              });
                            },
                            activeColor: Colors.white, // Color of the switch handle when on
                            activeTrackColor: Colors.blueGrey, // Background color when switch is on
                            inactiveTrackColor: Colors.white10, // Background color when switch is off
                            inactiveThumbColor: Colors.black87, // Color of the switch handle when off
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

class ToggleButton extends StatefulWidget {
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;
  
  const ToggleButton({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
    required this.width,
    required this.height,
  });

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => widget.onChanged(!widget.value), // Toggle the value
      style: ElevatedButton.styleFrom(
        minimumSize: Size(widget.width, widget.height),
        backgroundColor: widget.value ? Colors.blueGrey: Colors.white10,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90),
        ),
      ),
      child: Text(
        widget.text,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: widget.value ? Color(0xFFC6C0C0): Colors.white30,
        ),
      ),
    );
  }
}