
import 'dart:async';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/screens/signupscreen.dart';

import 'Chairp/CpDrawer.dart';

import 'Chairp/StudentsList.dart';
import 'screens/mainscreen.dart';

class LoginScreen extends StatefulWidget {
 
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

MaterialColor myColor = Colors.blue;
String Invslid="";
  //Open a connection (testdb should already exist)
 Future<void> fetchData() async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',
    db: 'unitabledb',
  ));

  print(emailController.text);
  print(passwordController.text);

  final results = await conn.query('select * from userregistry');

  if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
    for (var row in results) {

//print(row[1]);
//print(row[2]);
//print(row[3]);
      if (row[1] == emailController.text  &&
          row[2] == passwordController.text &&
          row[3] == "admin") 
          
      {

         print('admin');
         Navigator.push(context, MaterialPageRoute(builder: (context)=>ExcelMenu()));
      }else if(row[1] == emailController.text  &&
          row[2] == passwordController.text &&
          row[3] == "CP")
          {
         final Data =row[0];
           // DrawerCp(Data.toString());
       Navigator.push(context, MaterialPageRoute(builder: (context)=>listofstudents(myData: Data.toString())));
          }
          else{
            setState(() {
              Invslid="Invalid email or password";
            });
          }
    }

    emailController.text = "";
    passwordController.text = "";
    statusController.text = "";
  } else {
    setState(() {
      Invslid="Please fill email or password";
    });
  }

  await conn.close();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 260,top: 20),
                child: Image.asset("images/BUITEMS_logo.png",width: 130,height: 70,),
              ),
              SizedBox(height: 165,),
              Padding(
                padding: EdgeInsets.only(),
                child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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

                  controller: emailController,
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

                  controller: passwordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.key_outlined),
                    hintText: "password",

                    border: InputBorder.none,

                  ),
                ),
              ),
              SizedBox(height: 15,),
              Center(
                child: InkWell(
                  onTap: () =>fetchData(),
                  // onTap: () {
                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ExcelMenu()));
                  // },
                  child: Container(
                      width: MediaQuery.of(context).size.width-140,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(40),left: Radius.circular(40),),
                      ),
                      child: Center(
                        child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      )
                  ),
                ),
              ),

              SizedBox(height: 14,),
              Center(child: Text("Don't have any account?")),
              Padding(
                padding: const EdgeInsets.all(0),
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                }, child: Text("signup")),
              ),

                SizedBox(height: 14,),
                Text(Invslid,style: TextStyle(color: Colors.red),),





            ],

          ),
        ),
      ),
    );
  }
}
