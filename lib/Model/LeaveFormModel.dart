import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

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
  String? fstName;
  String? mdlName;
  String? lstName;
  String? employeeId;
  String? casualLeaveCount;
  String? sickLeaveCount;
  String? mrgLeaveCount;
  String? oldCasualLeaveCount;
  String? oldmrgLeaveCount;
  String? oldsickLeaveCount;
  String? email;
  String? usrName;
  String? password;
  String? phn;
  Timestamp? createdOn;
  String? status;
  bool? isAdminRead;
  bool? isUserRead;

  LeaveFormModel(
      {
        this.id,
        this.fromDate,
        this.toDate,
        this.leaveType,
        this.reason,
        this.usrName,
        this.password,
        this.phn,
        this.employeeName,
        this.createdOn,
        this.status,
        this.employeeId,
        this.isAdminRead,
        this.isUserRead,
        this.sickLeaveCount,
        this.mrgLeaveCount,
        this.casualLeaveCount,
        this.email,
        this.fstName,
        this.mdlName,
        this.lstName,
        this.oldsickLeaveCount,
        this.oldmrgLeaveCount,
        this.oldCasualLeaveCount,
      });

  factory LeaveFormModel.fromJson(Map<String, dynamic> json) {


    return LeaveFormModel(
      id: json['id'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      fstName: json['fstName'],
      mdlName: json['mdlName'],
      lstName: json['lstName'],
      usrName: json['usrName'],
      password: json['password'],
      phn: json['phn'],
      leaveType: json['leaveType'],
      reason: json['reason'],
      employeeName: json['employeeName'],
      createdOn: json['createdOn'],
      status: json['status'],
      employeeId: json['employeeId'],
      sickLeaveCount: json['sickLeaveCounr'],
      mrgLeaveCount: json['mrgLeaveCount'],
      casualLeaveCount: json['casualLeaveCount'],
      email: json['email'],
      isAdminRead: json['isAdminRead'],
      isUserRead: json['isUserRead'],
      oldCasualLeaveCount: json['oldLasualLeaveCount'],
      oldmrgLeaveCount: json['oldmrcasualLeaveCount'],
      oldsickLeaveCount: json['oldsickLeaveCount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'fromDate': fromDate,
    'toDate': toDate,
    'leaveType': leaveType,
    'reason': reason,
    'usrName': usrName,
    'password': password,
    'phn': phn,
    'employeeName': employeeName,
    'createdOn': createdOn,
    'status': status,
    'employeeId': employeeId,
    'isAdminRead': isAdminRead,
    'isUserRead': isUserRead,
    'sickLeaveCounr': sickLeaveCount,
    'mrgLeaveCount': mrgLeaveCount,
    'casualLeaveCount': casualLeaveCount,
    'fstName': fstName,
    'mdlName': mdlName,
    'lstName': lstName,
    'oldmrgLeaveCount': oldmrgLeaveCount,
    'oldsickLeaveCount': oldsickLeaveCount,
    'oldCasualLeaveCount': oldCasualLeaveCount,
  };

  factory LeaveFormModel.fromSnapshot(DocumentSnapshot snapshot) {
    LeaveFormModel leaveFormModel =
    LeaveFormModel.fromJson(snapshot.data() as Map<String, dynamic>);
    leaveFormModel.reference = snapshot.reference;
    return leaveFormModel;
  }
}
