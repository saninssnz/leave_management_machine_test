import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leave_management/Model/LeaveFormModel.dart';
import 'package:leave_management/Ui/User/EmployeeNotificationDetaislScreen.dart';
import 'package:leave_management/Utils/DataRepo.dart';
import 'package:leave_management/Utils/Provider.dart';
import 'package:provider/provider.dart';

class EmployeeNotificationScreen extends StatefulWidget {
  const EmployeeNotificationScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeNotificationScreen> createState() => _EmployeeNotificationScreenState();
}

class _EmployeeNotificationScreenState extends State<EmployeeNotificationScreen> {

  @override
  void initState() {

    Provider.of<DataProvider>(context, listen: false).getUserNotificationLeaveList();

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
                    itemCount: dataProvider.useNotificationLeaveList.length,
                    itemBuilder: (context, index) {
                      LeaveFormModel leaveFormModel = dataProvider.useNotificationLeaveList[index];
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
                                    EmployeeNotificationDetailScreen(leaveFormModel)));
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
                                    Expanded(
                                      child: Text("Your request for " + leaveFormModel.leaveType.toString()+" has been " +
                                          (leaveFormModel.status== "Accept" ?
                                          "Accepted ":
                                          leaveFormModel.status== "Reject"?
                                              "Rejected ":""
                                          ),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.redAccent
                                        ),),
                                    ),
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
