import 'package:flutter/material.dart';
import 'package:night_owl/home_screen.dart';

class GreetingPage extends StatefulWidget {
  const GreetingPage({super.key});

  @override
  State<GreetingPage> createState() => _State();
}

class _State extends State<GreetingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: [
            const Text(
              "Night Owl",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.bold,
                fontSize: 75,
                color: Colors.black,
              ),
            ),
            Image.asset(
              "assets/NightOwlLogo.png",
              width: 300,
              height: 300,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(minimumSize: const Size(300,100)),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context){
                          return HomeScreen();
                        })
                );
              },
              child: Text(
                "Guest".toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 30),
            OutlinedButton(
              style: OutlinedButton.styleFrom(minimumSize: const Size(300,100)),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context){
                          return HomeScreen();
                        })
                );
              },
              child: Text(
                "Login".toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
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
