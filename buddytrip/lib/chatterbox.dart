import 'package:buddytrip/chatterbox1.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Chatterbox extends StatefulWidget {
  const Chatterbox({super.key});

  @override
  _ChatterboxState createState() => _ChatterboxState();
}

class _ChatterboxState extends State<Chatterbox> {
  double _position = 0.0;

  void slideAndNavigate(BuildContext context) {
    double maxPosition = MediaQuery.of(context).size.width * 0.6; 

    if (_position >= maxPosition - 10) {
      setState(() {
        _position = maxPosition;
      });

      Future.delayed(Duration(milliseconds: 300), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Chatterbox1()),
        ).then((_) {
          setState(() {
            _position = 0; 
          });
        });
      });
    } else {
      setState(() {
        _position = 0; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxSlide = MediaQuery.of(context).size.width * 0.6; 

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Container(
              padding: EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Meet the',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Text(
                    'ChatterBox!',
                    style: TextStyle(
                      color: Color.fromARGB(255, 130, 92, 165),
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: Lottie.asset('assets/chatterbox.json'),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 60,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(255, 130, 92, 165),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            setState(() {
                              _position += details.primaryDelta!;
                              _position = _position.clamp(0, maxSlide); 
                            });
                          },
                          onHorizontalDragEnd: (details) {
                            slideAndNavigate(context);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            transform: Matrix4.translationValues(_position, 0, 0),
                            child: Container(
                              width: 50,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 199, 161, 189),
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Icon(Icons.arrow_forward_ios, color: Colors.white,),
                            ),
                          ),
                        ),
                        Spacer(), 
                        Text(
                          'Get Started',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward_ios, size: 15, color: Colors.white),
                        Icon(Icons.arrow_forward_ios, size: 15, color: Color.fromARGB(255, 207, 186, 186)),
                        Icon(Icons.arrow_forward_ios, size: 15, color: Color.fromARGB(255, 173, 158, 158)),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
