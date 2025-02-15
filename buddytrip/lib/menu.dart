import 'package:buddytrip/about.dart';
import 'package:buddytrip/budgetAndSpendings.dart';
import 'package:buddytrip/chatterbox.dart';
import 'package:buddytrip/help.dart';
import 'package:buddytrip/home.dart';
import 'package:buddytrip/profile.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DrawerHeader(
            child: CircleAvatar(
            backgroundImage: AssetImage('assets/pfp.jpg'),
            radius: 50,
          )),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=>Profile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=>About()));
            },
          ),
          ListTile(
            leading: Icon(Icons.chat_bubble),
            title: Text('ChatterBox'),
            onTap: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=>Chatterbox()));
            },
          ),
          ListTile(
            leading: Icon(Icons.wallet),
            title: Text('Expense Tracker'),
            onTap: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=>Budgetandspendings()));
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help Center'),
            onTap: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=>Help()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7, 
                      height: 200, 
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Logout Confirmation',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Are you sure you want to logout?',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); 
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green, 
                                  foregroundColor: Colors.white, 
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                ),
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red, 
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                ),
                                child: Text('Yes'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );

            },
          ),
        ],
      ),

    );
  }
}