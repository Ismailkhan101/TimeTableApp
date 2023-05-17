import 'package:flutter/material.dart';
import 'package:fyp_project/screens/Drawermain.dart';

import 'package:mysql1/mysql1.dart';

class ListofUser extends StatefulWidget {
  ListofUser({Key? key}) : super(key: key);

  @override
  State<ListofUser> createState() => _ListofUserState();
}

class _ListofUserState extends State<ListofUser> {
  List<List<dynamic>> _data = []; // List to store fetched data

  // Open a connection (testdb should already exist)
  Future<void> fetchData() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));

    final results = await conn.query('select * from userregistry');
    List<List<dynamic>> data = [];
    for (var row in results) {
      // Convert each row to a List<dynamic> and convert int to String
      data.add([row[0].toString(), row[1].toString(), row[2].toString(), row[3].toString()]);
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
        title: Text("List of users"),
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
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Password')),
                  DataColumn(label: Text('Status')),
                ],
                rows: _data.map((row) {
                  return DataRow(cells: [
                    DataCell(Text(row[1])),
                    DataCell(Text(row[2])),
                    DataCell(Text(row[3])),
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
