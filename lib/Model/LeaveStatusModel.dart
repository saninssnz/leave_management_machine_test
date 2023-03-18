import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';


LeaveStatusModel leaveStatusModelFromJson(String str) => LeaveStatusModel.fromJson(json.decode(str));

String leaveStatusModelToJson(LeaveStatusModel data) => json.encode(data.toJson());

class LeaveStatusModel {
  LeaveStatusModel({
    this.type,
    this.id,
    // this.color
  });


  String? type;
  int? id;
  // Color? color;


  factory LeaveStatusModel.fromJson(Map<String, dynamic> json) => LeaveStatusModel(
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
