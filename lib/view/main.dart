import 'package:flutter/material.dart';
import 'package:worker_task2/view/screens/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Worker Task Management System',
      theme: ThemeData(),
      home: const SplashScreen(),
    );
  }
}