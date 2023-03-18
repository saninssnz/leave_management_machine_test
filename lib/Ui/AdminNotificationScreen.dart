import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leave_management/Model/LeaveFormModel.dart';
import 'package:leave_management/Ui/AdminLeaveScreen.dart';
import 'package:leave_management/Utils/DataRepo.dart';
import 'package:leave_management/Utils/Provider.dart';
import 'package:provider/provider.dart';

class AdminNotificationScreen extends StatefulWidget {
  const AdminNotificationScreen({Key? key}) : super(key: key);

  @override
  _AdminNotificationScreenState createState() => _AdminNotificationScreenState();
}

class _AdminNotificationScreenState extends State<AdminNotificationScreen> {


  @override
  void initState() {

    Provider.of<DataProvider>(context, listen: false).getLeaveList();

    setState(() {});

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff2a2a2a),
          title: Text("Notifications"),
          centerTitle: true,
        ),
      body:  Consumer<DataProvider>(builder: (context, dataProvider, child) {
      return SafeArea(
        child: Column(
          children: [
        ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: dataProvider.leaveList.length,
        itemBuilder: (context, index) {
          LeaveFormModel leaveFormModel = dataProvider.leaveList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: InkWell(
              onTap: (){
                DataRepo().updateLeaveRequest(leaveFormModel);
                if (mounted) {
                  setState(() {});
                }
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        AdminLeaveScreen(leaveFormModel)));
              },
              child: Material(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10, top: 15, bottom: 15, left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(leaveFormModel.employeeName.toString() + " have requested for leave",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.redAccent
                      ),),
                      Icon(Icons.notifications,
                      color: Colors.teal,)
                    ],
                  )
                ),
              ),
            ),
          );
        }
          )
          ],
        ),
      );
        }
        )

    );
  }

}
