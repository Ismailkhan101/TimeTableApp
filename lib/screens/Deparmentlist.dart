import 'package:flutter/material.dart';
import 'package:fyp_project/screens/Drawermain.dart';

import 'package:mysql1/mysql1.dart';

class LisofDepatment extends StatefulWidget {
  LisofDepatment({Key? key}) : super(key: key);

  @override
  State<LisofDepatment> createState() => _LisofDepatmentState();
}

class _LisofDepatmentState extends State<LisofDepatment> {
  List<List<dynamic>> _data = []; // List to store fetched data

  // Open a connection (testdb should already exist)
  Future<void> fetchData() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));

    final results = await conn.query('select * from department');
    List<List<dynamic>> data = [];
    for (var row in results) {
      // Convert each row to a List<dynamic> and convert int to String
      data.add([row[0].toString(), row[1].toString(), row[2].toString()]);
    }

    setState(() {
      _data = data; // Update the state with fetched data
    });

    await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("List of Departments"),
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
                  DataColumn(label: Text('Department')),
                  DataColumn(label: Text('ChairId')),
                  
                ],
                rows: _data.map((row) {
                  return DataRow(cells: [
                    DataCell(Text(row[1])),
                    DataCell(Text(row[2])),
                   
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
