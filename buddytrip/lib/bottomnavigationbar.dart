import 'package:buddytrip/about.dart';
import 'package:buddytrip/homepage.dart';
import 'package:buddytrip/profile.dart';
import 'package:flutter/material.dart';

class Bottomnavigationbar extends StatefulWidget {
  const Bottomnavigationbar({super.key});

  @override
  State<Bottomnavigationbar> createState() => _BottomnavigationbarState();
}

class _BottomnavigationbarState extends State<Bottomnavigationbar> {
  int currentIndex=0;
  void ontap(int index){
    setState(() {
      currentIndex=index;
    });
    if(index==0){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
    }
    else if(index==1){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));
    }
    else if(index==2){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFF3C3B3E),
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.white,
      selectedItemColor: const Color(0xFF8C898F),
      currentIndex: currentIndex,
      onTap: ontap,
      items:[
      BottomNavigationBarItem(icon: Icon(Icons.home),
      label: 'Home',
      
      ),
      BottomNavigationBarItem(icon: Icon(Icons.info),
      label: 'About'
      ),
      BottomNavigationBarItem(icon: Icon(Icons.person),
      label: 'Profile'),
      BottomNavigationBarItem(icon: Icon(Icons.help),
      label: 'Help'),
      

    ]);
      
    
  }
}