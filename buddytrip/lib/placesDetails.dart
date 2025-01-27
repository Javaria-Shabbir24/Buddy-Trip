import 'package:buddytrip/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';// for decoding the json response
import 'package:http/http.dart' as http;

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
  @override
  void initState(){
    super.initState();
    name=widget.name1;
    path=widget.path;
    fetchDescription(name);
    
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
        description='unable to get data';
      }); 
    }
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
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                    ),),
                  ],
                ),

              )
            ],

          ),
        ),
      ),
      bottomNavigationBar: Bottomnavigationbar(),
    );
  }
}
