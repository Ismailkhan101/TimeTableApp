

import 'package:flutter/material.dart';
import 'package:fyp_project/main.dart';
import 'package:fyp_project/screens/Drawermain.dart';
import 'package:fyp_project/login.dart';
import 'dart:async';

import 'package:mysql1/mysql1.dart';
import 'mainscreen.dart';


class SignUpScreen extends StatefulWidget {
   SignUpScreen({Key? key}) : super(key: key);
 
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
   final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  String FieldNull="";
  Future main() async {
  // Open a connection (testdb should already exist)
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
      ));
print("database");
String email = emailController.text;

    String password = passwordController.text;
    String status = statusController.text;
    print(email);
    print(password);
    print(status);
    if( passwordController.text.isNotEmpty && emailController.text.isNotEmpty && statusController.text.isNotEmpty)
    {
       var stmt = "INSERT INTO userregistry (id, Email, Password, Status) VALUES (?, ?, ?, ?);";

  // Execute the prepared statement with values
  var result = await conn.query(stmt, [null, email, password, status]);
  emailController.text="";
  passwordController.text="";
  statusController.text="";
      
    }else{

      
       setState(() {
          FieldNull="Please fill the form";
       });

    }
   
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("User Registration"),
      ),
      drawer: Drawermain(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 260,top: 20),
                child: Image.asset("images/BUITEMS_logo.png",width: 130,height: 70,),
              ),
              SizedBox(height: 139,),
              Padding(
                padding: EdgeInsets.only(),
                child: Text("User Registration",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 5,),
              Container(
                width: MediaQuery.of(context).size.width-70,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.only(left: 7,right: 7),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(

                  controller: emailController, // Assign the TextEditingController
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: "Email",

                    border: InputBorder.none,

                  ),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width-70,
                margin: const EdgeInsets.all(3),
                padding: const EdgeInsets.only(left: 7,right: 7),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(
                controller: passwordController, // Assign the TextEditingController

                  decoration: InputDecoration(
                    icon: Icon(Icons.key_outlined),
                    hintText: "password",

                    border: InputBorder.none,

                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width-70,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.only(left: 7,right: 7),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(
                  controller: statusController,
                 
                  decoration: InputDecoration(
                    icon: Icon(Icons.person_pin_outlined),
                    hintText: "status",

                    
                    border: InputBorder.none,

                  ),
                ),
              ),
              SizedBox(height: 15,),
              Center(
                child: InkWell(
                  onTap: () => main(),
                  child: Container(
                      width: MediaQuery.of(context).size.width-140,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(40),left: Radius.circular(40),),
                      ),
                      child: Center(
                        child: Text("User Registration",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      )
                  ),
                ),
              ),


              SizedBox(height: 14,),
              Center(child: Text("Already have an account?")),
              Padding(
                padding: const EdgeInsets.all(0),
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

                }, child: Text("login")),
              ),

SizedBox(height: 14,),
              Center(child: Text(FieldNull)),
             





            ],

          ),
        ),
      ),
    );
  }
}
