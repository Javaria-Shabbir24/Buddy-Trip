import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
Map<String, bool> isExpanded={};
//function to send email
Future <void> launchEmail() async{
  final Uri emailUri =Uri.parse('mailto:javariashabbir2431@gmail.com?subject=Buddy Trip Support Request&body=Hello Buddy Trip Support,\n\nI need assistance with...');
  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    throw 'Could not launch ';
  }
}

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
              //fontFamily: 'IrishGrover',
              fontSize: 26,
              color: Color(0xFF3C3B3E),
            ),

            ),),
            SizedBox(height: 10,),
            Center(child:
            Container(
              height: 170,
              width: 400,
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
                        style: TextStyle(//fontFamily: 'IrishGrover',
                        fontSize: 20,
                        color: Color(0xFF3C3B3E),))
                    ],
                  ),
                  Divider(color:Color(0xFF3C3B3E),),
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
                      SizedBox(height: 20,),
                      //question1
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color:const Color(0xFF8F8989),),
                          color: Color(0xFFD9D9D9),
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
                        decoration: BoxDecoration(border: Border.all(color:const Color(0xFF8F8989),),
                          color: Color(0xFFD9D9D9),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            createFAQ('How do I explore different destinations?', 'You can browse through various countries in the app, view travel details, and select a destination that interests you.')
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  //Trip Booking section
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Trip Booking', style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 16),)
                        ],
                      ),
                      SizedBox(height: 20,),
                      //question1
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(border: Border.all(color:const Color(0xFF8F8989),),
                          color: Color(0xFFD9D9D9),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            createFAQ('How can I book a trip?', 'You can book a trip by selecting your desired destination, choosing a suitable hotel, and confirming your travel details.')
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      //question2
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(border: Border.all(color:const Color(0xFF8F8989),),
                          color: Color(0xFFD9D9D9),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            createFAQ('Can I cancel my trip?', 'Yes, you can cancel your trip via sending an email. However, cancellation policies may vary depending on the hotel and booking terms.')
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  //Hotel Booking section
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Hotel Booking', style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 16),)
                        ],
                      ),
                      SizedBox(height: 20,),
                      //question1
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(border: Border.all(color:const Color(0xFF8F8989),),
                          color: Color(0xFFD9D9D9),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            createFAQ('How do I book a hotel?', 'When booking a trip, you can choose from a list of available hotels in your selected destination and confirm your stay.')
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      //Budget Management section
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Budget Management', style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 16),)
                            ],
                          ),
                          SizedBox(height: 20,),
                          //question1
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(border: Border.all(color:const Color(0xFF8F8989),),
                          color: Color(0xFFD9D9D9),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                createFAQ('How does the budget feature work?', 'The budget feature allows you to set and track your travel expenses on a monthly basis, ensuring you stay within your financial limits.')
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          //question2
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(border: Border.all(color:const Color(0xFF8F8989),),
                          color: Color(0xFFD9D9D9),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                createFAQ('Can I update my allocated budget?', 'Yes, you can adjust your budget at any time from the budget management section.')
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      //Support & Assistance section
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Support & Assistance', style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 16),)
                            ],
                          ),
                          SizedBox(height: 20,),
                          //question1
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(border: Border.all(color:const Color(0xFF8F8989),),
                          color: Color(0xFFD9D9D9),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                createFAQ('How can I contact support for help?', 'You can send a message through the app\'s help section and you can send your queries via email, and our support team will assist you.')
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          //question2
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(border: Border.all(color:const Color(0xFF8F8989),),
                          color: Color(0xFFD9D9D9),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                createFAQ('Is there 24/7 customer support available?', 'Yes, our support team is available around the clock to assist you with any travel-related queries.')
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Share your queries via email',
                        style: TextStyle(//fontFamily: 'IrishGrover',
                        fontSize: 20,
                        color: Color(0xFF3C3B3E),))
                        ],
                      ),
                      Divider(color: Color(0xFF3C3B3E),),
                      SizedBox(height: 20,),
                      Row(children: [
                        Text("Have other questions or need assistance? 💬 \nWe're here to help! Simply share your queries\nand our team will get back to you promptly. ",softWrap: true,)
                      ],),
                      Row( mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      
                      Text('Contact us via email. 24/7 Availability! 📧',softWrap: true,),
                      //Icon(Icons.email_outlined, color:Color.fromARGB(255, 113, 110, 119),),
                      ]),
                      
                      SizedBox(height: 20,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8F8989),
                        ),
                        onPressed: launchEmail, child: Text('send email', style: TextStyle(color: Colors.white,)),),
                      SizedBox(height: 20,),
                    ],
                  ),


                ],
              ),
            )
            
          ],
        ),
      ),
    );
  }
}