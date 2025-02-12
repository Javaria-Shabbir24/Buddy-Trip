import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.black,
            thickness: 1,),
            SizedBox(height: 10,),
            Padding(padding: EdgeInsets.all(12),child:
            Text('How can we help?',style: TextStyle(
              fontFamily: 'IrishGrover',
              fontSize: 24,
              color: Color(0xFF8F8989)
            ),

            ),),
            SizedBox(height: 10,),
          ],
          
        ),
      ),
    );
  }
}