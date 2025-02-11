import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username='';
  String email='';
  String phone='Add phone number';
  String gender='Add gender';
  final genderController=TextEditingController();
  final phoneNumberController=TextEditingController();
  bool phoneediting=false;
  bool genderediting=false;
  File? image;
  //function to select image
  Future<void> pickImage() async{
    final pickedFile=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      setState(() {
        image=File(pickedFile.path);
      });
    }
  }
  @override
  void initState() {
    setTheInitialStates();
    super.initState();
  }
  //Update the changes in database
  Future<void >updateValues()async{
    await FirebaseFirestore.instance.collection('Users').where('username',isEqualTo: 'javeria').get().then(
      (querysnapshot){
        for(var doc in querysnapshot.docs){
          RegExp regex = RegExp(r'^[0-9]+$');
          if(phoneNumberController.text.isNotEmpty && phoneNumberController.text.length==11 && regex.hasMatch(phoneNumberController.text))
          {
            doc.reference.update({
            'phone':phoneNumberController.text,
            });
            setState(() {
              phone=phoneNumberController.text;
            });
          }
          if(genderController.text.isNotEmpty){
            doc.reference.update({
            'gender':genderController.text,
            });
            setState(() {
              gender=genderController.text;
            });
          }
        }
        setState(() {
          genderediting=false;
          phoneediting=false;
        });
        
      }
    );
  }
  Future<void> setTheInitialStates()async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection('Users').where('username',isEqualTo: 'javeria').get();
    if(querySnapshot.docs.isNotEmpty){
      var userdata=querySnapshot.docs.first;
      setState(() {
        username=userdata['username'] ?? username;
        email=userdata['email']?? email;
        phone=userdata['phone']?? phone;
        gender=userdata['gender']?? gender;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 80,),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: image!=null ? FileImage(image!)
                    : AssetImage('assets/pfp.jpg'),
                    radius: 50,
                  ),
                  Positioned(
                    top: 60,
                    left: 70,
                    child: GestureDetector(onTap: pickImage,
                    child: CircleAvatar(backgroundColor: Colors.white,
                    radius: 15,
                    child:Icon(Icons.edit, color: Colors.black,))))
                ],
              ),

            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //username editing
                  Stack(children: [
                    TextFormField(
                      enabled: false,
                    decoration: InputDecoration(
                      hintText: username,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  ],),
                  SizedBox(height: 20,),
                  //email address editing
                  Stack(children: [
                    TextFormField(
                      enabled: false,
                    decoration: InputDecoration(
                      hintText: email,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  ],),
                  SizedBox(height: 20,),
                  //phone editing
                  Stack(children: [
                    TextFormField(
                    controller: phoneNumberController,
                    enabled: phoneediting,
                    decoration: InputDecoration(
                      hintText: phone,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Positioned(
                    right: 5, 
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          phoneediting = !phoneediting;
                        });
                      },
                      icon: Icon(phoneediting ? Icons.check : Icons.edit),
                    ),
                  ),
                  ],),
                  SizedBox(height: 20,),
                  //gender editing
                  Stack(children: [
                    TextFormField(
                    controller: genderController,
                    enabled: genderediting,
                    decoration: InputDecoration(
                      hintText: gender,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Positioned(
                    right: 5, 
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          genderediting = !genderediting;
                        });
                      },
                      icon: Icon(genderediting ? Icons.check : Icons.edit),
                    ),
                  ),
                  ],),
                  SizedBox(height: 30,),
                  Center(
                    child: ElevatedButton(onPressed: 
                    (){
                       updateValues();
                    }, child: Text('Save Changes',style: TextStyle(
                      color: Colors.green
                    ),)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}