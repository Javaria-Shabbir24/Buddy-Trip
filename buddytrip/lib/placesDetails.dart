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
  final String description='';
  @override
  void initState(){
    super.initState();
    name=widget.name1;
    path=widget.path;
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