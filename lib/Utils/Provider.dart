import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leave_management/Model/EmployeeModel.dart';




class DataProvider with ChangeNotifier {

  EmployeeModel employeeModel = new EmployeeModel();

  setEmployeeDetails(BuildContext context, employeeModel) {
    this.employeeModel = employeeModel;
    notifyListeners();
  }

}
