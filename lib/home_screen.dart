import 'package:flutter/material.dart';
import 'package:night_owl/alarm_settings.dart';
import 'package:night_owl/user_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  final bool isFirstLogin;

  const HomeScreen({
    super.key,
    required this.isFirstLogin,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var alarmList = [];
  int count = 0;
  late User user;
  late String uid;
  late String email;
  late int birthdayDay;
  late int birthdayMonth;
  late int birthdayYear;
  late bool twentyFourHourEnabled;

  void createUserSettings(String userId) async{
    setState(() {
      birthdayDay = 1;
      birthdayMonth = 1;
      birthdayYear = 2000;
      twentyFourHourEnabled = false;
    });

    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set({
          "birthdayDay": birthdayDay,
          "birthdayMonth": birthdayMonth,
          "birthdayYear": birthdayYear,
          "twentyFourHourEnabled": twentyFourHourEnabled,
    });
  }

  Future getUserSettings(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .get().then(
          (querySnapshot) {
        print("Successfully completed");

        setState(() {
          birthdayDay = querySnapshot.data()!["birthdayDay"];
          birthdayMonth = querySnapshot.data()!["birthdayMonth"];
          birthdayYear = querySnapshot.data()!["birthdayYear"];
          twentyFourHourEnabled = querySnapshot.data()!["twentyFourHourEnabled"];
        });
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  Future getUserAlarms(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("timers")
        .get().then(
          (querySnapshot) {
        print("Successfully completed");

        for (var docSnapshot in querySnapshot.docs) {
          setState(() {
            alarmList.add(docSnapshot);
            count++;
          });
          //print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  void initState() {
    super.initState();

    final FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser!;
    uid = user.uid;
    email = user.email!;

    if (widget.isFirstLogin){
      createUserSettings(uid);
    }
    else {
      getUserSettings(uid);
    }

    getUserAlarms(uid);
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
            children: <Widget>[
              Container(
                height: 40.0,
                color: Color(0xFF0B253E),
                child: ListView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.format_list_bulleted),
                      color: Color(0xFFC6C0C0),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context){
                                  return UserSettings(
                                    email: email,
                                    birthdayDay: birthdayDay,
                                    birthdayMonth: birthdayMonth,
                                    birthdayYear: birthdayYear,
                                    twentyFourHourEnabled: twentyFourHourEnabled,
                                  );
                                })
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      color: Color(0xFFC6C0C0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlarmSettings(
                              userId: uid,
                              alarmId: "-1",
                              order: count+1,
                              isEnabled: true,
                              hour: -1,
                              minute: -1,
                              mon: true,
                              tue: true,
                              wed: true,
                              thu: true,
                              fri: true,
                              sat: false,
                              sun: false,
                              useAge: false,
                              sleepCycle: -1,
                              targetSleepHours: -1,
                              targetSleepMinutes: -1,
                              isReminderEnabled: true,
                              minutesToSleep: -1,
                              isSnoozeEnabled: true,
                              snoozeInterval: -1,
                              is24Hour: false,
                            ),
                          )
                        );
                      },
                    ),
                  ],
                ),
              ),
              for (var alarm in alarmList)
                TimerItem(
                  userId: uid,
                  alarmId: '${alarm.id}',
                  order: alarm.data()["order"],
                  isEnabled: alarm.data()['isEnabled'],
                  hour: alarm.data()["hour"],
                  minute: alarm.data()["minute"],
                  mon: alarm.data()["mon"],
                  tue: alarm.data()["tue"],
                  wed: alarm.data()["wed"],
                  thu: alarm.data()["thu"],
                  fri: alarm.data()["fri"],
                  sat: alarm.data()["sat"],
                  sun: alarm.data()["sun"],
                  useAge: alarm.data()["useAge"],
                  sleepCycle: alarm.data()["sleepCycle"],
                  targetSleepHours: alarm.data()["targetSleepHours"],
                  targetSleepMinutes: alarm.data()["targetSleepMinutes"],
                  isReminderEnabled: alarm.data()["isReminderEnabled"],
                  minutesToSleep: alarm.data()["minutesToSleep"],
                  isSnoozeEnabled: alarm.data()["isSnoozeEnabled"],
                  snoozeInterval: alarm.data()["snoozeInterval"],
                  is24Hour: twentyFourHourEnabled,
                ),
            ],
          ),
        )
    );
  }
}



// Child Stateful Widget
class TimerItem extends StatefulWidget {
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

  const TimerItem({
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
  });


  @override
  State<TimerItem> createState() => _TimerItemState();
}

class _TimerItemState extends State<TimerItem> {
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.isEnabled; // Set the initial switch state
  }

  String getFormattedTime() {
    int time = widget.hour * 100 + widget.minute;
    int hourTime;
    int minuteTime;
    if(widget.is24Hour){
      hourTime = time ~/ 100;
      minuteTime = time % 100;
      return "${returnNumberFormatted(hourTime)}:${returnNumberFormatted(minuteTime)}";
    }
    else{
      if(time >= 1300){
        hourTime = time ~/ 100 - 12;
        minuteTime = time % 100;
        return "${returnNumberFormatted(hourTime)}:${returnNumberFormatted(minuteTime)} pm";
      }
      else if(time >= 1200){
        hourTime = 12;
        minuteTime = time % 100;
        return "${returnNumberFormatted(hourTime)}:${returnNumberFormatted(minuteTime)} pm";
      }
      else if(time >= 0 && time < 100){
        hourTime = 12;
        minuteTime = time % 100;
        return "${returnNumberFormatted(hourTime)}:${returnNumberFormatted(minuteTime)} am";
      }
      else{
        hourTime = time ~/ 100;
        minuteTime = time % 100;
        return "${returnNumberFormatted(hourTime)}:${returnNumberFormatted(minuteTime)} am";
      }
    }
  }

  String returnNumberFormatted(int time) {
    if (time < 10) {return "0$time";}
    else {return "$time";}
  }

  String getActivatedDays() {
    String returnString = "";
    if(widget.mon){returnString += "Mon ";}
    if(widget.tue){returnString += "Tue ";}
    if(widget.wed){returnString += "Wed ";}
    if(widget.thu){returnString += "Thu ";}
    if(widget.fri){returnString += "Fri ";}
    if(widget.sat){returnString += "Sat ";}
    if(widget.sun){returnString += "Sun ";}

    return returnString;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlarmSettings(
              userId: widget.userId,
              alarmId: widget.alarmId,
              order: widget.order,
              isEnabled: widget.isEnabled,
              hour: widget.hour,
              minute: widget.minute,
              mon: widget.mon,
              tue: widget.tue,
              wed: widget.wed,
              thu: widget.thu,
              fri: widget.fri,
              sat: widget.sat,
              sun: widget.sun,
              useAge: widget.useAge,
              sleepCycle: widget.sleepCycle,
              targetSleepHours: widget.targetSleepHours,
              targetSleepMinutes: widget.targetSleepMinutes,
              isReminderEnabled: widget.isReminderEnabled,
              minutesToSleep: widget.minutesToSleep,
              isSnoozeEnabled: widget.isSnoozeEnabled,
              snoozeInterval: widget.snoozeInterval,
              is24Hour: widget.is24Hour,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 130,
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black38, width: 2.0),
            borderRadius: BorderRadius.circular(14.0),
            color: isSwitched ? Color(0xFF123456): Colors.white10,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),

          child: Row(
            children: [
              Container(
                width: 280,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getFormattedTime(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 60,
                        color: isSwitched ? Color(0xFFC6C0C0): Colors.white30,
                      ),
                    ),
                    Text(
                      getActivatedDays(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: isSwitched ? Colors.white30: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 95,
                child: Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(widget.userId)
                        .collection("timers")
                        .doc(widget.alarmId.toString())
                        .update({"isEnabled": value});
                  },
                  activeColor: Colors.white, // Color of the switch handle when on
                  activeTrackColor: Colors.blueGrey, // Background color when switch is on
                  inactiveTrackColor: Colors.white10, // Background color when switch is off
                  inactiveThumbColor: Colors.black87, // Color of the switch handle when off
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}