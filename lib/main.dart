import 'package:flutter/material.dart';
import 'package:night_owl/greeting_page.dart';

void main() => runApp(MyApp());

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
