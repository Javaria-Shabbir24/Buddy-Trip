import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Chatterbox1 extends StatefulWidget {
  const Chatterbox1({super.key});

  @override
  State<Chatterbox1> createState() => _Chatterbox1State();
}

class _Chatterbox1State extends State<Chatterbox1> {
  final textcontroller=TextEditingController();
  bool isLoading=false;
  List<Map<String,String>> messages=[];
  String apiKey='';

  //load api key
  @override
  void initState() {
    loadApi();
    super.initState();
  }
  Future<void> loadApi()async{
    await dotenv.load();
    apiKey=dotenv.env['GEMINI_API_KEY']?? "";
  }

  //send message to gemini api and get a response 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(

          ),
        ),
        
      ),

    );
  }
}