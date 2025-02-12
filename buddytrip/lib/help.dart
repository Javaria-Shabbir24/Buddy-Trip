import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
Map<String, bool> isExpanded={};
//function to return a question
Widget createFAQ(String question, String answer){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row( mainAxisAlignment: MainAxisAlignment.start,
      children: [
      SizedBox(width: 200,
      child: 
      Text(question, style: TextStyle(fontWeight: FontWeight.w500),),),
      SizedBox(width: 70,),
      GestureDetector(
        onTap: (){
          setState(() {
            isExpanded[question]=!(isExpanded[question]??false);
          });
        },
        child: Icon(
        isExpanded[question] ?? false ? Icons.expand_less : Icons.expand_more))]),
        if(isExpanded[question] ?? false)
          Container(
            width: double.infinity,
            child:Text(answer,
            softWrap: true,),
            
          )
    ],
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Divider(color: Colors.black,
            thickness: 1,),
            SizedBox(height: 10,),
            Padding(padding: EdgeInsets.all(12),child:
            Text('How can we help?',style: TextStyle(
              fontFamily: 'IrishGrover',
              fontSize: 26,
              color: Color.fromARGB(255, 81, 96, 129)
            ),

            ),),
            SizedBox(height: 10,),
            Center(child:
            Container(
              height: 200,
              width: 350,
              padding: EdgeInsets.all(10),
              child: Lottie.asset('assets/help.json'),
            ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('FAQs',
                        style: TextStyle(fontFamily: 'IrishGrover',fontSize: 20,
                        color: Color.fromARGB(255, 81, 96, 129)))
                    ],
                  ),
                  Divider(color: Colors.blue,),
                  SizedBox(height: 15,),
                  //general questions section
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('General Questions', style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 16),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      //question1
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          color: const Color.fromARGB(255, 207, 223, 233)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            createFAQ('What is BuddyTrip?', 'Buddy Trip is a travel planning app that allows users to explore different countries, book trips, reserve hotels, manage their travel budget, and get assistance when needed.')
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      //question2
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          color: const Color.fromARGB(255, 207, 223, 233)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            createFAQ('How do I explore different destinations?', 'You can browse through various countries in the app, view travel details, and select a destination that interests you.')
                          ],
                        ),
                      ),
                    ],
                  )

                ],
              ),
            )
            
          ],
        ),
      ),
    );
  }
}