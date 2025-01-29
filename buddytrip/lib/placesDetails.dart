import 'package:buddytrip/bottomnavigationbar.dart';
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
  late String name;
  late String path;
  String description='Loading description...';
  String weatherdescription="Loading weather forecast...";
  String mainTemperature="";
  String visibility="";
  String lat="";
  String lon="";
  String tempMin="";
  String tempMax="";
  String windSpeed="";
  String windDirection="";
  String sunrise="";
  String sunset="";
  String iconUrl="";
  @override
  void initState(){
    super.initState();
    name=widget.name1;
    path=widget.path;
    //call method for city description 
    fetchDescription(name);
    //call method for weather details
    getWeatherDetails(name);
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
          mainTemperature = "${data['main']['temp']}°C";
          tempMin = "${data['main']['temp_min']}°C";
          tempMax = "${data['main']['temp_max']}°C";
          windSpeed = "${data['wind']['speed']} m/s";
          windDirection = "${data['wind']['deg']}°";
          visibility = "${data['visibility']} meters";
          lat = data['coord']['lat'].toString();
          lon = data['coord']['lon'].toString();
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
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    ),//the name of the location
                    SizedBox(height: 20,),
                    
                    Text(description,
                    maxLines: 7,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                    ),),
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
                          fontFamily: 'IrishGrover',
                          fontSize: 20
                        ),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(weatherdescription+mainTemperature+""+"\n"+visibility+""+lat+""+lon+"\n" +tempMax+""+tempMin+""+windSpeed+"\n"+windDirection+""+sunrise+""+sunset,
                        style: TextStyle(
                          fontSize: 12
                        ),
                        ),
                        
                        
                      ],
                    ),
                    //next part here
                    Container(
                       child:  Image.network(iconUrl)
                      
                    ),
                    //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(mainTemperature,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),)
                          ],
                        ),
                        SizedBox(width: 20,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //image
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.network(iconUrl,
                              fit: BoxFit.cover,),
                            ),
                          ],
                        )

                      ],
                      

                    )

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
