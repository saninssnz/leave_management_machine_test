import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:leave_management/Model/EmployeeModel.dart';

class DataRepo {
  static String fireStoreInstanceName="leave management system";
  // static String storageDir="images/";
  // 1
  static CollectionReference employeeCollection = getFirestoreInstance()!.collection('employee');
  static CollectionReference workCollection = getFirestoreInstance()!.collection('work');
  static CollectionReference issueCollection = getFirestoreInstance()!.collection('issues');
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


  // Stream<QuerySnapshot> getCommentStream() {
  //   return commentCollection.snapshots();
  // }
  // static Future<List<CommentModel>> getAllComments() async {
  //   List<CommentModel> commentList =[];
  //   await commentCollection.get()
  //       .then((data) {
  //     commentList = List<CommentModel>.from(
  //         data.docs.map((x) => CommentModel.fromSnapshot(x)));
  //
  //   });
  //   return commentList;
  // }
  //
  //
  //
  //
  // Stream<QuerySnapshot> getIssueStream() {
  //   return issueCollection.snapshots();
  // }
  // static Future<List<IssueDetailsModel>> getAllIssues() async {
  //   List<IssueDetailsModel> issueList =[];
  //   await issueCollection.orderBy("createdOn",descending: true).get()
  //       .then((data) {
  //     issueList = List<IssueDetailsModel>.from(
  //         data.docs.map((x) => IssueDetailsModel.fromSnapshot(x)));
  //
  //   });
  //   return issueList;
  // }
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


  Future<DocumentReference> addUser(EmployeeModel employeeModel) {
    return employeeCollection.add(employeeModel.toJson());
  }

  // Future<DocumentReference> saveIssue(IssueDetailsModel issueDetailsModel) {
  //   return issueCollection.add(issueDetailsModel.toJson());
  // }
  //
  // Future updateIssue(IssueDetailsModel issueDetailsModel) async {
  //   await issueCollection.doc(issueDetailsModel.issueId).update(issueDetailsModel.toJson());
  // }
  // // 4
  // Future updateUser(UserModel userModel) async {
  //   print(userModel.email.toString()+userModel.userId.toString());
  //   await employeeCollection.doc(userModel.userId).update(userModel.toJson());
  //
  // }
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