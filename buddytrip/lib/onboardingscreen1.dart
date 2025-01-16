import 'package:flutter/material.dart';

class Onboardingscreen1 extends StatelessWidget {
  const Onboardingscreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/home.jpg"),
          fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Welcome to BuddyTrip',
                  style: TextStyle(
                    fontFamily: 'IrishGrover',
                    fontSize: 26.2,
                  ),),
                  SizedBox(height: 18,),
                  Align(
                    alignment: Alignment.center,
                    child: Text('Your perfect travel companion,always by your side.',
                    style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                  ),
                  )
                  
                ],
              ),
            ),
            ),
          ],
        ),

      ),
    );
  }
}
