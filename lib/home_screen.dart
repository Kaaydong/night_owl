import 'package:flutter/material.dart';
import 'package:night_owl/alarm_settings.dart';
import 'package:night_owl/user_settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                                  return UserSettings();
                                })
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      color: Color(0xFFC6C0C0),
                      onPressed: () {
                        // do something
                      },
                    ),
                  ],
                ),
              ),
              TimerItem(
                timeValue: 800,
                is24Hour: false,
                mon: true,
                tue: true,
                wed: true,
                thu: true,
                fri: true,
                sat: false,
                sun: false,
                active: true,
              ),
              TimerItem(
                timeValue: 1045,
                is24Hour: false,
                mon: true,
                tue: true,
                wed: true,
                thu: true,
                fri: true,
                sat: true,
                sun: true,
                active: false,
              ),
            ],
          ),
        )
    );
  }
}



// Child Stateful Widget
class TimerItem extends StatefulWidget {
  final int timeValue;
  final bool is24Hour;
  final bool mon;
  final bool tue;
  final bool wed;
  final bool thu;
  final bool fri;
  final bool sat;
  final bool sun;
  final bool active;

  const TimerItem({
    super.key,
    required this.timeValue,
    required this.is24Hour,
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    required this.sat,
    required this.sun,
    required this.active,
  });

  @override
  State<TimerItem> createState() => _TimerItemState();
}

class _TimerItemState extends State<TimerItem> {
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.active; // Set the initial switch state
  }

  String getFormattedTime() {
    int time = widget.timeValue;
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
                builder: (context){
                  return AlarmSettings();
                })
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