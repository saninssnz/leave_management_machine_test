import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leave_management/Model/LeaveModel.dart';

LeaveFormModel leaveFormModelFromJson(String str) => LeaveFormModel.fromJson(json.decode(str));

String leaveFormModelToJson(LeaveFormModel data) => json.encode(data.toJson());

class LeaveFormModel {
  String? id;
  DocumentReference? reference;
  String? fromDate;
  String? toDate;
  String? leaveType;
  String? reason;
  String? employeeName;
  String? employeeId;
  Timestamp? createdOn;
  String? status;

  LeaveFormModel(
      {
        this.id,
        this.fromDate,
        this.toDate,
        this.leaveType,
        this.reason,
        this.employeeName,
        this.createdOn,
        this.status,
        this.employeeId,
      });

  factory LeaveFormModel.fromJson(Map<String, dynamic> json) {


    return LeaveFormModel(
      id: json['id'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      leaveType: json['leaveType'],
      reason: json['reason'],
      employeeName: json['employeeName'],
      createdOn: json['createdOn'],
      status: json['status'],
      employeeId: json['employeeId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'fromDate': fromDate,
    'toDate': toDate,
    'leaveType': leaveType,
    'reason': reason,
    'employeeName': employeeName,
    'createdOn': createdOn,
    'status': status,
    'employeeId': employeeId,
  };

  factory LeaveFormModel.fromSnapshot(DocumentSnapshot snapshot) {
    LeaveFormModel leaveFormModel =
    LeaveFormModel.fromJson(snapshot.data() as Map<String, dynamic>);
    leaveFormModel.reference = snapshot.reference;
    return leaveFormModel;
  }
}