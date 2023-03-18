import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

AdminModel adminModelFromJson(String str) => AdminModel.fromJson(json.decode(str));

String adminModelToJson(AdminModel data) => json.encode(data.toJson());

class AdminModel {
  String? userName;
  DocumentReference? reference;
  String? password;
  String? userId;

  AdminModel(
      {
        this.userName,
        this.password,
        this.userId,
      });

  factory AdminModel.fromJson(Map<String, dynamic> json) {


    return AdminModel(
      userName: json['userName'],
      password: json['password'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'password': password,
    'userId': userId,
  };
  // static String encode(List<UserModel> userModelList) => json.encode(
  //   userModelList
  //       .map<Map<String, dynamic>>((userModel) => UserModel.toJson(userModel))
  //       .toList(),
  // );
  factory AdminModel.fromSnapshot(DocumentSnapshot snapshot) {
    AdminModel adminModel =
    AdminModel.fromJson(snapshot.data() as Map<String, dynamic>);
    adminModel.reference = snapshot.reference;
    return adminModel;
  }
}
