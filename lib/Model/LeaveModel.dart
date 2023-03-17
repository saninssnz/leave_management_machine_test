
import 'dart:convert';
import 'dart:typed_data';


LeaveModel leaveModelFromJson(String str) => LeaveModel.fromJson(json.decode(str));

String leaveModelToJson(LeaveModel data) => json.encode(data.toJson());

class LeaveModel {
  LeaveModel({
    this.leaveId,
    this.leaveType,
    this.details,
    this.date
  });

  String? leaveId;
  String? leaveType;
  String? details;
  List? date;


  factory LeaveModel.fromJson(Map<String, dynamic> json) => LeaveModel(
    leaveId: json["leaveId"],
    leaveType: json["leaveType"],
    details: json["details"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "leaveId": leaveId,
    "leaveType": leaveType,
    "details": details,
    "date": date,
  };
}
