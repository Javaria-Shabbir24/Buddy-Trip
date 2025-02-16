import 'package:buddytrip/homepage.dart';
import 'package:buddytrip/resetpassword.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey= GlobalKey<FormState>();// key to maintain the state of the form
  final usernameController= TextEditingController();
  final passwordController= TextEditingController();
  @override
  void dispose(){
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SizedBox(height: 30,),
            Center(
              child: Text('Log in to your account',
              style: TextStyle(
              fontSize: 28,
              //fontFamily: 'IrishGrover',
              color: Color(0xFF3C3B3E),
            ),),
            ),
            
            Padding(padding: EdgeInsets.all(20),
            child: Form(
              key: formKey, //maintaining a key for form
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                Text('Username:',
                style: TextStyle(
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 10,),
                TextFormField(
                  controller: usernameController,
                decoration: InputDecoration(
                hintText: 'Enter your name',
                border: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'username not entered';
                  }
                  return null;
                },),
                SizedBox(height: 20,),
                Text('Password:',
                style: TextStyle(
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 10,),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,//hiding text
                decoration: InputDecoration(
                hintText: 'Enter your password',
                border: OutlineInputBorder(),),
                validator:(value){
                  if(value==null|| value.isEmpty){
                    return 'password not entered';
                  }
                  return null;
                }
            ),
            SizedBox(height: 30,),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8F8989),
                ),
              onPressed: () async{
                if(formKey.currentState!.validate()){// if all the fields are not empty
                String name=usernameController.text.trim();
                String password=passwordController.text.trim();
                if (await verifyCredentials(name,password)){// if credentials matched
                //empty fields
                usernameController.clear();
                passwordController.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Login Successful!'))
                );
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid credentials, try again!'))
                  );

                }
                }
              },
            child: Text('Log In',style: TextStyle(
                          //fontFamily: 'IrishGrover',
                          fontSize: 15,
                          color: Colors.white),), ),
            ),
            ],
            ),),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Forgot your password?'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8F8989),
                  
                ),
                  onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Resetpassword()));
                  },
                child: Text('Reset Password',style: TextStyle(
                          //fontFamily: 'IrishGrover',
                          fontSize: 15,
                          color: Colors.white),)),
              ],

            ),

          ],
        ),
        
      ),
    );
  }
}

//function to verify the credentials
Future<bool> verifyCredentials(String username, String password) async {
  try{
    QuerySnapshot userSnapshot= await FirebaseFirestore.instance
        .collection('Users')
        .where('username', isEqualTo: username)
        .where('password', isEqualTo: password)
        .get();
    if (userSnapshot.docs.isNotEmpty) {
      return true; // Login successful
    } else {
      return false; // Login failed
    }

  }
  catch(e){
    print('Error checking login credentials $e');
    return false;
  }

}