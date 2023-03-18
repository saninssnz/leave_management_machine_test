import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leave_management/Model/LeaveFormModel.dart';
import 'package:leave_management/Ui/LoginScreen.dart';
import 'package:leave_management/Ui/ProfileScreen.dart';
import 'package:leave_management/Ui/User/EmployeeLeaveRequestListScreen.dart';
import 'package:leave_management/Ui/User/EmployeeNotificationScreen.dart';
import 'package:leave_management/Ui/User/LeaveScreen.dart';
import 'package:leave_management/Utils/DataRepo.dart';
import 'package:leave_management/Utils/Provider.dart';
import 'package:provider/provider.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {

  List<LeaveFormModel> isUserReadUreadLeaveList = [];

  @override
  void initState() {

    getUserReadUnreadLeaveList();

    setState(() {});

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, dataProvider, child)
    {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          EmployeeNotificationScreen())).then((value){
                   getUserReadUnreadLeaveList();
                  });
                },
                child: Badge(
                  label: Text(
                  isUserReadUreadLeaveList
                      .length
                      .toString(), style: TextStyle(
                      color: Colors.white
                  ),),
                  backgroundColor: Colors.redAccent,
                  child: Icon(Icons.notifications,
                    size: 30,),
                ),
              ),
            )
          ],
          backgroundColor: Color(0xff2a2a2a),
          title: Text("Dashboard"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ProfileScreen(false)));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.orange,
                        child: Container(
                          height: 150,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 80,
                                  width: 80,
                                  child: Image.asset("assets/images/adm.png")),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("My Profile",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 25
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                LeaveScreen()));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.green,
                        child: Container(
                          height: 150,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(
                                      "assets/images/leave.png")),
                              Text("Leave",
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
                  ],
                ),

                SizedBox(height: 30,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                LoginScreen(false)));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.teal,
                        child: Container(
                          height: 150,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 80,
                                  width: 80,
                                  child: Image.asset(
                                      "assets/images/logout.png")),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("Logout",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 25
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EmployeeLeaveRequestListScreen()));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.redAccent,
                        child: Container(
                          height: 150,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 80,
                                  width: 80,
                                  child: Image.asset(
                                      "assets/images/request.png")),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("Leave Requests",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 25
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
    );
  }
  Future getUserReadUnreadLeaveList() async {

    List<DocumentSnapshot> docs;
    DataRepo.leaveCollection.where("isUserRead",isEqualTo: false).get().then((event) {


      docs = event.docs;
      if (docs.length > 0) {

        isUserReadUreadLeaveList = List<LeaveFormModel>.from(
            docs.map((x) => LeaveFormModel.fromSnapshot(x)));

        setState(() {

        });


      } else if (docs.length == 0) {
        isUserReadUreadLeaveList = [];
        setState(() {

        });

      }
    });
    return null;
  }
}
