import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:leave_management/Model/LeaveStatusModel.dart';
import 'package:leave_management/Model/StatusModel.dart';

class Utils{

  static int CASUAL = 1;
  static int SICK = 2;
  static int MARRIAGE = 3;

  static int ACCEPT = 4;
  static int REJECT = 5;
  static int PENDING = 6;


  static String getAvatar(String name) {
    String firstLetter = name.substring(0,1);
    String lastName = "";
    if(name.contains(" ")){
      lastName = name.split(" ")[1].substring(0,1);
    }
    return firstLetter.toUpperCase() + lastName.toUpperCase();
  }

  static String getLeaveType(int statusId) {
    String? status;
    if(statusId == 1){
      status = "Casual Leave";
    }
    else if(statusId == 2){
      status = "Marriage Leave";
    }
    else {
      status = "Sick Leave";
    }
    return status;
  }

  static List<LeaveTypeModel> getLeaveTypes(){
    List<LeaveTypeModel> statusList=[];

    statusList.add(new LeaveTypeModel(id: CASUAL,type: "Casual Leave"));
    statusList.add(new LeaveTypeModel(id: MARRIAGE,type: "Marriage Leave",));
    statusList.add(new LeaveTypeModel(id: SICK,type: "Sick Leave",));
    return statusList;
  }



  static String getLeaveStatus(int statusId) {
    String? status;
    if(statusId == 4){
      status = "Accept";
    }
    else if(statusId == 5){
      status = "Reject";
    }
    else {
      status = "Pending";
    }
    return status;
  }
  static List<LeaveStatusModel> getLeavesStatus(){
    List<LeaveStatusModel> statusList=[];

    statusList.add(new LeaveStatusModel(id: ACCEPT,type: "Accept"));
    statusList.add(new LeaveStatusModel(id: REJECT,type: "Reject",));
    statusList.add(new LeaveStatusModel(id: PENDING,type: "Pending",));
    return statusList;
  }

  static Color? getStatusTypeColor(int statusId) {
    Color? statusColor;
    if(statusId == 1){
      statusColor =  Color.fromRGBO(248, 177, 149, 1);
    }
    else if(statusId == 2){
      statusColor =   Color.fromRGBO(75, 135, 185, 1);
    }
    else if(statusId == 3){
      statusColor =  Colors.red[800];
    }
    else{
      statusColor = Colors.green[700];
    }
    return statusColor;
  }
}