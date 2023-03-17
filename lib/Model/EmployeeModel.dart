import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leave_management/Model/LeaveModel.dart';

EmployeeModel employeeModelFromJson(String str) => EmployeeModel.fromJson(json.decode(str));

String employeeModelToJson(EmployeeModel data) => json.encode(data.toJson());

class EmployeeModel {
  String? firstName;
  String? middleName;
  String? lastName;
  String? userName;
  DocumentReference? reference;
  String? password;
  String? email;
  String? phno;
  String? casualLeaveCount;
  String? marriageLeaveCount;
  String? sickLeaveCount;
  String? employeeId;
  List<LeaveModel>? leaveList;

  EmployeeModel(
      {this.firstName,
        this.middleName,
        this.lastName,
        this.userName,
        this.password,
        this.email,
        this.phno,
        this.casualLeaveCount,
        this.marriageLeaveCount,
        this.sickLeaveCount,
        this.employeeId,
        this.leaveList
      });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {

    List<LeaveModel> leaveModelList = null!=json["leaveList"] &&
        json["leaveList"].length>0?
    List<LeaveModel>.from(json["leaveList"].map((x) => LeaveModel.fromJson(x))):[];


    return EmployeeModel(
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      userName: json['userName'],
      password: json['password'],
      employeeId: json['employeeId'],
      email: json['email'],
      phno: json['phno'],
      casualLeaveCount: json['casualLeaveCount'],
      marriageLeaveCount: json['marriageLeaveCount'],
      sickLeaveCount: json['sickLeaveCount'],
      leaveList: leaveModelList,
    );
  }

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'middleName': middleName,
    'lastName': lastName,
    'userName': userName,
    'password': password,
    'email': email,
    'phno': phno,
    'casualLeaveCount': casualLeaveCount,
    'marriageLeaveCount': marriageLeaveCount,
    'sickLeaveCount': sickLeaveCount,
    'employeeId': employeeId,
    'leaveList': leaveList,
  };
  // static String encode(List<UserModel> userModelList) => json.encode(
  //   userModelList
  //       .map<Map<String, dynamic>>((userModel) => UserModel.toJson(userModel))
  //       .toList(),
  // );
  factory EmployeeModel.fromSnapshot(DocumentSnapshot snapshot) {
    EmployeeModel userModel =
    EmployeeModel.fromJson(snapshot.data() as Map<String, dynamic>);
    userModel.reference = snapshot.reference;
    return userModel;
  }
}
