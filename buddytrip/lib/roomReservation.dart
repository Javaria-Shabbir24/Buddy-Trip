import 'package:buddytrip/homepage.dart';
import 'package:flutter/material.dart';

class Roomreservation extends StatelessWidget {
  
  const Roomreservation({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage())),
      child: 
    Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 450,
          width: 280,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 5),
          borderRadius: BorderRadius.circular(20)

          ),

        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            SizedBox(
              height: 100,
              width: 100,
              child: Image(image: AssetImage('assets/tick.jpg'),fit: BoxFit.cover,)
            ),
            SizedBox(height: 20,),
            Center(child: 
            Text('Your booking \n    has been \n      placed',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27),),),
            SizedBox(height: 3
            ),
            
            SizedBox(height: 40,),
            Text('Thanks for choosing us!'),
            
          ],
        ),
        
      ),
      ),
      

    ));
  }
}
