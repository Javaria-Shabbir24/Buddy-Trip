import 'package:flutter/material.dart';

class Resetpassword extends StatefulWidget {
  const Resetpassword({super.key});

  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  final formKey= GlobalKey<FormState>();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            color: Colors.black,
            thickness: 2,
          ),
          SizedBox(height: 20,),
          Center(
            child: Text('Reset Account Password',
          style: TextStyle(
            fontFamily: 'IrishGrover',
            fontSize: 28,
            color: Color(0xFF3C3B3E),
          ),),
          ),
          SizedBox(height: 20,),
          Padding(padding: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email:',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 20,),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email address',
                  border: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value== null ||value.isEmpty){
                    return 'usrename not entered';
                  }
                  return null;
                },
                
                
              )

            ],
          ),
          ),
          )
        ],
        ),
      ),
    );
  }
}