import 'package:flutter/material.dart';
import 'package:leave_management/Model/StatusModel.dart';
import 'package:leave_management/Utils/Toast.dart';
import 'package:leave_management/Utils/Utils.dart';

class LeaveScreen extends StatefulWidget {

  @override
  _LeaveScreenState createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {

  LeaveTypeModel selectedLeaveTypeModel = LeaveTypeModel();
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
                        selectDate(context,fromDate).then((value){
                          if(fromDate==value||toDate==value){
                            Toast.show("Date already picked", context);
                          }
                          else{
                            fromDate = DateTime(value!.year,value.month,value.day,0,0,0,0);
                          }
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
                        selectDate(context, toDate).then((value){
                          if(toDate==value|| fromDate==value){
                            Toast.show("Date already picked", context);
                          }
                          else{
                            toDate = DateTime(value!.year,value.month,value.day,0,0,0,0);
                          }
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
          ],
        ),
      ),
    );
  }

  Future<DateTime?> selectDate(BuildContext context, DateTime _date) async {
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
}