import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:leave_management/Model/AdminModel.dart';
import 'package:leave_management/Model/EmployeeModel.dart';
import 'package:leave_management/Model/LeaveFormModel.dart';

class DataRepo {
  static String fireStoreInstanceName="leave management system";
  // static String storageDir="images/";
  // 1
  static CollectionReference employeeCollection = getFirestoreInstance()!.collection('employee');
  static CollectionReference adminCollection = getFirestoreInstance()!.collection('admin');
  static CollectionReference leaveCollection = getFirestoreInstance()!.collection('leaveForm');
  static CollectionReference staffAttendanceCollection = getFirestoreInstance()!.collection('staffAttendance');
  static CollectionReference commentCollection = getFirestoreInstance()!.collection('comment');

  // 2
  Stream<QuerySnapshot> getStream() {
    return employeeCollection.snapshots();
  }
  static Future<List<EmployeeModel>> getAllUser() async {
    List<EmployeeModel> userList =[];
    await employeeCollection.get()
          .then((data) {
        userList = List<EmployeeModel>.from(
            data.docs.map((x) => EmployeeModel.fromSnapshot(x)));

    });
     return userList;
  }


  Stream<QuerySnapshot> getAdminStream() {
    return commentCollection.snapshots();
  }
  static Future<List<AdminModel>> getAllComments() async {
    List<AdminModel> adminList =[];
    await commentCollection.get()
        .then((data) {
      adminList = List<AdminModel>.from(
          data.docs.map((x) => AdminModel.fromSnapshot(x)));

    });
    return adminList;
  }
  //
  //
  //
  //
  Stream<QuerySnapshot> getLeaveListStream() {
    return leaveCollection.snapshots();
  }
  static Future<List<LeaveFormModel>> getAllIssues() async {
    List<LeaveFormModel> leaveList =[];
    await leaveCollection.orderBy("createdOn",descending: true).get()
        .then((data) {
      leaveList = List<LeaveFormModel>.from(
          data.docs.map((x) => LeaveFormModel.fromSnapshot(x)));

    });
    return leaveList;
  }
  //
  //
  //
  // Stream<QuerySnapshot> getStaffAttendanceStream() {
  //   return staffAttendanceCollection.snapshots();
  // }
  // static Future<List<StaffAttendanceModel>> getStaffAttendance() async {
  //   List<StaffAttendanceModel> staffAttendanceList =[];
  //   await staffAttendanceCollection.get()
  //       .then((data) {
  //     staffAttendanceList = List<StaffAttendanceModel>.from(
  //         data.docs.map((x) => StaffAttendanceModel.fromSnapshot(x)));
  //
  //   });
  //   return staffAttendanceList;
  // }
  // Future<DocumentReference> createWork(WorkModel workModel) {
  //   return workCollection.add(WorkModel.toJson(workModel));
  // }

  // Future updateWork(WorkModel workModel) async{
  //   return workCollection.doc(workModel.workId).update(WorkModel.toJson(workModel));
  // }
  // Future deleteWork(WorkModel workModel) async{
  //   return workCollection.doc(workModel.workId).delete();
  // }


  Future<DocumentReference> addEmployee(EmployeeModel employeeModel) {
    return employeeCollection.add(employeeModel.toJson());
  }

  Future<DocumentReference> addLeaveRequest(LeaveFormModel leaveFormModel) {
    return leaveCollection.add(leaveFormModel.toJson());
  }

  Future updateLeaveRequest(LeaveFormModel leaveFormModel) async {
    await leaveCollection.doc(leaveFormModel.id).update(leaveFormModel.toJson());
  }
  // // 4
  Future updateEmployee(EmployeeModel employeeModel) async {
    // print(userModel.email.toString()+userModel.userId.toString());
    await employeeCollection.doc(employeeModel.employeeId).update(employeeModel.toJson());

  }

  Future updateAdmin(AdminModel adminModel) async {
    // print(userModel.email.toString()+userModel.userId.toString());
    await adminCollection.doc(adminModel.userId).update(adminModel.toJson());
  }
  //
  // Future<DocumentReference> saveStaffAttendance(StaffAttendanceModel staffAttendanceModel) {
  //   return staffAttendanceCollection.add(staffAttendanceModel.toJson());
  // }
  //
  // Future updateStaffAttendance(StaffAttendanceModel staffAttendanceModel) async {
  //   await staffAttendanceCollection.doc(staffAttendanceModel.checkInId).update(staffAttendanceModel.toJson());
  // }
  //
  // Future<DocumentReference> saveComment(CommentModel commentModel) {
  //   return commentCollection.add(commentModel.toJson());
  // }
  //
  // Future updateComment(CommentModel commentModel) async {
  //   await commentCollection.doc(commentModel.commentId).update(commentModel.toJson());
  // }


  static FirebaseFirestore? getFirestoreInstance() {

    if (kIsWeb) {
      for (var app in Firebase.apps) {
        if (app.name == fireStoreInstanceName) {
          return FirebaseFirestore.instanceFor(app: app);
        }
      }
    }else{
      return FirebaseFirestore.instance;

    }
    return null;
  }
  static FirebaseStorage? getFirestoreStorageInstance() {

    if (kIsWeb) {
      for (var app in Firebase.apps) {
        if (app.name == fireStoreInstanceName) {
          return FirebaseStorage.instanceFor(app: app);
        }
      }
    }else{
      return FirebaseStorage.instance;

    }
    return null;
  }

}