import 'package:buddytrip/onboardingscreen4.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'home.dart';

class Onboardingscreen2 extends StatelessWidget {
  const Onboardingscreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/home.jpg"),
          fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Plan Your Journey',
                  style: TextStyle(
                    fontFamily: 'IrishGrover',
                    fontSize: 26,
                  ),),
                  SizedBox(height: 18,),
                  Align(
                    alignment: Alignment.center,
                    child: Text('Find destinations, create trips, and stay on track with ease.',
                    style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                  ),
                  ),
                  SizedBox(height: 80,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 80,
                      height: 40,
                      child: FloatingActionButton(
                      onPressed: (){
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context)=>Home()));

                      }, 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10,),
                          Text('Skip',
                          style: TextStyle(
                          fontFamily: 'IrishGrover',
                          fontSize: 15,
                          color: Color(0xFF8F8989)),
                          ),
                          SizedBox(width: 10,),
                          Icon(Icons.arrow_forward, color: Color(0xFF8F8989), size: 18),
                        ],
                      ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    ),
                    ),
                    ),
                    SizedBox(width: 70,),
                    Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 80,
                      height: 40,
                      child: FloatingActionButton(
                      onPressed: (){
                        Navigator.push(context, 
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: Onboardingscreen4(),
                          duration: Duration(milliseconds: 400),
                        

                        ));

                      },
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
                    ),
                    ),
                    ],
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
