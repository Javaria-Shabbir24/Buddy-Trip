import 'package:buddytrip/bottomnavigationbar.dart';
import 'package:buddytrip/budgetAndSpendings.dart';
import 'package:buddytrip/chatterbox.dart';
import 'package:buddytrip/menu.dart';
import 'package:buddytrip/newTrip.dart';
import 'package:buddytrip/placesDetails.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final searchbarController=TextEditingController();

  @override
  void dispose(){
    searchbarController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      endDrawer: Menu(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            Padding(padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 3,color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: AssetImage('assets/home.jpg'),
                    fit: BoxFit.cover),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sync your plans, budgets and dreams',
                      style: TextStyle(fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: searchbarController,
                            decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(width: 3),
                          ),
                          hintText: 'where do you want to go?  ',
                          hintStyle: TextStyle(color:Colors.grey),
                          prefixIcon: Icon(Icons.search, color: Color(0xFF3C3B3E),),
                          
                        ),
                        onFieldSubmitted: (value) => {
                          if(value.isNotEmpty){
                            Navigator.push(context, 
                            MaterialPageRoute(builder: (context)=>Placesdetails(name1: value, path: ''))),
                            searchbarController.clear(),
                          }
                        },
                      ),
                      ),],
                      ),
                      SizedBox(height: 20,),
                    
                    ],
                  ),
                  
            
                ),

              ],
            ),),
            SizedBox(height: 20,),
            Padding(padding: EdgeInsets.only(left: 20,right: 20,bottom: 10),
            child: 
            Text('Mostly Visited Places',
            style: TextStyle(
              //fontFamily: 'IrishGrover',
              fontSize: 22,
              color: Colors.black
            ),),
            
            ),
            SizedBox(height: 20,),
            SizedBox( height: 180,
            child: PageView(
              children: [
                Padding(padding: EdgeInsets.only(left: 40,right: 40),
                child: createPlaceCard(context,'London', 'assets/London.jpg'),),
                Padding(padding: EdgeInsets.only(left: 40,right: 40),
                child: createPlaceCard(context,'Paris', 'assets/paris.jpg'),),
                Padding(padding: EdgeInsets.only(left: 40,right: 40),
                child: createPlaceCard(context,'Turkey', 'assets/turkey.jpg'),),
                Padding(padding: EdgeInsets.only(left: 40,right: 40),
                child: createPlaceCard(context,'Mecca', 'assets/makkah.jpg'),),
                Padding(padding: EdgeInsets.only(left: 40,right: 40),
                child: createPlaceCard(context,'Thailand', 'assets/thailand.jpg'),),
              ],
            ),),
            Padding(
            padding: EdgeInsets.only(top: 40, left: 20,right: 20,bottom: 20),
            child: Container(
              /*padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 223, 218, 228),
              ),*/
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text('Dream Trips Within Your Budget!',
                  style: TextStyle(
                    //fontFamily: 'IrishGrover',
                    fontSize: 22,
                    color: Colors.black
                  ),),
                  SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    
                    Container(
                      width: 150,
                      height: 110,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 2),
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFD9D9D9),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              
                          Text('Plan a New \nTrip',
                          style: TextStyle(
                            //fontFamily: 'IrishGrover',
                            color: Color(0xFF3C3B3E),
                            fontSize: 15,
                          ),
                          ),
                          SizedBox(width: 10,),
                          Icon(Icons.travel_explore, color: Color(0xFF3C3B3E),)]),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Explore and Start\na new trip',
                            style: TextStyle(
                              color: Color(0xFF3C3B3E),
                            fontSize: 10
                          ), 
                          softWrap: true,),
                          SizedBox(width: 12,),
                          GestureDetector(
                            onTap: () => {
                              Navigator.push(context, 
                              MaterialPageRoute(builder: (context)=>Newtrip()))
                            },
                            child: Icon(Icons.arrow_forward,   size: 20,color: Color(0xFF3C3B3E),),
                          ),
                          
                            ],
                          ),

                          
                        ],
                      ),
                      
                    ),
                    SizedBox(width: 10,),
                    Container(
                      width: 150,
                      height: 110,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 2),
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFD9D9D9),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                          Text('Budget and\nSpendings',
                          style: TextStyle(
                           // fontFamily: 'IrishGrover',
                           color: Color(0xFF3C3B3E),
                            fontSize: 15
                          ),
                          ),
                          SizedBox(width: 16,),
                          Icon(Icons.account_balance,color:Color(0xFF3C3B3E),)]),
                          
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Handle your budget\nat ease',
                            style: TextStyle(
                              color: Color(0xFF3C3B3E),
                            fontSize: 10
                          ),),
                          SizedBox(width: 10,),
                          GestureDetector(
                            onTap: () => {
                              Navigator.push(context, 
                              MaterialPageRoute(builder: (context)=>Budgetandspendings()))
                            },
                            child: Icon(Icons.arrow_forward,size: 20,color: Color(0xFF3C3B3E),),
                          ),
                            ],
                          )
                          
                        ],
                      ),
                      
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                //next features
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    
                    Container(
                      width: 150,
                      height: 110,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 2),
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFD9D9D9),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              
                          Text('Get Relevant\nGuidance',
                          style: TextStyle(
                            //fontFamily: 'IrishGrover',
                            color: Color(0xFF3C3B3E),
                            fontSize: 15
                          ),
                          
                          ),
                          SizedBox(width: 10,),
                          Icon(Icons.smart_toy,color: Color(0xFF3C3B3E),)]),
                          
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Chat and Explore\nwith ChatterBox',
                            style: TextStyle(
                              color: Color(0xFF3C3B3E),
                            fontSize: 10
                          ), 
                          softWrap: true,),
                          SizedBox(width: 16,),
                          GestureDetector(
                            onTap: () => {
                              Navigator.push(context, 
                              MaterialPageRoute(builder: (context)=>Chatterbox()))
                            },
                            child: Icon(Icons.arrow_forward,size: 20,color: Color(0xFF3C3B3E),),
                          ),
                          
                            ],
                          ),

                          
                        ],
                      ),
                      
                    ),
                    SizedBox(width: 10,),
                    
                   
                  ],
                )
                  ],),),
            ),
            SizedBox(height: 20,),
            
          ],
        ),

      ),
      bottomNavigationBar: Bottomnavigationbar(),

    );
  }
}

Widget createPlaceCard(BuildContext context, String name, String path){
  return GestureDetector(
    onTap: () => {
      Navigator.push(context, 
      MaterialPageRoute(builder: (context)=>Placesdetails(name1: name, path: path)))
    },
    child: Container(
  
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF8F8989),width: 5),
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(image: AssetImage(path),
      fit: BoxFit.cover),
    ),
    child: Stack(
      children: [
        Positioned(
          bottom:1,
          right: 2,
          child: Container(
            
            padding: EdgeInsets.all(5),
            decoration: 
            BoxDecoration(
              color:  Colors.white,
              border: Border.all(color:  Colors.black,width: 3),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Text(name,
        style: TextStyle(color: const Color.fromARGB(255, 116, 105, 105),
        fontSize: 15,
        //fontFamily: 'IrishGrover'
        ),),
          ),
          
        ),
      ],
    ),
  ));
}