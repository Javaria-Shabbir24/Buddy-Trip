
import 'package:buddytrip/bottomnavigationbar.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final searchbarController=TextEditingController();

  @override
  void dispose(){
    searchbarController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      endDrawer: Drawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            Padding(padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 3,color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: AssetImage('assets/home.jpg'),
                    fit: BoxFit.cover),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sync your plans, budgets and dreams',
                      style: TextStyle(fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: searchbarController,
                            decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(width: 3),
                          ),
                          hintText: 'where do you want to go?  ',
                          hintStyle: TextStyle(color:Colors.grey),
                          prefixIcon: Icon(Icons.search, color: Colors.black,),
                        ),
                      ),
                      ),
                      SizedBox(width: 4,),
                      Icon(Icons.mic, color: Colors.white,),
                      ],),
                      SizedBox(height: 20,),
                    
                    ],
                  ),
                  
            
                ),

              ],
            ),),
            SizedBox(height: 20,),
            Padding(padding: EdgeInsets.only(left: 20,right: 20,bottom: 10),
            child: 
            Text('Mostly Visited Places',
            style: TextStyle(
              fontFamily: 'IrishGrover',
              fontSize: 26,
              color: Colors.black
            ),),
            
            ),
            SizedBox(height: 20,),
            SizedBox( height: 150,
            child: PageView(
              
              children: [
                createPlaceCard('Swat', 'assets/Swat.jpg'),
                createPlaceCard('Kashmir', 'assets/Kashmir.jpg'),
              ],
            ),)
          ],
        ),

      ),
      bottomNavigationBar: Bottomnavigationbar(),

    );
  }
}

Widget createPlaceCard(String name, String path){
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
      
      image: DecorationImage(image: AssetImage(path)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(name,
        style: TextStyle(color: Colors.white,fontSize: 24),
        ),
      ],
    ),
  );
}