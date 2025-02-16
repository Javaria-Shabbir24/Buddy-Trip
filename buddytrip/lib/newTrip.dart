import 'package:buddytrip/bottomnavigationbar.dart';
import 'package:buddytrip/hotelDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Newtrip extends StatefulWidget {
  const Newtrip({super.key});

  @override
  State<Newtrip> createState() => _NewtripState();
}

class _NewtripState extends State<Newtrip> {
  List<Map<String, dynamic>> hotels=[];
  int? startDateIndex=0;
  int? endDateIndex=0;
  String selectedPlace='London';
  List<String>places=['London','Turkey','Paris','Mecca','Thailand'];

  @override
  void initState() {
    Loadhotels();
    super.initState();
  }

  Future<void> Loadhotels()async{
    QuerySnapshot snapshot= await FirebaseFirestore.instance.collection('NewTrip').where('name',isEqualTo: selectedPlace).get();
    if(snapshot.docs.isNotEmpty){
      for(var doc in snapshot.docs){
        List<Map<String, dynamic>> tripDetails = List<Map<String, dynamic>>.from(doc['hotel']);
        setState(() {
          if(tripDetails.isNotEmpty){
             hotels=tripDetails;
          }
        });
      }
      
    }
  }

  final List<DateTime> dates=List.generate(30, (index)=>DateTime.now().add(Duration(days: index)));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
               Container(
                width: 400,
                padding: EdgeInsets.all(15),
                
                //select dates
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TRIP DATE SELECTION',
                    style: TextStyle(fontSize: 18,
              color: Color(0xFF3C3B3E),),),
                    SizedBox(height: 20,),
                    Container(
                      height: 50,
                      child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dates.length,
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: () => {
                            setState(() {
                              if(startDateIndex==null||(startDateIndex!=null&&endDateIndex!=null)){
                                startDateIndex=index;
                                endDateIndex=null;
                              }
                              else if(startDateIndex!=null&&endDateIndex==null){
                                if(index>startDateIndex!){
                                endDateIndex=index;
                              }
                                }
                              else{
                                startDateIndex=index;
                              }
                            })
                          },
                          child: Container(
                            width: 70,
                            decoration: BoxDecoration(
                              color: (startDateIndex != null &&
                                        endDateIndex != null &&
                                        index > startDateIndex! &&
                                        index < endDateIndex!)
                                    ? const Color.fromARGB(255, 235, 227, 227):
                              index==startDateIndex||index==endDateIndex ? const Color.fromARGB(255, 78, 236, 84) :Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat('dd').format(dates[index]),
                                ),
                                SizedBox(height: 4,),
                                Text(
                                  DateFormat('MMM').format(dates[index]),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('DESTINATION',
                          style: TextStyle(
                            fontSize: 18,
              color: Color(0xFF3C3B3E),
                          ),),
                          SizedBox(width: 50,),
                          DropdownButton(
                            value: selectedPlace,
                            hint: Text('select'),
                            items:places.map((String item){
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item));
                           }).toList(),
                           onChanged: (String? newvalue){
                           setState(() {
                            selectedPlace=newvalue ?? 'London';
                            updateDates(dates[startDateIndex!], dates[endDateIndex!], selectedPlace);
                            Loadhotels();
                          });},
                          )
                        ],

                      ),

                    ),
                    SizedBox(height: 20,),
                    Text('EXPLORE HOTELS',
                    style: TextStyle(
                      fontSize: 18,
              color: Color(0xFF3C3B3E),
                    ),),
                    SizedBox(height: 10,),
                    hotels.isNotEmpty
                    ? SizedBox(
                        height: 200, // Adjust the height based on hotel card size
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: hotels.length,
                          itemBuilder: (context, index) {
                            final hotelMap = hotels[index];
                            return Row(
                              children: hotelMap.entries.map((entry) {
                                return createHotelCard(context, entry.key, entry.value,selectedPlace);
                              }).toList(),
                            );
                          },
                        ),
                      )
                    : Center(child: Text("No hotels available")),
                    
 
                  ],
                ),
              ),
              
              
            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottomnavigationbar(),
    );
  }
}
//call function to update the dates in firebase
Future<void> updateDates(DateTime? startDate, DateTime? endDate, String? selectedPlace) async{
  try{
    await FirebaseFirestore.instance.collection('NewTrip').where('name',isEqualTo: selectedPlace).get().then(
      (querysnapshot){
        for(var doc in querysnapshot.docs){
          doc.reference.update({'startDate': startDate!,'endDate':endDate!});
        }
      }
    );
  }
  catch(e){
    print('error updating dates in firebase $e');
  }
}
// function to create hotel card
Widget createHotelCard(BuildContext context , String name, String imageUrl,String selectedPlace){
  return GestureDetector(
    onTap: ()
    {
      Navigator.push(context, 
      MaterialPageRoute(builder: (context)=>Hoteldetails(selectedPlace: selectedPlace,name:name, imageUrl:imageUrl)));
    },
    child: Padding(padding: EdgeInsets.all(10),
    child: Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.black,
        width: 1,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 120,
        width: 200,
        child: 
        Image.network(imageUrl,
        fit: BoxFit.cover,),),
        SizedBox(height: 3,),
        Text(name),
      ],

    ),
    ),
  ));
}