import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      backgroundColor: Color.fromARGB(255, 131, 127, 124),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 150, left: 30, right: 30, bottom: 10),
            child: Image.asset('assets/logo.jpg'),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Text('The friend who knows the way ',
            style: 
            TextStyle(
              fontFamily: 'IrishGrover',
            ),),)

        ],
      ),
      ),
    );
  }
}
