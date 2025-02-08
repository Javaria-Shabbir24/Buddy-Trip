import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Budgetandspendings extends StatefulWidget {
  const Budgetandspendings({super.key});

  @override
  State<Budgetandspendings> createState() => _BudgetandspendingsState();
}

class _BudgetandspendingsState extends State<Budgetandspendings> {
  double currentBalance=0;
  double remainingBalance=0;
  double monthlySpendings=0;
  double roomsExpenditure=0;
  double clothing=0;
  double miscellaneous=0;
  double transportation=0;
  DateTime date= DateTime.now();
  int monthNumber=0;
  String month='';
  int counter=0;
  @override
  void initState() {
    monthNumber=date.month;
    month=getMonthName(monthNumber);
    getRoomsExpense();
    super.initState();
  }
  //update the next current balance
   Future<void> updateCurrentNextBudget()async{
    try{
      int tempMonthNumber=monthNumber;
      double tempbalance=0;
      setState(() {
        tempMonthNumber++;
        tempbalance=currentBalance-monthlySpendings;
      });
      for (int x=tempMonthNumber;x<13;x++){
      await FirebaseFirestore.instance.collection('Budget').where('month',isEqualTo: getMonthName(x)).get().then(
        (querysnapshot){
          for(var doc in querysnapshot.docs){
            doc.reference.update({'currentBalance': tempbalance});
          }
        }
      );
      }

    }
    catch(e){
      print('error updating current balance $e');
    }
  }
  //Function to get rooms expense
  Future<void> getRoomsExpense()async{
    try{
      QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection('Budget').where('month',isEqualTo: month).get();
      if(querySnapshot.docs.isNotEmpty){
        for(var doc in querySnapshot.docs){
          setState(() {
              //get current balance
              currentBalance = (doc['currentBalance'] is int)
              ? (doc['currentBalance'] as int).toDouble()
              : doc['currentBalance'] as double;
              //get rooms expense
              roomsExpenditure = (doc['roomsExpenditure'] is int)
              ? (doc['roomsExpenditure'] as int).toDouble()
              : doc['roomsExpenditure'] as double;
              //get clothing expense
              clothing = (doc['clothing'] is int)
              ? (doc['clothing'] as int).toDouble()
              : doc['clothing'] as double;
              //get transportation expense
              transportation = (doc['transportation'] is int)
              ? (doc['transportation'] as int).toDouble()
              : doc['transportation'] as double;
              //get miscellaneous expense
              miscellaneous = (doc['miscellaneous'] is int)
              ? (doc['miscellaneous'] as int).toDouble()
              : doc['miscellaneous'] as double;
              //set monthly spendings
              monthlySpendings=clothing+roomsExpenditure+transportation+miscellaneous;
              //set remaining balance
              remainingBalance=currentBalance-monthlySpendings;
              //update counter
              counter++;
          });
          //update net Balance
          doc.reference.update({'netBalance':remainingBalance});
          
          if(counter==1){
            updateCurrentNextBudget();
          }
        }
      }
    }
    catch(e){
      print('error fetching the room expense $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF8F8989),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF8F8989),
              ),
              child: Container(
                width: 1000,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                border: Border.all(color: Colors.black),
                color: Colors.white

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 25,),
                  //budget row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //Current wallet cell
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.wallet),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Current Budget'),
                              Text('$currentBalance\$', style: TextStyle(fontWeight: FontWeight.bold,),),
                            ],
                          )
                        ],
                      ),
                      SizedBox(width: 20,),
                      //Monthly Expenditure cell
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.calendar_month),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Monthly Expenditure'),
                              Text('-$monthlySpendings\$', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                            ],
                          )
                        ],
                      ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //net balance
                            Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.wallet_outlined),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Net Balance'),
                                  Text('$remainingBalance\$', style: TextStyle(fontWeight: FontWeight.bold,),),
                                ],
                              )
                            ],
                       ),
                    ],
                  ),
                  
                  SizedBox(height: 20,),
                  Divider(
                    color: Colors.black,

                  ),
                  SizedBox(height: 20,),
                  //months row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 40,),
                      //back arrow
                      GestureDetector(
                        onTap: () => setState(() {
                          if(monthNumber>1){
                            setState(() {
                            monthNumber--;
                            month=getMonthName(monthNumber);
                            });
                            getRoomsExpense();
                          }
                        }),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      SizedBox(width: 50,),
                      Container(
                        width: 130,
                      child:Text('$month 2025'),),
                      SizedBox(width: 20,),
                      //forward arrow
                      GestureDetector(
                        onTap: () => setState(() {
                          if(monthNumber<12){
                            monthNumber++;
                            month=getMonthName(monthNumber);
                            getRoomsExpense();
                          }
                        }),
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  //Pie chart
                  Container(
                    height: 200,
                    decoration: BoxDecoration(color: Colors.black),
                  ),
                  Divider(color: Colors.grey,),
                  //budget sheet
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //hotel expenditure
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 20,),
                          Icon(Icons.hotel, color: Colors.blue,),
                          SizedBox(width: 20,),
                          Text('Hotel Bookings'),
                          SizedBox(width: 120,),
                          Text('$roomsExpenditure\$',),
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      //clothing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 20,),
                          Icon(Icons.shopping_cart, color: Colors.pink,),
                          SizedBox(width: 20,),
                          Text('Clothing'),
                          SizedBox(width: 164,),
                          Text('$clothing\$',),
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      //transportation
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 20,),
                          Icon(Icons.emoji_transportation, color: Colors.green,),
                          SizedBox(width: 20,),
                          Text('Transportation'),
                          SizedBox(width: 122,),
                          Text('$transportation\$',),
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      //miscellaneous
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 20,),
                          Icon(Icons.other_houses, color: Colors.brown,),
                          SizedBox(width: 20,),
                          Text('Miscellaneous'),
                          SizedBox(width: 124,),
                          Text('$miscellaneous\$',),
                        ],
                      ),
                      Divider(color: Colors.grey,),
                    ],
                  )
                ],
              )
            )
            )
            


          ],
        ),
      ),
    );
  }
}
String getMonthName(int monthNumber){
  switch(monthNumber){
    case 1:
    return 'January';
    case 2:
    return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return 'Invalid Month';
  }
}