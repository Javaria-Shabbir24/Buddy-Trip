import 'package:buddytrip/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey= GlobalKey<FormState>();// key to maintain the state of the form
  final usernameController= TextEditingController();
  final passwordController= TextEditingController();
  final emailController=TextEditingController();
  final confirmPasswordController=TextEditingController();
  @override
  void dispose(){
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
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
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            SizedBox(height: 18,),
            Center(
              child: Text('Create an Account',
              style: TextStyle(
              fontSize: 26,
              fontFamily: 'IrishGrover',
              color: Color(0xFF3C3B3E),
            ),),
            ),
            Padding(padding: EdgeInsets.all(25),
            child: Form(
              key: formKey, //maintaining a key for form
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Text('Username:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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
                Text('Email:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 10,),
                TextFormField(
                  controller: emailController,
                decoration: InputDecoration(
                hintText: 'Enter your email address',
                border: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'email not entered';
                  }
                  else if(!value.contains('@')){
                    return 'incorrect email';
                  }
                  return null;
                },),
                SizedBox(height: 20,),
                Text('Password:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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
                  if(value.length<6)
                  {
                    return 'password length should be atleast 6 characters';
                  }
                  return null;
                }
            ),
            SizedBox(height: 20,),
                Text('Confirm Password:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 10,),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                decoration: InputDecoration(
                hintText: 'Enter your password again',
                border: OutlineInputBorder(),

              ),
              validator: (value){
                if(value==null || value.isEmpty){
                  return 'confirm password field empty';
                }
                else if(value!=passwordController.text){
                  return 'Passwords do not match';
                }
                return null;
              },

            ),
            SizedBox(height: 30,),
            Center(
              child: ElevatedButton(
              onPressed: () async{
                if(formKey.currentState!.validate()){// if all the fields are not empty
                String name=usernameController.text.trim();
                String password=passwordController.text.trim();
                String email=emailController.text.trim();
                await saveTheDataToDatabase(name,password,email);
                //empty fields
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User signed up successfully!'))
                  );
                usernameController.clear();
                passwordController.clear();
                confirmPasswordController.clear();
                emailController.clear();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                }
              },
            child: Text('Sign up'), ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Already have an account?'),
                ElevatedButton(
                  onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                  },
                child: Text('Log in')),
              ],

            ),
            ],
            ),),),
          ],
        ),
      ),
      
    );
  }
}

//save the data to database
Future<void> saveTheDataToDatabase(String username, String password, String email)async{
  try{
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    await users.add(
      {
      'username':username,
      'password':password,
      'email':email,
      }
    );
    
    print('User Signed Up successfully');
  }
  on FirebaseException catch (e) {
    print('FirebaseException: ${e.message}');
  }
  catch(e){
    print('failed to add user : $e');
  }

}