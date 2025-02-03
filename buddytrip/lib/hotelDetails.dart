import 'package:buddytrip/bottomnavigationbar.dart';
import 'package:flutter/material.dart';

class Hoteldetails extends StatefulWidget {
  final String name;
  final String imageUrl;
  const Hoteldetails({super.key, required this.name, required this.imageUrl});

  @override
  State<Hoteldetails> createState() => _HoteldetailsState();
}

class _HoteldetailsState extends State<Hoteldetails> {
  int deluxeCounter=0;
  int standardCounter=0;
  int suiteCounter=0;
  double deluxeRoomPrice=150;
  int deluxeRoomQuantity=0;
  double standardRoomPrice=80;
  int standardRoomQuantity=0;
  double suiteRoomPrice=300;
  int suiteRoomQuantity=0;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Deluxe Room ', style: TextStyle(
                      fontSize: 15
                    ), ),
                    Text('\($deluxeRoomPrice \$\)',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(width: 15,),
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
                                deluxeCounter--;}
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
                              });
                              
                            },
                            child: Icon(Icons.add,size: 15,),),),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),),),
          ],
        ),
      ),
      bottomNavigationBar: Bottomnavigationbar(),
    );
  }
}