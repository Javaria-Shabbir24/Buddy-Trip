import 'package:buddytrip/bottomnavigationbar.dart';
import 'package:buddytrip/roomReservation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Hoteldetails extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String? selectedPlace;
  const Hoteldetails({super.key, required this.name, required this.imageUrl, required this.selectedPlace});

  @override
  State<Hoteldetails> createState() => _HoteldetailsState();
}

class _HoteldetailsState extends State<Hoteldetails> {
  int deluxeCounter=0;
  int standardCounter=0;
  int suiteCounter=0;
  double deluxeRoomPrice=150;
  double standardRoomPrice=80;
  double suiteRoomPrice=300;
  double priceStandard=0;
  double pricedeluxe=0;
  double pricesuite=0;
  double total=0;
  DateTime date=DateTime.now();
  int monthnumber= 1;
  //Function to get total
  double getTotal(){
    return total;
  }
  //function to calculate expenditure
  double calculateExpenditure(){
    return (deluxeCounter*deluxeRoomPrice)+(standardCounter*standardRoomPrice)+(suiteCounter*suiteRoomPrice);
    
  }
  //function to update the rooms expense in budget collection
  Future<void> updateBudget()async{
    try{
      setState(() {
        monthnumber=date.month;//the value of month
      });
      await FirebaseFirestore.instance.collection('Budget').where('month',isEqualTo: getMonthName(monthnumber)).get().then(
        (querysnapshot){
          for(var doc in querysnapshot.docs){
            doc.reference.update({'roomsExpenditure': total});
          }
        }
      );

    }
    catch(e){
      print('Error updating the rooms expense in budget collection $e');
    }
  }
  //function to book rooms
  Future<void> bookRooms()async{
     try{
       await FirebaseFirestore.instance.collection('NewTrip').where('name',isEqualTo: widget.selectedPlace!).get().then(
         (querysnapshot){
          for(var doc in querysnapshot.docs){
            doc.reference.update({'rooms': 
            [
              {
                'deluxe': deluxeCounter,
              },
              {
                'standard': standardCounter
              },
              {
                'suite': suiteCounter
              }
            ],
            'roomsExpenditure':calculateExpenditure(),
             
            });
          }
         }
       );

     }catch(e){
      print('error booking the rooms $e');
     }
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
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Padding(padding: EdgeInsets.all(20),
            child: Container(padding: EdgeInsets.all(10), child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                child: Text(
                  widget.name, style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),),
                SizedBox(height: 5,),
                Container(height: 200
                ,width: 500,child: 
                Image.network(widget.imageUrl)),
                SizedBox(height: 5,),
                Text('ROOMS BOOKING',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),),
                SizedBox(height: 10,),
                //standard room
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Standard Room ', style: TextStyle(
                      fontSize: 15
                    ), ),
                    Text('\($standardRoomPrice \$\)',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    Text('quantity: ', style: TextStyle(
                      fontSize: 13
                    ), ),
                    Container(
                      width: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 5,),
                          SizedBox(height: 20,
                          width: 20,child: GestureDetector(
                            onTap: ()  {
                              setState(() {
                                if(standardCounter>0){
                                standardCounter--;
                                priceStandard=standardRoomPrice*standardCounter;
                                total=calculateExpenditure();}
                              });
                              
                            },
                            child: Icon(Icons.remove,size: 15,),),
                          ),
                          
                          SizedBox(width: 5,),
                          Text('$standardCounter'),
                          SizedBox(width: 5,),
                          SizedBox(height: 20,
                          width: 20,child: GestureDetector(
                            onTap: ()  {
                              setState(() {
                                standardCounter++;
                                priceStandard=standardRoomPrice*standardCounter;
                                total=calculateExpenditure();
                              });
                              
                            },
                            child: Icon(Icons.add,size: 15,),),),
                        ],
                      ),
                      
                    )
                  ],
                ),
                SizedBox(height: 15,),
                //deluxe room
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Deluxe Room ', style: TextStyle(
                      fontSize: 15
                    ), ),
                    Text('\($deluxeRoomPrice \$\)',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(width: 12.5,),
                    Text('quantity: ', style: TextStyle(
                      fontSize: 13
                    ), ),
                    Container(
                      width: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 5,),
                          SizedBox(height: 20,
                          width: 20,child: GestureDetector(
                            onTap: ()  {
                              setState(() {
                                if(deluxeCounter>0){
                                deluxeCounter--;
                                pricedeluxe=deluxeRoomPrice*deluxeCounter;
                                total=calculateExpenditure();}
                              });
                              
                            },
                            child: Icon(Icons.remove,size: 15,),),
                          ),
                          
                          SizedBox(width: 5,),
                          Text('$deluxeCounter'),
                          SizedBox(width: 5,),
                          SizedBox(height: 20,
                          width: 20,child: GestureDetector(
                            onTap: ()  {
                              setState(() {
                                deluxeCounter++;
                                pricedeluxe=deluxeRoomPrice*deluxeCounter;
                                total=calculateExpenditure();
                              });
                              
                            },
                            child: Icon(Icons.add,size: 15,),),),
                        ],
                      ),
                      
                    )
                  ],
                ),
                SizedBox(height: 15,),
                //suite room 
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Suite Room ', style: TextStyle(
                      fontSize: 15
                    ), ),
                    Text('\($suiteRoomPrice \$\)',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(width: 24,),
                    Text('quantity: ', style: TextStyle(
                      fontSize: 13
                    ), ),
                    Container(
                      width: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 5,),
                          SizedBox(height: 20,
                          width: 20,child: GestureDetector(
                            onTap: ()  {
                              setState(() {
                                if(suiteCounter>0){
                                suiteCounter--;
                                pricesuite=suiteRoomPrice*suiteCounter;
                                total=calculateExpenditure();}
                              });
                              
                            },
                            child: Icon(Icons.remove,size: 15,),),
                          ),
                          
                          SizedBox(width: 5,),
                          Text('$suiteCounter'),
                          SizedBox(width: 5,),
                          SizedBox(height: 20,
                          width: 20,child: GestureDetector(
                            onTap: ()  {
                              setState(() {
                                suiteCounter++;
                                pricesuite=suiteRoomPrice*suiteCounter;
                                total=calculateExpenditure();
                              });
                              
                            },
                            child: Icon(Icons.add,size: 15,),),),
                        ],
                      ),
                      
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Center(child: 
                SizedBox(width: 100,height: 50, child: 
                FloatingActionButton(onPressed:(){
                  showDialog(context: context, builder: (BuildContext context){
                    return Dialog(
                      
                      child: Container(
                        height: 320,
                        width: 40,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 2),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            
                            Text('Are you sure you want \n  to book the rooms?',
                            style: TextStyle(fontSize: 20,
                            ),),
                            SizedBox(height: 20,),
                            Text('$standardCounter Standard Rooms Booked \($priceStandard\$)'),
                            SizedBox(height: 10,),
                            Text('$deluxeCounter Deluxe Rooms Booked \($pricedeluxe\$)'),
                            SizedBox(height: 10,),
                            Text('$suiteCounter Suite Rooms Booked \($pricesuite\$)'),
                            SizedBox(height: 10,),
                            Text('Total price \($total\$) '),
                            SizedBox(height: 25,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 20,),
                                ElevatedButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: Text('No'),), 
                                SizedBox(width: 50,),
                                ElevatedButton(onPressed: (){
                                  bookRooms();
                                  updateBudget();
                                  
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Roomreservation()));
                                }, child: Text('Yes'),), 
                              ],
                            )

                          ],

                        ),
                      ),

                    );
                  });
                },
                 
                child: Text('Book Rooms'))))
              ],
              
            ),),),
          ],
        ),
      ),
      bottomNavigationBar: Bottomnavigationbar(),
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