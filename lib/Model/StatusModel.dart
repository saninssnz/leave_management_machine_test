import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';


LeaveTypeModel leaveTypeModelFromJson(String str) => LeaveTypeModel.fromJson(json.decode(str));

String leaveTypeModelToJson(LeaveTypeModel data) => json.encode(data.toJson());

class LeaveTypeModel {
  LeaveTypeModel({
    this.type,
    this.id,
    // this.color
  });


  String? type;
  int? id;
  // Color? color;


  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) => LeaveTypeModel(
    type: json["type"],
    id: json["id"],
    // color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
    // "color": color,
  };
}
