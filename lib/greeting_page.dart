import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:night_owl/home_screen.dart';
import 'package:night_owl/login.dart';
import 'package:night_owl/register.dart';

class GreetingPage extends StatefulWidget {
  const GreetingPage({super.key});

  @override
  State<GreetingPage> createState() => _State();
}

class _State extends State<GreetingPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAndroidScheduleExactAlarmPermission();
  }

  Future<void> checkAndroidScheduleExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.status;
    print('Schedule exact alarm permission: $status.');
    if (status.isDenied) {
      print('Requesting schedule exact alarm permission...');
      final res = await Permission.scheduleExactAlarm.request();
      print('Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black87,
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: [
              SizedBox(height: 10),
              const Text(
                "Night Owl",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold,
                  fontSize: 65,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 10),
              Image.asset(
                "assets/NightOwlLogo.png",
                width: 300,
                height: 300,
              ),
              SizedBox(height: 60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300,100),
                  backgroundColor: Color(0xFF123456),
                  elevation: 20, // Shadow elevation
                ),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context){
                            return HomeScreen(isFirstLogin: false,);
                            //return LoginScreen();
                          })
                  );
                },
                child: Text(
                  "Enter".toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              // SizedBox(height: 30),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     minimumSize: const Size(300,100),
              //     backgroundColor: Color(0xFF123456),
              //     elevation: 20, // Shadow elevation
              //   ),
              //   onPressed: (){
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context){
              //               return RegisterScreen();
              //             })
              //     );
              //   },
              //   child: Text(
              //     "Register".toUpperCase(),
              //     style: const TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 30,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
        )
      ),
    );
  }
}
