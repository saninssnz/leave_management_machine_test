import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leave_management/Model/LeaveFormModel.dart';
import 'package:leave_management/Ui/Admin/AdminLeaveScreen.dart';
import 'package:leave_management/Utils/DataRepo.dart';
import 'package:leave_management/Utils/Provider.dart';
import 'package:provider/provider.dart';

class AdminLeaveListScreen extends StatefulWidget {
  const AdminLeaveListScreen({Key? key}) : super(key: key);

  @override
  State<AdminLeaveListScreen> createState() => _AdminLeaveListScreenState();
}

class _AdminLeaveListScreenState extends State<AdminLeaveListScreen> {

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
        title: Text(
            "Leave List"
        ),
        centerTitle: true,
      ),
      body: Consumer<DataProvider>(builder: (context, dataProvider, child)
    {
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
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Employee",
                          textAlign: TextAlign.start,
                          style:  TextStyle(color: Colors.white, fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Type",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
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
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(
                      onTap: () {
                        leaveFormModel.isAdminRead = true;
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
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 10, top: 15, bottom: 15, left: 5),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  leaveFormModel.employeeName.toString(),
                                  textAlign: TextAlign.start,
                                  style:  TextStyle(fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  leaveFormModel.leaveType.toString(),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle( fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
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
