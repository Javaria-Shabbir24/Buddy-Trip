import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  Future<void>sendMessage(BuildContext context)async{
    //if the request is empty return
    if(textcontroller.text.isEmpty){
      return;
    }
    //load the message in a variable
    String userMessage=textcontroller.text;
    setState(() {
      textcontroller.clear();
    });
    //add in the list
    messages.add({'role':'user','text':userMessage});
    isLoading=true;
    updateUI(context);

    //http request to api
    try{
      //response
      final response = await http.post(
      Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": userMessage}
            ]
          }
        ]
      }),
    );
    //if response has been received
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      String botMessage = data['candidates'][0]['content']['parts'][0]['text'];
      //add message in the list
      messages.add({"role": "bot", "text": botMessage});
    }
    else {
          messages.add({"role": "bot", "text": "Error: Failed to get response"});
        }
      } catch (e) {
        messages.add({"role": "bot", "text": "Error: $e"});
      }
  isLoading = false;
  updateUI(context);
  }
  //ui rebuild
  void updateUI(BuildContext context) {
  (context as Element).markNeedsBuild();
  }

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