import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leave_management/Model/EmployeeModel.dart';
import 'package:leave_management/Model/LeaveFormModel.dart';

import 'DataRepo.dart';




class DataProvider with ChangeNotifier {

  EmployeeModel employeeModel = new EmployeeModel();
  List<LeaveFormModel> leaveList = [];
  List<LeaveFormModel> isAdminReadUreadLeaveList = [];
  List<LeaveFormModel> useNotificationLeaveList = [];
  bool isLoadingRequests = false;

  setEmployeeDetails(BuildContext context, employeeModel) {
    this.employeeModel = employeeModel;
    notifyListeners();
  }

  // setLeaveList(List<LeaveFormModel> model){
  //   this.leaveList = model;
  //   notifyListeners();
  // }

  Future getLeaveList() async {

      isLoadingRequests = true;

    List<DocumentSnapshot> docs;
    DataRepo.leaveCollection.get().then((event) {

        isLoadingRequests = false;


      docs = event.docs;
      if (docs.length > 0) {
        leaveList = List<LeaveFormModel>.from(
            docs.map((x) => LeaveFormModel.fromSnapshot(x)));
        notifyListeners();

      } else if (docs.length == 0) {
        leaveList = [];
        notifyListeners();
      }
      notifyListeners();
    });
    return null;
  }

  Future getAdminReadUnreadLeaveList() async {

    isLoadingRequests = true;

    List<DocumentSnapshot> docs;
    DataRepo.leaveCollection.where("isAdminRead",isEqualTo: false).get().then((event) {

      isLoadingRequests = false;


      docs = event.docs;
      if (docs.length > 0) {
        isAdminReadUreadLeaveList = List<LeaveFormModel>.from(
            docs.map((x) => LeaveFormModel.fromSnapshot(x)));
        notifyListeners();

      } else if (docs.length == 0) {
        isAdminReadUreadLeaveList = [];
        notifyListeners();
      }
      notifyListeners();
    });
    return null;
  }





  Future getUserNotificationLeaveList() async {

    isLoadingRequests = true;

    List<DocumentSnapshot> docs;
    DataRepo.leaveCollection.where("status",isNotEqualTo: "Pending",).get().then((event) {

      isLoadingRequests = false;


      docs = event.docs;
      if (docs.length > 0) {
        useNotificationLeaveList = List<LeaveFormModel>.from(
            docs.map((x) => LeaveFormModel.fromSnapshot(x)));
        notifyListeners();

      } else if (docs.length == 0) {
        useNotificationLeaveList = [];
        notifyListeners();
      }
      notifyListeners();
    });
    return null;
  }


}
