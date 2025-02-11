import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 80,),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/pfp.jpg'),
                    radius: 50,
                  ),
                  Positioned(
                    top: 80,
                    left: 80,
                    child: Icon(Icons.edit, color: Colors.black,))
                ],
              ),

            )
          ],
        ),
      ),
    );
  }
}