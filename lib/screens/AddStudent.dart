
import 'package:flutter/material.dart';
import 'package:fyp_project/screens/Drawermain.dart';
import 'dart:async';
import 'package:mysql1/mysql1.dart';



class AddStudent extends StatefulWidget {
   AddStudent({Key? key}) : super(key: key);
 
  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
   final TextEditingController CMSIDController = TextEditingController();
   final TextEditingController FirstnameController = TextEditingController();
   final TextEditingController LastNameController = TextEditingController();
   final TextEditingController EmailController = TextEditingController();
   final TextEditingController PhoneController = TextEditingController();
 
  String FieldNull="";
  String _selectedName = "";
  String _selectedDept= ""; // Selected value from the dropdown

List<List<dynamic>> _data = [];
List<List<dynamic>> _dept = [];

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
    _data = data; 
    // Update the state with fetched data
    _selectedName = _data.isNotEmpty ? _data[0][1].toString() : ''; // Set the default selected value
  });

  await conn.close();
}

///For Department list
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

  Future main() async {
  // Open a connection (testdb should already exist)
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
      ));
print("database");
String cMSID =CMSIDController.text;
String firstname =FirstnameController.text;
String lastName=LastNameController.text;
String email=EmailController.text;
    String phone =PhoneController.text;
    print(cMSID);
    print(firstname);
print(lastName);
print(email);
print(phone);
    print(_selectedName);
    print(_selectedDept);
    if( _selectedName.isNotEmpty &&  _selectedDept.isNotEmpty && cMSID.isNotEmpty && firstname.isNotEmpty  && EmailController.text.isNotEmpty )
    {
     var stmt = "INSERT INTO students (StudentId,CMSID,FirstName,LastName,Email,Phone,UserId,DepId) VALUES (?, ?, ?, ?, ?, ?, ?, ?);";

  // // Execute the prepared statement with values
   var result = await conn.query(stmt,[null,cMSID, firstname,lastName,email,phone, _selectedName,_selectedDept]);

  CMSIDController.text="";
  FirstnameController.text="";
  LastNameController.text="";
  EmailController.text="";
  PhoneController.text="";
 
      
    }else{

      
       setState(() {
          FieldNull="Please fill the form";
       });

    }
   
}
void initState() {
    super.initState();
    departmentdata();
    _selectedDept;
    fetchData(); 
    _selectedName;// Fetch data when the widget is inserted into the widget tree
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Registration Of Departments"),
      ),
      drawer: Drawermain(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
             
           Container(
                width: MediaQuery.of(context).size.width-70,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.only(left: 7,right: 7),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(

                  controller: CMSIDController, // Assign the TextEditingController
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: "CMSId",

                    border: InputBorder.none,

                  ),
                ),
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

                  controller: FirstnameController, // Assign the TextEditingController
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: "First Name",

                    border: InputBorder.none,

                  ),
                ),
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

                  controller: LastNameController, // Assign the TextEditingController
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: "Lasr Name",

                    border: InputBorder.none,

                  ),
                ),
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

                  controller: EmailController, // Assign the TextEditingController
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: "Email",

                    border: InputBorder.none,

                  ),
                ),
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

                  controller: PhoneController, // Assign the TextEditingController
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: "Phone",

                    border: InputBorder.none,

                  ),
                ),
              ),
              SizedBox(height: 5,),
ElevatedButton(
  onPressed: () {
    fetchData(); // Fetch data when button is pressed

    if (_data != null && _data.isNotEmpty) {
      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(0, 0, 0, 0),
        items: _data.map((List<dynamic> item) {
          return PopupMenuItem<String>(
            value: item[1].toString(),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedName = item[0].toString();
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
  child: Text('Open Dropdown'),
),

SizedBox(height: 5,),
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
  child: Text('Open Dropdown'),
),
SizedBox(height: 5,),

            
              Center(
                child: InkWell(
                  onTap: () => main() ,
                  child: Container(
                      width: MediaQuery.of(context).size.width-140,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(40),left: Radius.circular(40),),
                      ),
                      child: Center(
                        child: Text("User Registration Departments",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      )
                  ),
                ),
              ),


             ],

             
             
          ),
        ),
      ),
    );
  }
}
