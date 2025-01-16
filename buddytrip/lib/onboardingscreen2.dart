import 'package:flutter/material.dart';

class Onboardingscreen2 extends StatelessWidget {
  const Onboardingscreen2({super.key});

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
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Screen 2',
                  style: TextStyle(
                    fontFamily: 'IrishGrover',
                    fontSize: 26,
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
                  ),
                  SizedBox(height: 18,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 80,
                      height: 40,
                      child: FloatingActionButton(
                      onPressed: null, 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10,),
                          Text('Next',
                          style: TextStyle(
                          fontFamily: 'IrishGrover',
                          fontSize: 15,
                          color: Colors.white),
                          ),
                          SizedBox(width: 10,),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                        ],
                      ),
                    backgroundColor: Color(0xFF8F8989),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    
                    
                    ),
                    )
                    
                    
                  ),
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
