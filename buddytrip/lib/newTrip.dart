import 'package:buddytrip/bottomnavigationbar.dart';
import 'package:flutter/material.dart';

class Newtrip extends StatefulWidget {
  const Newtrip({super.key});

  @override
  State<Newtrip> createState() => _NewtripState();
}

class _NewtripState extends State<Newtrip> {
  int selectedIndex=0;
  final List<DateTime> date=List.generate(30, (index)=>DateTime.now().add(Duration(days: 30)));
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
              Padding(padding: EdgeInsets.all(10),
              child: Container(
                width: 300,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                //select dates
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Select dates')

                  ],
                ),
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