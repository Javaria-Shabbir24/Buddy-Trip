import 'dart:async';
import 'package:flutter/material.dart';
import 'onboardingscreen1.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const duration = Duration(seconds: 5);
    Timer(duration, navigateToNextPage);
  }

  void navigateToNextPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Onboardingscreen1()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 131, 127, 124),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 150, left: 50, right: 50, bottom: 10),
            child: Image.asset('assets/logo.jpg'),
          ),
          const Padding(
            padding: EdgeInsets.all(40),
            child: Text(
              'The friend who knows the way',
              style: TextStyle(
                fontFamily: 'IrishGrover',
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const CircularProgressIndicator(color: Color.fromARGB(255, 49, 48, 41),),
        ],
      ),
    );
  }
}
