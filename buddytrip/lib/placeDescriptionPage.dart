import 'package:flutter/material.dart';

class Placedescriptionpage extends StatelessWidget {
  final String description;
  const Placedescriptionpage(this.description,{super.key});

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
                padding: EdgeInsets.all(30),
                child:Text(description),
              )
            ],
          )
          
        ),
      ),
    );
  }
}