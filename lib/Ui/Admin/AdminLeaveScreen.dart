import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:leave_management/Model/EmployeeModel.dart';
import 'package:leave_management/Model/LeaveFormModel.dart';
import 'package:leave_management/Model/LeaveStatusModel.dart';
import 'package:leave_management/Model/StatusModel.dart';
import 'package:leave_management/Utils/DataRepo.dart';
import 'package:leave_management/Utils/Provider.dart';
import 'package:leave_management/Utils/Toast.dart';
import 'package:leave_management/Utils/Utils.dart';
import 'package:provider/provider.dart';

class AdminLeaveScreen extends StatefulWidget {
  AdminLeaveScreen(this.leaveFormModel);

  LeaveFormModel leaveFormModel = LeaveFormModel();

  @override
  _AdminLeaveScreenState createState() => _AdminLeaveScreenState();
}

class _AdminLeaveScreenState extends State<AdminLeaveScreen> {

  LeaveStatusModel selectedLeaveStatusModel = LeaveStatusModel();
  LeaveFormModel leaveFormModel = LeaveFormModel();
  EmployeeModel employeeModel = EmployeeModel();
  String deviceToken = "";

  @override
  void initState() {

    null!=widget.leaveFormModel?
    selectedLeaveStatusModel.type = widget.leaveFormModel.status.toString():
    "Pending";

    setState(() {});

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2a2a2a),
        title: Text(
            "Leave Request"
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text("Dates",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(5),
                    elevation: 1,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "From:  ",
                            style: TextStyle(
                                color: Color(0xff0C305A),
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.leaveFormModel.fromDate.toString().split(" ")[0],
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Icon(
                              Icons.calendar_month,
                              color: Color(0xff0C305A),
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "To:  ",
                            style: TextStyle(
                                color: Color(0xff0C305A),
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.leaveFormModel.toDate.toString().split(" ")[0],
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Icon(
                              Icons.calendar_month,
                              color: Color(0xff0C305A),
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Leave Type: ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(5),
                        // border: Border.all(color: Colors.black, width: 1)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.leaveFormModel.leaveType.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )
                        ),
                      )
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text("Reason",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                enabled: false,
                readOnly: true,
                style: TextStyle(
                  fontSize: 15,
                ),
                maxLines: null,
                minLines: 1,
                textAlign: TextAlign.start,
                controller: TextEditingController(text:widget.leaveFormModel.reason.toString()),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 1,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Colors.white,
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                      color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Select Status: ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.circular(5),
                      // border: Border.all(color: Colors.black, width: 1)
                    ),
                    child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            focusColor: Colors.white,
                            hint: Text(
                              selectedLeaveStatusModel.type.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            iconSize: 30.0,
                            iconDisabledColor: Colors.white,
                            iconEnabledColor: Colors.white,
                            // style: TextStyle(color: Colors.blue),
                            items: Utils.getLeavesStatus().map(
                                  (val) {
                                return DropdownMenuItem<LeaveStatusModel>(
                                    value: val,
                                    child: Text(
                                      val.type!,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ));
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                    () {
                                      selectedLeaveStatusModel = val!;
                                  // issueDetailsModel.statusId = selectedStatusModel.id;
                                },
                              );
                            },
                          ),
                        )),
                  )
                ],
              ),
            ),

            SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: InkWell(
                onTap: (){
                  leaveFormModel.fromDate = widget.leaveFormModel.fromDate.toString();
                  leaveFormModel.toDate = widget.leaveFormModel.toDate.toString();
                  leaveFormModel.leaveType = widget.leaveFormModel.leaveType.toString();
                  leaveFormModel.reason = widget.leaveFormModel.reason.toString();
                  leaveFormModel.employeeName = widget.leaveFormModel.employeeName.toString();
                  leaveFormModel.employeeId = widget.leaveFormModel.employeeId.toString();
                  leaveFormModel.status = selectedLeaveStatusModel.type.toString();
                  leaveFormModel.id = widget.leaveFormModel.id.toString();
                  leaveFormModel.createdOn = widget.leaveFormModel.createdOn;
                  leaveFormModel.reference = widget.leaveFormModel.reference;
                  leaveFormModel.oldCasualLeaveCount = widget.leaveFormModel.casualLeaveCount;
                  leaveFormModel.oldmrgLeaveCount = widget.leaveFormModel.mrgLeaveCount;
                  leaveFormModel.oldsickLeaveCount = widget.leaveFormModel.sickLeaveCount;
                  leaveFormModel.isAdminRead = true;
                  leaveFormModel.isUserRead = false;
                  updateLeaveRequest();
                  if(selectedLeaveStatusModel.type == "Accept"){

                    DateTime to = DateTime.parse(widget.leaveFormModel.toDate.toString());
                    DateTime from = DateTime.parse(widget.leaveFormModel.fromDate.toString());
                    int dif = (to.difference(from).inHours / 24).round();

                    if(widget.leaveFormModel.leaveType == "Casual Leave"){
                      int casualLeaveCount =(int.parse(widget.leaveFormModel.casualLeaveCount.toString()) - dif);
                      employeeModel.casualLeaveCount = casualLeaveCount.toString();
                      employeeModel.sickLeaveCount = widget.leaveFormModel.sickLeaveCount.toString();
                      employeeModel.marriageLeaveCount =widget.leaveFormModel.mrgLeaveCount.toString();
                      employeeModel.employeeId = widget.leaveFormModel.employeeId.toString();
                      employeeModel.email = widget.leaveFormModel.email.toString();
                      employeeModel.firstName = widget.leaveFormModel.fstName.toString();
                      employeeModel.middleName = widget.leaveFormModel.mdlName.toString();
                      employeeModel.lastName = widget.leaveFormModel.lstName.toString();
                      employeeModel.password = widget.leaveFormModel.password.toString();
                      employeeModel.phno = widget.leaveFormModel.phn.toString();
                      employeeModel.userName = widget.leaveFormModel.usrName.toString();

                      DataRepo().updateEmployee(employeeModel);
                    }
                    else if(widget.leaveFormModel.leaveType == "Marriage Leave"){
                      int mrgCount =(int.parse(widget.leaveFormModel.mrgLeaveCount.toString()) - dif);
                      employeeModel.marriageLeaveCount = mrgCount.toString();

                      employeeModel.sickLeaveCount = widget.leaveFormModel.sickLeaveCount.toString();
                      employeeModel.casualLeaveCount =widget.leaveFormModel.casualLeaveCount.toString();
                      employeeModel.employeeId = widget.leaveFormModel.employeeId.toString();
                      employeeModel.email = widget.leaveFormModel.email.toString();
                      employeeModel.firstName = widget.leaveFormModel.fstName.toString();
                      employeeModel.middleName = widget.leaveFormModel.mdlName.toString();
                      employeeModel.lastName = widget.leaveFormModel.lstName.toString();
                      employeeModel.password = widget.leaveFormModel.password.toString();
                      employeeModel.phno = widget.leaveFormModel.phn.toString();
                      employeeModel.userName = widget.leaveFormModel.usrName.toString();

                      DataRepo().updateEmployee(employeeModel);
                    }
                    else if(widget.leaveFormModel.leaveType == "Sick Leave"){
                      int sickLeaveCount =(int.parse(widget.leaveFormModel.sickLeaveCount.toString()) - dif);
                      employeeModel.sickLeaveCount = sickLeaveCount.toString();

                      employeeModel.casualLeaveCount = widget.leaveFormModel.casualLeaveCount.toString();
                      employeeModel.marriageLeaveCount =widget.leaveFormModel.mrgLeaveCount.toString();
                      employeeModel.employeeId = widget.leaveFormModel.employeeId.toString();
                      employeeModel.email = widget.leaveFormModel.email.toString();
                      employeeModel.firstName = widget.leaveFormModel.fstName.toString();
                      employeeModel.middleName = widget.leaveFormModel.mdlName.toString();
                      employeeModel.lastName = widget.leaveFormModel.lstName.toString();
                      employeeModel.password = widget.leaveFormModel.password.toString();
                      employeeModel.phno = widget.leaveFormModel.phn.toString();
                      employeeModel.userName = widget.leaveFormModel.usrName.toString();

                      DataRepo().updateEmployee(employeeModel);
                    }
                  }
                  else if(selectedLeaveStatusModel.type == "Reject"){

                    if(widget.leaveFormModel.leaveType == "Casual Leave"){
                      employeeModel.casualLeaveCount = widget.leaveFormModel.oldCasualLeaveCount;
                      employeeModel.sickLeaveCount = widget.leaveFormModel.sickLeaveCount.toString();
                      employeeModel.marriageLeaveCount =widget.leaveFormModel.mrgLeaveCount.toString();
                      employeeModel.employeeId = widget.leaveFormModel.employeeId.toString();
                      employeeModel.email = widget.leaveFormModel.email.toString();
                      employeeModel.firstName = widget.leaveFormModel.fstName.toString();
                      employeeModel.middleName = widget.leaveFormModel.mdlName.toString();
                      employeeModel.lastName = widget.leaveFormModel.lstName.toString();
                      employeeModel.password = widget.leaveFormModel.password.toString();
                      employeeModel.phno = widget.leaveFormModel.phn.toString();
                      employeeModel.userName = widget.leaveFormModel.usrName.toString();

                      DataRepo().updateEmployee(employeeModel);
                    }
                    else if(widget.leaveFormModel.leaveType == "Marriage Leave"){
                      employeeModel.marriageLeaveCount = widget.leaveFormModel.oldmrgLeaveCount.toString();
                      employeeModel.sickLeaveCount = widget.leaveFormModel.sickLeaveCount.toString();
                      employeeModel.casualLeaveCount =widget.leaveFormModel.casualLeaveCount.toString();
                      employeeModel.employeeId = widget.leaveFormModel.employeeId.toString();
                      employeeModel.email = widget.leaveFormModel.email.toString();
                      employeeModel.firstName = widget.leaveFormModel.fstName.toString();
                      employeeModel.middleName = widget.leaveFormModel.mdlName.toString();
                      employeeModel.lastName = widget.leaveFormModel.lstName.toString();
                      employeeModel.password = widget.leaveFormModel.password.toString();
                      employeeModel.phno = widget.leaveFormModel.phn.toString();
                      employeeModel.userName = widget.leaveFormModel.usrName.toString();

                      DataRepo().updateEmployee(employeeModel);
                    }
                    else if(widget.leaveFormModel.leaveType == "Sick Leave"){
                      employeeModel.sickLeaveCount = widget.leaveFormModel.oldsickLeaveCount.toString();
                      employeeModel.casualLeaveCount = widget.leaveFormModel.casualLeaveCount.toString();
                      employeeModel.marriageLeaveCount =widget.leaveFormModel.mrgLeaveCount.toString();
                      employeeModel.employeeId = widget.leaveFormModel.employeeId.toString();
                      employeeModel.email = widget.leaveFormModel.email.toString();
                      employeeModel.firstName = widget.leaveFormModel.fstName.toString();
                      employeeModel.middleName = widget.leaveFormModel.mdlName.toString();
                      employeeModel.lastName = widget.leaveFormModel.lstName.toString();
                      employeeModel.password = widget.leaveFormModel.password.toString();
                      employeeModel.phno = widget.leaveFormModel.phn.toString();
                      employeeModel.userName = widget.leaveFormModel.usrName.toString();

                      DataRepo().updateEmployee(employeeModel);
                    }
                  }

                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xfffc153b),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Text(
                        "Update",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateLeaveRequest() {
      DataRepo().updateLeaveRequest(leaveFormModel);
      if (mounted) {
        setState(() {});
      }
      Navigator.of(context).pop(true);
      Toast.show("Updated successfully", context);
    }
}
