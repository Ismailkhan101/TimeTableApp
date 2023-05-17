
import 'package:flutter/material.dart';
import 'package:fyp_project/Chairp/StudentsList.dart';
import 'package:fyp_project/Chairp/teachersview.dart';

import '../login.dart';
import 'TimeTableViewCp.dart';

class DrawerCp extends StatelessWidget {
 
final String data;

  DrawerCp({required this.data});
 
  // This widget is the root of your application.
  @override
   
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.

          children: [

            Container(
              height: 170,
              decoration: BoxDecoration(
                color: Colors.grey.shade300
              ),

              child: DrawerHeader(child: Column(
                children: [
                  SizedBox(height: 5,),
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 50,
                    child: Icon(Icons.person,size: 40,color: Colors.white,),

                  ),
                  SizedBox(height: 10,),
                  Text("CP"),
                ],
              ),

              ),

            ),
            ListTile(
              leading: Icon(Icons.table_bar), title: Text("TimeTable"),
              onTap: () {
               
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeTableView()));
              },
              
            ),
             ListTile(
              leading: Icon(Icons.calendar_month_rounded), title: Text("Students"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> listofstudents(myData:data)));
              },
             
             ),
            ListTile(
              leading: Icon(Icons.calendar_month_rounded), title: Text("Faculty"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> listofTeachers(myData:data)));
              },
             
             ),
            //   ListTile(
            //   leading: Icon(Icons.calendar_month_rounded), title: Text(data),
            //   onTap: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context)=> listofstudents(myData:data)));
            //   },
             
            //  ),
            
            
              
           
            
         
            ListTile(
              leading: Icon(Icons.supervised_user_circle), title: Text("LOGOUT"),
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              },)
          ],
        ),
      );
      
      
    
  }
}