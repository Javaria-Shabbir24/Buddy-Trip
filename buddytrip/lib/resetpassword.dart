import 'package:buddytrip/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final confirmPasswordController=TextEditingController();
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
          SizedBox(height: 40,),
          Padding(padding: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email:',
              style: TextStyle(
                fontSize: 20,
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
                    return 'email address not entered';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              Text('Password:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 20,),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Enter your new password',
                  border: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value==null||value.isEmpty){
                    return('Password not entered');
                  }
                  return null;
                },

              ),
              SizedBox(height: 20,),
              Text('Confirm Password:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 20,),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Confirm your new password',
                  border: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value==null||value.isEmpty){
                    return('Confirm password not entered');
                  }
                  else if(value!=passwordController.text){
                    return 'Password fields do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30,),
              Center(
                child: ElevatedButton(
                  onPressed: ()async{
                    if(formKey.currentState!.validate()){
                      String email=emailController.text.trim();
                      String password=passwordController.text.trim();
                      await updateCredentials(context, email, password);
                      emailController.clear();
                      passwordController.clear();
                      confirmPasswordController.clear();
                    }
                  },
                 child: Text('Reset Password'),),
              ),

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
//update the credentials in the database
Future<void> updateCredentials(BuildContext context, String email, String password)async{
  try{
    final CollectionReference users= FirebaseFirestore.instance.collection('Users');
    final QuerySnapshot querySnapshot= await users.where('email',isEqualTo:email).get();
    if(querySnapshot.docs.isEmpty)
    {
      //if email address doen not exist
      ScaffoldMessenger.of(context)..showSnackBar(
        SnackBar(content: Text('Email address does not exist'))
      );
    }
    else{
      //update password
      final String documentid= querySnapshot.docs.first.id;
      await users.doc(documentid).update({'password':password});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password changed succeffully!')),
      );
      Navigator.push(context, 
      MaterialPageRoute(builder: (context)=>Login()));
    }
  }
  catch(e){
    print('Error updating the credentials $e');
  }

}