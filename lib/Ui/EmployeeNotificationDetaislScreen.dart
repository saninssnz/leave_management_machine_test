import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leave_management/Model/LeaveFormModel.dart';
import 'package:leave_management/Utils/DataRepo.dart';

class EmployeeNotificationDetailScreen extends StatefulWidget {
  LeaveFormModel leaveFormModel = new LeaveFormModel();
  EmployeeNotificationDetailScreen(this.leaveFormModel);


  @override
  State<EmployeeNotificationDetailScreen> createState() => _EmployeeNotificationDetailScreenState();
}

class _EmployeeNotificationDetailScreenState extends State<EmployeeNotificationDetailScreen> {

  @override
  void initState() {

    widget.leaveFormModel.isUserRead = true;
    setState(() {

    });
    DataRepo().updateLeaveRequest(widget.leaveFormModel);
    if (mounted) {
      setState(() {});
    }

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
      body: SafeArea(
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
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 2,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10, top: 15, bottom: 15, left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.leaveFormModel.leaveType.toString(),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.leaveFormModel.reason.toString(),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Icon( widget.leaveFormModel.status == "Pending"?
                            Icons.access_time_outlined:
                            widget.leaveFormModel.status == "Accept"?
                            Icons.check_circle_rounded:
                            Icons.warning),
                          ),
                          Text(
                            null !=  widget.leaveFormModel.status
                                ?
                            ( widget.leaveFormModel.status == "Accept"?
                            "Accepted":
                            widget.leaveFormModel.status == "Reject"?
                            "Rejected":
                            widget.leaveFormModel.status.toString())
                                : "",
                            textAlign: TextAlign.start,
                            style:  TextStyle(fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }
}
