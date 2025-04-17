import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:night_owl/greeting_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Night Owl',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.white54,
          selectionColor: Colors.white54,
          selectionHandleColor: Colors.white54,
        ),
      ),
      home: const GreetingPage(),
    );
  }
}
