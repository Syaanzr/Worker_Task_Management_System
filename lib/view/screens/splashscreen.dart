import 'package:flutter/material.dart';
import 'dart:async';
import 'loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 8), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen())); //call login class
    });
  }

 @override
Widget build(BuildContext context) {
  return const Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "\t\t\t\t WORKER TASK\n "
            " \t\tMANAGEMENT SYSTEM", 
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 197, 41, 197),
            ),
          ),
          SizedBox(height: 20),
          CircularProgressIndicator(
            backgroundColor: Color.fromARGB(255, 76, 145, 194),
            valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 160, 65, 184)),
          ),
        ],
      ),
    ),
  );
}

}
