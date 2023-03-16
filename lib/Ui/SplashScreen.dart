import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leave_management/Ui/UserSelectionScreen.dart';

class IntoPage extends StatefulWidget {
  @override
  State createState() => IntoPageState();
}

class IntoPageState extends State<IntoPage>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {

    startTime();

    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width-50,
                child: Image.asset(
                  'assets/images/Logo.png',
                  alignment: Alignment.center,
                ),
              ),
            ),
            Center(
              child: Text("LEAVE MANAGEMENT SYSTEM",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple
              ),),
            )
          ],
        ),
      ),
    );
  }



  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => UserSelectionScreen()));
  }
}