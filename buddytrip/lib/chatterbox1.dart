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
  final textcontroller = TextEditingController();
  bool isLoading = false;
  List<Map<String, String>> messages = [];
  String apiKey = '';

  @override
  void initState() {
    loadApi();
    super.initState();
  }

  Future<void> loadApi() async {
    await dotenv.load();
    apiKey = dotenv.env['GEMINI_API_KEY'] ?? "";
  }

  Future<void> sendMessage(BuildContext context) async {
    
    if (textcontroller.text.isEmpty) {
      return;
    }
    if (apiKey.isEmpty){
      loadApi();
    }
    String userMessage = textcontroller.text;
    setState(() {
      textcontroller.clear();
      messages.add({'role': 'user', 'text': userMessage});
      isLoading = true;
    });

    try {
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

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String botMessage = data['candidates'][0]['content']['parts'][0]['text'];
        setState(() {
          messages.add({"role": "bot", "text": botMessage});
        });
      } else {
        setState(() {
          messages.add({"role": "bot", "text": "Error: Failed to get response"});
        });
      }
    } catch (e) {
      setState(() {
        messages.add({"role": "bot", "text": "Error: $e"});
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 245, 237, 243),
      body: Column(
        children: [
          SizedBox(height: 50,),
          Text('ChatterBox',style: TextStyle(fontFamily: 'IrishGrover',fontSize: 30),),
          Divider(color: Colors.black,),
          Flexible(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message['role'] == 'user' ? Alignment.centerRight : Alignment.centerLeft,
                  child: Padding(padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 16),
                  child:Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //if its the bot
                        if(message['role']=='bot')
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/chatterbox.jpg'),
                        ),
                        SizedBox(width: 8,),
                        Flexible(child: 
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                          color: message['role'] == 'user' ?  Color.fromARGB(255, 130, 92, 165) : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          message['text']!,
                          style: TextStyle(color: message['role']=='user' ? Colors.white: Colors.black),
                        ),

                        )),
                        SizedBox(width: 8),
                        if (message['role'] == 'user') 
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/pfp.jpg'),
                          ),

                      ],
                  ),),
                );
              },
            ),
          ),
          if (isLoading) CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30), 
                border: Border.all(color: Colors.grey.shade300), 
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          controller: textcontroller,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            border: InputBorder.none, 
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color:  Color.fromARGB(255, 130, 92, 165),
                        shape: BoxShape.circle, 
                        
                      ),
                      child: IconButton(
                        icon: Icon(Icons.send, color: Colors.white),
                        onPressed: () => sendMessage(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }
}
