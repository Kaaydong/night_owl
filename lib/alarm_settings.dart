import 'package:flutter/material.dart';

class AlarmSettings extends StatefulWidget {
  const AlarmSettings({super.key});

  @override
  State<AlarmSettings> createState() => _AlarmSettingsState();
}

class _AlarmSettingsState extends State<AlarmSettings> {
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
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38, width: 3.0),
                borderRadius: BorderRadius.circular(12.0),
                //color: Colors.black54,
              ),
              child: Text(
                "8:30 am",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 80,
                  color: Colors.blue,
                ),
              )
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(minimumSize: const Size(30,50)),
                  onPressed: (){
                  },
                  child: Text(
                    "Mon".toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(minimumSize: const Size(30,50)),
                  onPressed: (){
                  },
                  child: Text(
                    "Tue".toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(minimumSize: const Size(30,50)),
                  onPressed: (){
                  },
                  child: Text(
                    "Wed".toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(minimumSize: const Size(30,50)),
                  onPressed: (){
                  },
                  child: Text(
                    "Thr".toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(minimumSize: const Size(30,50)),
                  onPressed: (){
                  },
                  child: Text(
                    "Fri".toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(minimumSize: const Size(150,50)),
                  onPressed: (){
                  },
                  child: Text(
                    "Sat".toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(minimumSize: const Size(150,50)),
                  onPressed: (){
                  },
                  child: Text(
                    "Sun".toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                        //color: Colors.black54,
                      ),
                      child: Text(
                        "Sleep Cycle Duration",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(minimumSize: const Size(150,35)),
                      onPressed: (){
                      },
                      child: Text(
                        "Use Average".toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 160,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                        //color: Colors.black54,
                      ),
                      child: Text(
                        "Early Alert",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Switch(
                      // This bool value toggles the switch.
                      value: false,
                      activeColor: Colors.red,
                      onChanged: (bool value) {
                        //
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 90,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 2.0),
                    borderRadius: BorderRadius.circular(12.0),
                    //color: Colors.black54,
                  ),
                  child: Text(
                    "Target Sleep",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(width: 160),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 90,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 2.0),
                    borderRadius: BorderRadius.circular(12.0),
                    //color: Colors.black54,
                  ),
                  child: Text(
                    "Snooze Duration",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 160,
                  child: Switch(
                    // This bool value toggles the switch.
                    value: false,
                    activeColor: Colors.red,
                    onChanged: (bool value) {
                      //
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            OutlinedButton(
              style: OutlinedButton.styleFrom(minimumSize: const Size(150,35)),
              onPressed: (){
              },
              child: Text(
                "Save".toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
