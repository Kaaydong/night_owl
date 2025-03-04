import 'package:flutter/material.dart';
import 'package:night_owl/alarm_settings.dart';

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
          backgroundColor: Colors.blue,
        ),

        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                height: 40.0,
                color: Colors.blueGrey,
                child: ListView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.format_list_bulleted),
                      color: Colors.black,
                      onPressed: () {
                        // do something
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.black,
                      onPressed: () {
                        // do something
                      },
                    ),
                  ],
                ),
              ),
              BorderedContainer(),
              BorderedContainer(),
              BorderedContainer(),
            ],
          ),
        )
    );
  }
}


class BorderedContainer extends StatelessWidget {
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
      child: Container(
        height: 130,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38, width: 3.0),
          color: Colors.black54,
        ),
        child: Row(
          children: [
            Container(
              width: 280,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "8:30 am",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Mon Tue Wed Thu Fri Sat Sun",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 115,
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
      ),
    );
  }
}