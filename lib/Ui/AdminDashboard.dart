import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leave_management/Model/LeaveFormModel.dart';
import 'package:leave_management/Ui/AdminNotificationScreen.dart';
import 'package:leave_management/Ui/CreateEmployeeScreen.dart';
import 'package:leave_management/Ui/LoginScreen.dart';
import 'package:leave_management/Ui/ProfileScreen.dart';
import 'package:leave_management/Utils/Provider.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  @override
  void initState() {

    Provider.of<DataProvider>(context, listen: false).getLeaveList();
    Provider.of<DataProvider>(context, listen: false).getAdminReadUnreadLeaveList();

    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, dataProvider, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AdminNotificationScreen())).then((value){
                    Provider.of<DataProvider>(context, listen: false).getAdminReadUnreadLeaveList();
                  });
                },
                child: Badge(
                  label: Text(dataProvider.
                  isAdminReadUreadLeaveList
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProfileScreen(true)));
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
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                        builder: (context) => CreateEmployeeScreen()));
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
                              child: Image.asset("assets/images/empl.png")),
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
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            LoginScreen(true)));
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
                              child: Image.asset("assets/images/logout.png")),
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
                )
              ],
            ),
          ),
        ),
      );
    }
    );
  }
}
