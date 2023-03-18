import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leave_management/Model/LeaveFormModel.dart';
import 'package:leave_management/Utils/DataRepo.dart';
import 'package:leave_management/Utils/Provider.dart';
import 'package:provider/provider.dart';

class EmployeeLeaveRequestListScreen extends StatefulWidget {
  const EmployeeLeaveRequestListScreen({Key? key}) : super(key: key);

  @override
  _EmployeeLeaveRequestListScreenState createState() => _EmployeeLeaveRequestListScreenState();
}

class _EmployeeLeaveRequestListScreenState extends State<EmployeeLeaveRequestListScreen> {


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
        title: Text("Requsted Leaves"),
        centerTitle: true,
      ),
      body: Consumer<DataProvider>(builder: (context, dataProvider, child) {
        return SafeArea(
        child: Column(
          children: [
        Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Material(
          elevation: 2,
          color: Colors.teal,
          child: Padding(
            padding: const EdgeInsets.only(
                right: 10, top: 15, bottom: 15, left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                 "Type",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                 "Reason",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                 "Status",
                  textAlign: TextAlign.start,
                  style:  TextStyle(color: Colors.white, fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
          ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: dataProvider.leaveList.length,
          itemBuilder: (context, index) {
            LeaveFormModel leaveFormModel = dataProvider.leaveList[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
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
                      Text(
                        null != leaveFormModel.leaveType
                            ? leaveFormModel.leaveType.toString()
                            : "",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 15,
                        fontWeight: FontWeight.bold),
                      ),
                      Text(
                        null != leaveFormModel.reason
                            ? leaveFormModel.reason.toString()
                            : "",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Icon(leaveFormModel.status == "Pending"?
                                Icons.access_time_outlined:
                            leaveFormModel.status == "Accepted"?
                            Icons.check_circle_rounded:
                            Icons.warning),
                          ),
                          Text(
                            null != leaveFormModel.status
                                ? leaveFormModel.status
                                .toString()
                                : "",
                            textAlign: TextAlign.start,
                            style:  TextStyle(color: Colors.black, fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
          ],
        ),
      );
    }
      )
    );
  }
}
