import 'package:buddytrip/signup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/home.jpg"),
          fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
              padding:const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Let’s Get Started !',
                  style: TextStyle(
                    fontFamily: 'IrishGrover',
                    fontSize: 26,
                  ),),
                  const SizedBox(height: 18,),
                  const Align(
                    alignment: Alignment.center,
                    child: Text('From Plans to Memories, We’ve Got You.',
                    style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                  ),
                  ),
                  const SizedBox(height: 18,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 100,
                      height: 40,
                      child: FloatingActionButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10,),
                          Text('Sign Up',
                          style: TextStyle(
                          fontFamily: 'IrishGrover',
                          fontSize: 15,
                          color: Colors.white),
                          ),
                          SizedBox(width: 10,),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                        ],
                      ),
                    backgroundColor: const Color(0xFF8F8989),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    ),
                    ),
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
