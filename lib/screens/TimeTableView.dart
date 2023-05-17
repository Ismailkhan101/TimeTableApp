import 'package:flutter/material.dart';
import 'package:fyp_project/screens/Drawermain.dart';

import 'package:mysql1/mysql1.dart';

class TimeTableView extends StatefulWidget {
  TimeTableView({Key? key}) : super(key: key);

  @override
  State<TimeTableView> createState() => _TimeTableViewState();
}

class _TimeTableViewState extends State<TimeTableView> {
  List<List<dynamic>> _data = []; // List to store fetched data
String deletedata="";
  // Open a connection (testdb should already exist)
  Future<void> fetchData() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));

    final results = await conn.query('select * from TimeTable');
    List<List<dynamic>> data = [];
    for (var row in results) {
      // Convert each row to a List<dynamic> and convert int to String
      data.add([row[0].toString(), row[1].toString(), row[2].toString(), row[3].toString(), row[4].toString(), row[5].toString(), row[6].toString(),row[7].toString()]);
    }

    setState(() {
      _data = data; // Update the state with fetched data
    });

    await conn.close();
  }

  Future<void> DeleteData() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));

    final results = await conn.query('DELETE FROM TimeTable WHERE Numid = 1');
    List<List<dynamic>> data = [];
    
deletedata="Data is deleted sucessfully";
    setState(() {
      _data = data; // Update the state with fetched data
    });

    await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
      backgroundColor: Colors.blue,
      title: Text("Time Table View"),
      actions: [
        IconButton(
          icon: Icon(Icons.delete), // Icon for the button
          onPressed: () {
           DeleteData();
          },
        ),
        Text(deletedata)
      ],
    ),

      drawer: Drawermain(),
      body: Column(
        children: [
            SizedBox(height: 5,),
          ElevatedButton(
            onPressed: () => fetchData(),
            child: Text("Display"),
          ),
          Expanded(
            child: SingleChildScrollView( // Wrap the ListView with SingleChildScrollView
              child: DataTable(
                columns: [
                 
                  DataColumn(label: Text('Room')),
                  DataColumn(label: Text('Day')),
                  DataColumn(label: Text('Time')),
                  DataColumn(label: Text('Semester')),
                  DataColumn(label: Text('Subject')),
                  DataColumn(label: Text('Teacher')),
               
                  
                ],
                rows: _data.map((row) {
                  return DataRow(cells: [
                   
                    DataCell(Text(row[1])),
                    DataCell(Text(row[2])),
                    DataCell(Text(row[3])),
                    DataCell(Text(row[4])),
                    DataCell(Text(row[5])),
                    DataCell(Text(row[6])),
                    
                    
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
