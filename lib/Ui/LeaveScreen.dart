import 'package:flutter/material.dart';
import 'package:leave_management/Model/StatusModel.dart';
import 'package:leave_management/Utils/Utils.dart';

class LeaveScreen extends StatefulWidget {

  @override
  _LeaveScreenState createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {

  LeaveTypeModel selectedLeaveTypeModel = LeaveTypeModel();
  DateTime selectedDate = DateTime.now();
  List<String>dateList = [];

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
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Select Dates",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),),
                  InkWell(
                    onTap: (){
                      selectDate(context,selectedDate).then((value){
                        selectedDate = DateTime(value!.year,value.month,value.day,0,0,0,0);
                        dateList.add(selectedDate.toString());

                        setState(() {});
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Icon(
                          Icons.calendar_month,
                          color: Color(0xff0C305A),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: dateList.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Stack(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 1,
                            color: Colors.white,
                            child: Container(
                              height: 30,
                              width: 90,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      selectedDate.toString().split(" ")[0],
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 80.0),
                            child: InkWell(
                              onTap: (){
                                dateList.remove(dateList[index]);
                                setState(() {

                                });
                              },
                              child: Container(
                                height: 15,
                                width: 15,
                                child: Icon(Icons.close,size: 12,
                                color: Colors.white,),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.red
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

            SizedBox(
              height: 20,
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
            )
          ],
        ),
      ),
    );
  }

  Future<DateTime?> selectDate(BuildContext context, DateTime _date) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
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
