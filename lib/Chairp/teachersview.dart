
import 'package:flutter/material.dart';
import 'package:fyp_project/Chairp/CpDrawer.dart';

import 'package:mysql1/mysql1.dart';

class listofTeachers extends StatefulWidget {
  

   String myData=""; // Declare a final variable to store the data

  listofTeachers({required this.myData});
  @override
  State<listofTeachers> createState() => _listofTeachersState(myData);
}

class _listofTeachersState extends State<listofTeachers> {
 String mydata1="";
   _listofTeachersState(this.mydata1);
  List<List<dynamic>> _data = []; // List to store fetched data
  int _selectedDept=0;
  List<List<dynamic>> _dept = [];
Future<void> departmentdata() async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',
    db: 'unitabledb',
  ));

  final results = await conn.query('select DepId ,Name,ChairId FROM  department  WHERE ChairId = $mydata1');
 
  List<List<dynamic>> deparmentlist= [];

  for (var row in results) {
    // Convert each row to a List<dynamic> and convert int to String
   deparmentlist.add([row[0].toString(), row[1].toString(), row[2].toString()]);
  }

  setState(() {
    _dept = deparmentlist; 
    
   
    // _selectedDept = _dept.isNotEmpty ? _dept[0][0].toString() : ''; // Set the default selected value
   _selectedDept=int.parse(_dept[0][0]);
   
   print( _selectedDept);
  });
List<List<dynamic>> data = [];

if(_selectedDept !=0)
{
  print(_selectedDept);
final results = await conn.query('SELECT FacultyId,FirstName,LastName,Email,Phone,UserId,	DeptId FROM faculty WHERE DeptId = $_selectedDept');

  for (var row in results) {
    // Convert each row to a List<dynamic> and convert int to String
    data.add([row[0].toString(), row[1].toString(), row[2].toString(), row[3].toString(), row[4].toString(), row[5].toString(), row[6].toString()]);
  }
}else{
  
}
    

    setState(() {
      _data = data; // Update the state with fetched data
    });
  await conn.close();
}
  // Open a connection (testdb should already exist)
  
void initState() {
    super.initState();
    departmentdata(); 
   
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("List of Teachers"),
      ),

      drawer: DrawerCp(data: mydata1),
      body: Column(
        children: [
           SizedBox(height: 15,),
        
  SizedBox(height: 15,),
              
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: DataTable(
                  columns: [
                    
                    DataColumn(label: Text('FirstName')),
                    DataColumn(label: Text('LastName')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Phone')),
                  ],
                  rows: _data.map((row) {
                    return DataRow(cells: [
                      DataCell(Text(row[1])),
                      DataCell(Text(row[2])),
                      DataCell(Text(row[3])),
                      DataCell(Text(row[4])),
                      
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
