import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:night_owl/home_screen.dart';

class AlarmOptions extends StatefulWidget {
  final String userId;
  final String alarmId;
  final int order;
  final bool isEnabled;
  final int hour;
  final int minute;
  final bool mon;
  final bool tue;
  final bool wed;
  final bool thu;
  final bool fri;
  final bool sat;
  final bool sun;
  final bool useAge;
  final int sleepCycle;
  final int targetSleepHours;
  final int targetSleepMinutes;
  final bool isReminderEnabled;
  final int minutesToSleep;
  final bool isSnoozeEnabled;
  final int snoozeInterval;

  final bool is24Hour;
  final DateTime birthday;

  const AlarmOptions({
    super.key,
    required this.userId,
    required this.alarmId,
    required this.order,
    required this.isEnabled,
    required this.hour,
    required this.minute,
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    required this.sat,
    required this.sun,
    required this.useAge,
    required this.sleepCycle,
    required this.targetSleepHours,
    required this.targetSleepMinutes,
    required this.isReminderEnabled,
    required this.minutesToSleep,
    required this.isSnoozeEnabled,
    required this.snoozeInterval,
    required this.is24Hour,
    required this.birthday,
  });

  @override
  State<AlarmOptions> createState() => _AlarmOptionsState();
}

class _AlarmOptionsState extends State<AlarmOptions> {

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
  final TextEditingController sleepCycleDurationController = TextEditingController(text: "");

  // TARGET SLEEP STUFF
  final TextEditingController targetSleepHoursController = TextEditingController(text: "");
  final TextEditingController targetSleepMinutesController = TextEditingController(text: "");

  // GO-TO SLEEP STUFF
  bool isReminderEnabled = true;
  final TextEditingController minutesToSleepController = TextEditingController(text: "");

  // Snooze STUFF
  bool isSnoozeEnabled = true;
  final TextEditingController snoozeTimeController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    if(widget.hour != -1) selectedTime = TimeOfDay(hour: widget.hour, minute: widget.minute);
    mon = widget.mon;
    tue = widget.tue;
    wed = widget.wed;
    thu = widget.thu;
    fri = widget.fri;
    sat = widget.sat;
    sun = widget.sun;
    useAge = widget.useAge;

    isReminderEnabled = widget.isReminderEnabled;
    isSnoozeEnabled = widget.isSnoozeEnabled;
    use24HourTime = widget.is24Hour;

    if(widget.sleepCycle != -1) sleepCycleDurationController.text = widget.sleepCycle.toString();
    if(widget.targetSleepHours != -1) targetSleepHoursController.text = widget.targetSleepHours.toString();
    if(widget.targetSleepMinutes != -1) targetSleepMinutesController.text = widget.targetSleepMinutes.toString();
    if(widget.minutesToSleep != -1) minutesToSleepController.text = widget.minutesToSleep.toString();
    if(widget.snoozeInterval != -1) snoozeTimeController.text = widget.snoozeInterval.toString();
  }

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
        int age = DateTime.now().difference(widget.birthday).inDays ~/ 365;

        if (age < 5) {
          sleepCycleDurationController.text = "70";
        }
        else if (age < 20) {
          sleepCycleDurationController.text = "110";
        }
        else if (age < 65) {
          sleepCycleDurationController.text = "90";
        }
        else {
          sleepCycleDurationController.text = "70";
        }
      }
      else {
        sleepCycleDurationController.text = "";
      }
    });
  }
  void submitSettings() {
    final alarm = <String, dynamic>{
      "order": 1,
      "isEnabled": widget.isEnabled,
      "hour": selectedTime!.hour,
      "minute": selectedTime!.minute,
      "mon": mon,
      "tue": tue,
      "wed": wed,
      "thu": thu,
      "fri": fri,
      "sat": sat,
      "sun": sun,
      "useAge": useAge,
      "sleepCycle": 69, //int.parse(sleepCycleDurationController.text),
      "targetSleepHours": int.parse(
          targetSleepHoursController.text == "" ? "7" : targetSleepHoursController.text
      ),
      "targetSleepMinutes": int.parse(
          targetSleepMinutesController.text == "" ? "30" : targetSleepMinutesController.text
      ),
      "isReminderEnabled": isReminderEnabled,
      "minutesToSleep": int.parse(
          minutesToSleepController.text == "" ? "20" : minutesToSleepController.text
      ),
      "isSnoozeEnabled": false,//isSnoozeEnabled,
      "snoozeInterval": 69,//int.parse(snoozeTimeController.text),
    };

    if(widget.alarmId == "-1"){
      addAlarm(alarm, widget.userId);
    }
    else{
      setAlarm(alarm, widget.userId, widget.alarmId.toString());
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(isFirstLogin: false,),
      )
    );
  }

  void addAlarm(Map<String, dynamic> userInfoMap, String userId) async{
    FirebaseFirestore.instance
      .collection("users")
      .doc(userId)
      .collection("timers")
      .add(userInfoMap).then(
            (querySnapshot) {
          print("Successfully completed");
        },
        onError: (e) => print("Error completing: $e"),
    );
  }

  void setAlarm(Map<String, dynamic> userInfoMap, String userId, String alarmId) async{
    FirebaseFirestore.instance
      .collection("users")
      .doc(userId)
      .collection("timers")
      .doc(alarmId)
      .set(userInfoMap);
  }

  String formatTimeOfDay(TimeOfDay tod, BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    return localizations.formatTimeOfDay(tod, alwaysUse24HourFormat: use24HourTime);
  }

  String getTimeFormatted(){
    return formatTimeOfDay(selectedTime ?? TimeOfDay.now(), context);
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
                          fontSize: 22,
                          color: Colors.white54,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(330,100),
                          backgroundColor: Colors.blueGrey,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          getTimeFormatted(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 44,
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
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    helpTextStyle: TextStyle(
                                      fontSize: 14,
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
                                child: Directionality(
                                  textDirection: textDirection,
                                  child: MediaQuery(
                                    data: MediaQuery.of(context,
                                    ).copyWith(alwaysUse24HourFormat: use24HourTime),
                                    child: child!,
                                  )
                                ),
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
                          ToggleButton(text: "Mon", value: mon, onChanged: updateMon, width: 55, height: 50,),
                          SizedBox(width: 4,),
                          ToggleButton(text: "Tue", value: tue, onChanged: updateTue, width: 55, height: 50,),
                          SizedBox(width: 4,),
                          ToggleButton(text: "Wed", value: wed, onChanged: updateWed, width: 55, height: 50,),
                          SizedBox(width: 4,),
                          ToggleButton(text: "Thu", value: thu, onChanged: updateThu, width: 55, height: 50,),
                          SizedBox(width: 4,),
                          ToggleButton(text: "Fri", value: fri, onChanged: updateFri, width: 55, height: 50,),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ToggleButton(text: "Sat", value: sat, onChanged: updateSat, width: 130, height: 50,),
                          SizedBox(width: 40,),
                          ToggleButton(text: "Sun", value: sun, onChanged: updateSun, width: 130, height: 50,),
                        ],
                      ),
                    ],
                  ),
                ),
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
                          fontSize: 22,
                          color: Colors.white54,
                        ),
                      ),
                      SizedBox(height: 7,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 175,
                            height: 60,
                            child: TextField(
                              controller: targetSleepHoursController,
                              keyboardType: TextInputType.number, // Numeric keyboard
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
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
                                  fontSize: 22,
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
                            width: 175,
                            height: 60,
                            child: TextField(
                              controller: targetSleepMinutesController,
                              keyboardType: TextInputType.number, // Numeric keyboard
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
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
                                  fontSize: 22,
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
                          fontSize: 22,
                          color: isReminderEnabled ? Colors.white54: Colors.white30,
                        ),
                      ),
                      SizedBox(height: 7,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 175,
                            height: 60,
                            child: TextField(
                              readOnly: !isReminderEnabled,
                              controller: minutesToSleepController,
                              keyboardType: TextInputType.number, // Numeric keyboard
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
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
                                  fontSize: 22,
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
                              fontSize: 22,
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
            Padding(
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
                child: Center(
                  child: ElevatedButton(
                    onPressed: () => submitSettings(),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(350, 65),
                      backgroundColor: Colors.blueGrey,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                    child: Text(
                      "Submit",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Color(0xFFC6C0C0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
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
          fontSize: 10,
          color: widget.value ? Color(0xFFC6C0C0): Colors.white30,
        ),
      ),
    );
  }
}