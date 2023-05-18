import 'package:flutter/material.dart';

import 'package:fyp_project/screens/TimeTableView.dart';
import 'package:fyp_project/screens/listofusers.dart';
import 'package:fyp_project/login.dart';
import 'package:fyp_project/screens/signupscreen.dart';
import 'package:fyp_project/screens/timetable.dart';

import 'AddFaculty.dart';
import 'AddStudent.dart';
import 'Deparmentlist.dart';
import 'Department.dart';
import 'Facultyview.dart';
import 'StudentsView.dart';
import 'mainscreen.dart';
class Drawermain extends StatelessWidget {
  const Drawermain({super.key});

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
                  Text("FICT"),
                ],
              ),

              ),

            ),
           
            ListTile(
              leading: Icon(Icons.calendar_month_rounded), title: Text("Add Faculty"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFaculty ()));
              },
             
            ),
            ListTile(
              leading: Icon(Icons.calendar_month_rounded), title: Text("Faculty"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ListofFaculty ()));
              },
             
            ),
            ListTile(
              leading: Icon(Icons.calendar_month_rounded), title: Text("Add depart"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Departmentcreate ()));
              },
             
            ),
             ListTile(
              leading: Icon(Icons.calendar_month_rounded), title: Text("depart"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LisofDepatment ()));
              },
           
            ),
            ListTile(
              leading: Icon(Icons.calendar_month_rounded), title: Text("Add Student"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddStudent ()));
              },
           
            ),
            ListTile(
              leading: Icon(Icons.calendar_month_rounded), title: Text("Students"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Listofstudents  ()));
              },
           
            ),
            ListTile(
              leading: Icon(Icons.upload_file), title: Text("Upload file"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ExcelMenu()));
              },
              
            ),
             ListTile(
              leading: Icon(Icons.table_chart), title: Text("TimeTable"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeTableView()));
              },
              
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle), title: Text("Users"),
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>ListofUser()));
              },
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle), title: Text("Add Users"),
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.notification_add), title: Text("Notifications"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
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