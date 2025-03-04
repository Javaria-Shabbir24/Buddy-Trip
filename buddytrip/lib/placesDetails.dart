import 'dart:async';

import 'package:buddytrip/bottomnavigationbar.dart';
import 'package:buddytrip/placeDescriptionPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';// for decoding the json response
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Placesdetails extends StatefulWidget {
  final String name1;
  final String path;
  const Placesdetails({super.key, required this.name1, required this.path});

  @override
  State<Placesdetails> createState() => _PlacesdetailsState();
}

class _PlacesdetailsState extends State<Placesdetails> {
  List<String> imageUrls=[];
  int currentIndex=0;
  Timer? _timer;
  late String name;
  late String path;
  String description='Loading description...';
  String weatherdescription="Loading...";
  String mainTemperature="";
  String visibility="";
  String windSpeed="";
  String windDirection="";
  String sunrise="";
  String sunset="";
  String iconUrl='';
  @override
  void initState(){
    super.initState();
    name=widget.name1;
    path=widget.path;
    //call method for city description 
    fetchDescription(name);
    //call method for weather details
    getWeatherDetails(name);
    //call method for popular spots
    fetchPopularSpots(name);
  }
  //method for auto scroll
  void autoScroll(){
    if(imageUrls.isEmpty){
        _timer?.cancel();
      return;
    }
    _timer=Timer.periodic(Duration(seconds: 3), (timer){
      setState(() {
        currentIndex=(currentIndex+1)%imageUrls.length;
        print(imageUrls[currentIndex]);
      });
    });
  }
  //method to fetch popular spots
  Future<void> fetchPopularSpots(String cityName)async{
    try{
      QuerySnapshot snapshot=await FirebaseFirestore.instance.collection('Places').where('Name',isEqualTo: cityName).get();
      List<String> urls=[];
      for(var document in snapshot.docs){
        Map<String,dynamic> data=document.data() as Map<String,dynamic>;
        urls.add(data['Place1']);
        urls.add(data['Place2']);
        urls.add(data['Place3']);
      }
      setState(() {
        imageUrls=urls;
      });
      autoScroll();
    }
    catch(e){
      print('Error fetching the images $e');
    }

  }
  //method to fetch the description of the city
  Future<void> fetchDescription (String cityName)async{
  try{
    //url to fetch data using wikipedia api
    final url=Uri.parse('https://en.wikipedia.org/w/api.php?action=query&prop=extracts&exintro&explaintext&titles=$cityName&format=json',);
    //recording the response
    final response= await http.get(url);

    //if response is received
    if(response.statusCode==200){
      final data=json.decode(response.body);
      final pages=data['query']['pages'];
      final page=pages.values.first;
      setState(() {
        description= page['extract'] ?? 'No description available';
      }); 
    }
    else{
      setState(() {
        description='unable to get data';
      }); 
    }
  }
  catch(e){
    setState(() {
        description='Exception: $e ';
      }); 
    }
  }
  //method to get current weather forecast
  Future<void> getWeatherDetails(String cityName)async{
    try{
      // open weather map api key
      final apiKey="2c3f148712f893070a2a97301baa1655";
      // sending api request
      final url=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric',);
      final weatherResponse=await http.get(url);
      if(weatherResponse.statusCode==200){
        final data=json.decode(weatherResponse.body);
        setState(() {
          String iconCode=data['weather'][0]['icon'];
          iconUrl= "http://openweathermap.org/img/wn/$iconCode.png";// getting the image associated with the weather
          weatherdescription=data['weather'][0]['description'];
          mainTemperature = "${(data['main']['temp']).toInt()}°C";
          windSpeed = "${data['wind']['speed']} m/s";
          windDirection = "${data['wind']['deg']}°";
          visibility = "${data['visibility']} meters";
          sunrise = formatTime(data['sys']['sunrise']);
          sunset = formatTime(data['sys']['sunset']);
        });
      }
      else{
        weatherdescription='error fetching the weather details';
      }
    }
    catch(e){
      //catching the exception
      weatherdescription='error fetching the weather details $e';
    }
  }
  //method to convert date time to readable format
  String formatTime(int timestamp){
    DateTime date=DateTime.fromMillisecondsSinceEpoch(timestamp*1000);
    return DateFormat('hh:mm a').format(date);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Divider(color: Colors.black,thickness: 1,),
              SizedBox(height: 10),
              //decription of selected city
              Container(
                width: 300,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 226, 222, 230),
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      //fontFamily: 'IrishGrover'
                    ),
                    ),//the name of the location
                    SizedBox(height: 10,),
                    //popular spots
                    imageUrls.isNotEmpty
                    ? Image.network(imageUrls[currentIndex])
                    : Container(
                        height: 150,
                        width: 300,
                        color: Colors.grey, // Placeholder UI
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    SizedBox(height: 10,),
                    Text(description,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                    ),),
                    SizedBox(height: 10,),
                    //button to open detailed description
                    Container(
                      width: 130,
                      height: 30,
                      child: FloatingActionButton(
                      onPressed: (){
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context)=>Placedescriptionpage(description=description))
                        );
                      }  ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10,),
                          Text('Read More',
                          style: TextStyle(
                          //fontFamily: 'IrishGrover',
                          fontSize: 15,
                          color: Colors.black),
                          ),
                          SizedBox(width: 10,),
                          Icon(Icons.arrow_forward, color: Colors.black, size: 18),
                        ],
                      ),
                    backgroundColor: Color.fromARGB(255, 235, 234, 234),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    ),
                    ),
                  ],
                ),

              ),
              SizedBox(height: 20,),
              //weather container
              Container(
                width: 300,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 3),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Current Weather Forecast',
                        style: TextStyle(
                          //fontFamily: 'IrishGrover',
                          fontSize: 20
                        ),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //image
                            iconUrl.isNotEmpty
                            ? Image.network(iconUrl, fit: BoxFit.cover,)
                            : Container(
                                height: 80,
                                width: 80,
                                child: Center(child: CircularProgressIndicator()),
                              ),
                          ],
                        ),
                        
                        SizedBox(width: 80,),
                        
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(mainTemperature,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),),
                            SizedBox(height: 10,),
                            Text(weatherdescription,
                            style: TextStyle(
                              fontSize: 14
                            ),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text('Visibility upto $visibility',
                              style: TextStyle(fontSize: 12),),
                              SizedBox(height: 10,),
                              Text('Wind Speed is $windSpeed at $windDirection ',
                              style: TextStyle(fontSize: 12),),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    Text('Sunrise at $sunrise',
                                    style: TextStyle(fontSize: 12),),
                                    SizedBox(width: 30,),
                                    Text('Sunset at $sunset',
                                    style: TextStyle(fontSize: 12),),
                                ],

                              )
                            ],
                        ),
                      ],
                    )

                  ],
                ),
              ),
              SizedBox(height: 10,),
              
            ],

          ),
        ),
      ),
      bottomNavigationBar: Bottomnavigationbar(),
    );
  }
}
