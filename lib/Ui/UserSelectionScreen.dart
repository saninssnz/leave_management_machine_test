import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leave_management/Ui/LoginScreen.dart';

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({Key? key}) : super(key: key);

  @override
  _UserSelectionScreenState createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen> {

  bool isAdmin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2a2a2a),
        title: Text(
           "Select user"
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(
                    builder: (context) => LoginScreen(isAdmin)));
              },
              child: Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Color(0xfffc153b),
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Column(
                      children: [
                        Icon(Icons.person,
                        size: 130,
                        color: Colors.white,),
                        Text("Admin",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25
                        ),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(
                    builder: (context) => LoginScreen(!isAdmin)));
              },
              child: Center(
                child: Card(
                  color: Color(0xff2a2a2a),
            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Column(
                      children: [
                        Icon(Icons.people,
                          size: 130,
                          color: Colors.white,),
                        Text("Employee",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25
                          ),),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
