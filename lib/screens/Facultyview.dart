import 'package:flutter/material.dart';
import 'package:fyp_project/screens/Drawermain.dart';

import 'package:mysql1/mysql1.dart';

class ListofFaculty extends StatefulWidget {
 ListofFaculty({Key? key}) : super(key: key);

  @override
  State<ListofFaculty> createState() => _ListofFacultyState();
}

class _ListofFacultyState extends State<ListofFaculty> {
  List<List<dynamic>> _data = []; // List to store fetched data
  String _selectedDept= "";
  List<List<dynamic>> _dept = [];
Future<void> departmentdata() async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',
    db: 'unitabledb',
  ));

  final results = await conn.query('select * from department');
 
  List<List<dynamic>> deparmentlist= [];

  for (var row in results) {
    // Convert each row to a List<dynamic> and convert int to String
   deparmentlist.add([row[0].toString(), row[1].toString(), row[2].toString()]);
  }

  setState(() {
    _dept = deparmentlist; 
     _selectedDept = _dept.isNotEmpty ? _dept[0][1].toString() : ''; // Set the default selected value
   
  });

  await conn.close();
}
  // Open a connection (testdb should already exist)
  Future<void> fetchData() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));
    List<List<dynamic>> data = [];

if(_selectedDept.isEmpty)
{
final results = await conn.query('select * from faculty');
    
    for (var row in results) {
      // Convert each row to a List<dynamic> and convert int to String
      data.add([row[0].toString(), row[1].toString(), row[2].toString(), row[3].toString(),row[4].toString(), row[5].toString(), row[6].toString()]);
    }
}else{
  final results = await conn.query('SELECT FacultyId,FirstName,LastName,Email,Phone,UserId,	DeptId FROM faculty WHERE DeptId = $_selectedDept');

  for (var row in results) {
    // Convert each row to a List<dynamic> and convert int to String
    data.add([row[0].toString(), row[1].toString(), row[2].toString(), row[3].toString(), row[4].toString(), row[5].toString(), row[6].toString()]);
  }
}
    

    setState(() {
      _data = data; // Update the state with fetched data
    });

    await conn.close();
  }
void initState() {
    super.initState();
    fetchData();
    departmentdata(); // Fetch data when the widget is inserted into the widget tree
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("List of Students"),
      ),

      drawer: Drawermain(),
      body: Column(
        children: [
           SizedBox(height: 15,),
           ElevatedButton(
  onPressed: () {
    departmentdata(); // Fetch data when button is pressed

    if (_dept != null && _dept.isNotEmpty) {
      showMenu(
           context: context,
        position: RelativeRect.fromLTRB(0, 0, 0, 0),
        items: _dept.map((List<dynamic> item) {
          return PopupMenuItem<String>(
           
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedDept = item[0].toString();
                  Navigator.pop(context);
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(item[1].toString()),
              ),
            ),
          );
        }).toList(),
      );
    } else {
      // Handle case when _data is null or empty
      print('No data to display in the dropdown menu.');
    }
  },
  child: Text('Open Selecting Department'),
),
  SizedBox(height: 15,),
              Center(
                child: InkWell(
                  onTap: () =>fetchData(),
                  child: Container(
                      width: MediaQuery.of(context).size.width-140,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(40),left: Radius.circular(40),),
                      ),
                      child: Center(
                        child: Text("Search Department",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      )
                  ),
                ),
              ),
          Expanded(
            child: SingleChildScrollView(
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
        ],
      ),
    );
  }
}
