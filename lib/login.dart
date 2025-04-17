import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:night_owl/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "", password = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();


  userLogin() async {
    if (emailController.text != "") {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(isFirstLogin: false,)));
      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email' || e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Color(0xFF123456),
                content: Center(
                  child: Text(
                    "Email or Password is Incorrect",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              )
          );
        }
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
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
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.black87,
        ),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height: 30,),
              const Text(
                "Welcome!\nRegister Here",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white54,
                ),
              ),
              SizedBox(height: 40,),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Email";
                  }
                  return null;
                },
                controller: emailController,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.account_box, color: Colors.white54),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    labelStyle: const TextStyle(color: Colors.white54)),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20.0),

              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Password";
                  }
                  return null;
                },
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(
                        Icons.verified_user_outlined, color: Colors.white54),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    labelStyle: const TextStyle(color: Colors.white54)),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40.0),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(200, 50)),
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      email = emailController.text;
                      password = passwordController.text;
                    });
                  }
                  userLogin();
                },
                child: Text(
                  "Submit".toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
