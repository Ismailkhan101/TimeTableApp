

import 'package:flutter/material.dart';
import 'package:fyp_project/login.dart';


class WelcomeScreen extends StatefulWidget {


  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 260,top: 20),
              child: Image.asset("images/BUITEMS_logo.png",width: 130,height: 70,),
            ),


            SizedBox(height: 100,),
            
            Transform(
              alignment: Alignment.center,
              

              transform: Matrix4.rotationZ(3.1415926535897932 / 10),
              child:
                Container(child: Image.asset('images/welcome.png',width: 200,height: 320,))),

            Center(
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width-40,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(40),left: Radius.circular(40),),
                  ),
                  child: Center(
                    child: Text("Get Started",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  )
                ),
              ),
            ),
            


          ],
        ),
      ),
    );
  }
}
