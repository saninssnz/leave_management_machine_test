import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leave_management/Model/LeaveFormModel.dart';
import 'package:leave_management/Model/StatusModel.dart';
import 'package:leave_management/Utils/DataRepo.dart';
import 'package:leave_management/Utils/Provider.dart';
import 'package:leave_management/Utils/Toast.dart';
import 'package:leave_management/Utils/Utils.dart';
import 'package:provider/provider.dart';

class LeaveScreen extends StatefulWidget {

  @override
  _LeaveScreenState createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {

  LeaveTypeModel selectedLeaveTypeModel = LeaveTypeModel();
  LeaveFormModel leaveFormModel = LeaveFormModel();
  DateTime selectedDate = DateTime.now();
  DateTime fromDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,0,0,0,0);
  DateTime toDate = DateTime.now();
  TextEditingController reasonController = new TextEditingController();

  @override
  void initState() {
    selectedLeaveTypeModel.type = "Casual Leave";

    setState(() {});

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2a2a2a),
        title: Text(
            "Request Leave"
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
              child: Text("Select Date",
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
                    child: InkWell(
                      onTap: (){
                        selectFromDate(context,fromDate).then((value){
                            fromDate = DateTime(value!.year,value.month,value.day,0,0,0,0);
                          setState(() {});
                        });
                      },
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
                              fromDate.toString().split(" ")[0],
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
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    elevation: 1,
                    child: InkWell(
                      onTap: (){
                        selectToDate(context, toDate).then((value){
                            toDate = DateTime(value!.year,value.month,value.day,0,0,0,0);
                          setState(() {});
                        });

                      },
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
                              toDate.toString().split(" ")[0],
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
                  Text("Select Leave Type: ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),),
        Container(
          height: 35,
          decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(5),
              // border: Border.all(color: Colors.black, width: 1)
          ),
          child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    focusColor: Colors.white,
                    hint: Text(
                      selectedLeaveTypeModel.type.toString(),
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
                    items: Utils.getLeaveTypes().map(
                          (val) {
                        return DropdownMenuItem<LeaveTypeModel>(
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
                          selectedLeaveTypeModel = val!;
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
                style: TextStyle(
                  fontSize: 15,
                ),
                maxLines: null,
                minLines: 1,
                textAlign: TextAlign.start,
                controller: reasonController,
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
                  hintText: ("Enter reason"),
                  hintStyle: TextStyle(
                      color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: InkWell(
                onTap: (){
                  int daysBetween = (toDate.difference(fromDate).inHours / 24).round();
                  if(reasonController.text.isEmpty){
                    Toast.show("Enter reason", context);
                  }
                  else if(selectedLeaveTypeModel.type == "Casual Leave" &&
                      (daysBetween>int.parse(Provider.of<DataProvider>(context, listen: false)
                          .employeeModel.casualLeaveCount!))){

                      Toast.show("You dont have enough casual leaves left", context);

                  }
                  else if(selectedLeaveTypeModel.type == "Marriage Leave" &&
                      (daysBetween>int.parse(Provider.of<DataProvider>(context, listen: false)
                          .employeeModel.marriageLeaveCount!))){

                      Toast.show("You dont have enough marriage leaves left", context);

                  }
                  else if(selectedLeaveTypeModel.type == "Sick Leave" &&
                      (daysBetween>int.parse(Provider.of<DataProvider>(context, listen: false)
                          .employeeModel.sickLeaveCount!))){

                      Toast.show("You dont have enough sick leaves left", context);

                  }
                  else {
                    leaveFormModel.fromDate = fromDate.toString();
                    leaveFormModel.toDate = toDate.toString();
                    leaveFormModel.leaveType = selectedLeaveTypeModel.type;
                    leaveFormModel.reason = reasonController.text;
                    leaveFormModel.employeeName = Provider
                        .of<DataProvider>
                      (context, listen: false)
                        .employeeModel
                        .firstName;
                    leaveFormModel.employeeId = Provider
                        .of<DataProvider>
                      (context, listen: false)
                        .employeeModel
                        .employeeId;
                    leaveFormModel.status = "Pending";
                    leaveFormModel.isAdminRead = false;
                    leaveFormModel.casualLeaveCount = Provider
                        .of<DataProvider>
                      (context, listen: false)
                        .employeeModel
                        .casualLeaveCount;
                    leaveFormModel.mrgLeaveCount = Provider
                        .of<DataProvider>
                      (context, listen: false)
                        .employeeModel
                        .marriageLeaveCount;
                    leaveFormModel.sickLeaveCounr = Provider
                        .of<DataProvider>
                      (context, listen: false)
                        .employeeModel
                        .sickLeaveCount;

                    leaveFormModel.email = Provider
                        .of<DataProvider>
                      (context, listen: false)
                        .employeeModel
                        .email;
                    leaveFormModel.fstName = Provider
                        .of<DataProvider>
                      (context, listen: false)
                        .employeeModel
                        .firstName;
                    leaveFormModel.mdlName = Provider
                        .of<DataProvider>
                      (context, listen: false)
                        .employeeModel
                        .middleName;
                    leaveFormModel.lstName = Provider
                        .of<DataProvider>
                      (context, listen: false)
                        .employeeModel
                        .lastName;
                    leaveFormModel.usrName = Provider
                        .of<DataProvider>
                      (context, listen: false)
                        .employeeModel
                        .userName;
                    leaveFormModel.password = Provider
                        .of<DataProvider>
                      (context, listen: false)
                        .employeeModel
                        .password;
                    leaveFormModel.phn = Provider
                        .of<DataProvider>
                      (context, listen: false)
                        .employeeModel
                        .phno;
                    addLeaveRequest();
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
                        "Send Request",
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

  Future<DateTime?> selectFromDate(BuildContext context, DateTime _date) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Colors.lightBlue.shade900, // header background color
                  onPrimary: Colors.white, // header text color
                  onSurface: Colors.lightBlue.shade900, // body text color
                ),
              ),
              child: child!);
        });

    return picked;
  }
  Future<DateTime?> selectToDate(BuildContext context, DateTime _date) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Colors.lightBlue.shade900, // header background color
                  onPrimary: Colors.white, // header text color
                  onSurface: Colors.lightBlue.shade900, // body text color
                ),
              ),
              child: child!);
        });

    return picked;
  }

  addLeaveRequest() {
      leaveFormModel.createdOn = Timestamp.now();
      DataRepo().addLeaveRequest(leaveFormModel).then((value) {
        leaveFormModel.id = value.id;
        DataRepo().updateLeaveRequest(leaveFormModel);
        Navigator.of(context).pop();
        Toast.show("Leave requested successfully", context);
      });
      setState(() {
      });

  }
}
