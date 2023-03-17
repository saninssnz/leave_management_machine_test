import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leave_management/Model/EmployeeModel.dart';
import 'package:leave_management/Utils/DataRepo.dart';
import 'package:leave_management/Utils/Toast.dart';

class CreateEmployeeScreen extends StatefulWidget {
  const CreateEmployeeScreen({Key? key}) : super(key: key);

  @override
  _CreateEmployeeScreenState createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController middleNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phnController = new TextEditingController();
  TextEditingController sickLeaveCountController = new TextEditingController();
  TextEditingController casualLeaveContController = new TextEditingController();
  TextEditingController marriageLeaveCountController = new TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: InkWell(
          onTap: (){
            if(firstNameController.text.isEmpty||middleNameController.text.isEmpty||
            lastNameController.text.isEmpty||emailController.text.isEmpty||
            phnController.text.isEmpty||sickLeaveCountController.text.isEmpty||
            casualLeaveContController.text.isEmpty||marriageLeaveCountController.text.isEmpty||
            usernameController.text.isEmpty||passwordController.text.isEmpty||
            confirmPasswordController.text.isEmpty){
              Toast.show("Enter all fields", context);
            }
            else if(passwordController.text != confirmPasswordController.text){
              Toast.show("Passwords does not match", context);
            }
            else{
              EmployeeModel employeeModel = new EmployeeModel();
              employeeModel.firstName = firstNameController.text;
              employeeModel.middleName = middleNameController.text;
              employeeModel.lastName = lastNameController.text;
              employeeModel.email = emailController.text;
              employeeModel.phno = phnController.text;
              employeeModel.userName = usernameController.text;
              employeeModel.password = passwordController.text;
              employeeModel.sickLeaveCount = sickLeaveCountController.text;
              employeeModel.casualLeaveCount = casualLeaveContController.text;
              employeeModel.marriageLeaveCount = marriageLeaveCountController.text;
              createEmployee(employeeModel,context);
            }
          },
          child: isLoading?
          CircularProgressIndicator(color: Colors.black,):
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xfffc153b),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Text(
                  "Create Employee",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Add Employee"),
        backgroundColor:  Color(0xff2a2a2a),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0XffE4E4E4),
                  ),
                  child: TextField(
                    controller: firstNameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      // Added this
                      contentPadding: EdgeInsets.all(15),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      hintText: "Enter First name",
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0XffE4E4E4),
                  ),
                  child: TextField(
                    controller: middleNameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      // Added this
                      contentPadding: EdgeInsets.all(15),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      hintText: "Enter middle name",
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0XffE4E4E4),
                  ),
                  child: TextField(
                    controller: lastNameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      // Added this
                      contentPadding: EdgeInsets.all(15),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      hintText: "Enter last name",
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0XffE4E4E4),
                  ),
                  child: TextField(
                    controller: emailController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      // Added this
                      contentPadding: EdgeInsets.all(15),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      hintText: "Enter email",
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0XffE4E4E4),
                  ),
                  child: TextField(
                    controller: phnController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      // Added this
                      contentPadding: EdgeInsets.all(15),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      hintText: "Enter Phone number",
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0XffE4E4E4),
                  ),
                  child: TextField(
                    controller: sickLeaveCountController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      // Added this
                      contentPadding: EdgeInsets.all(15),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      hintText: "Enter sick leave count",
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0XffE4E4E4),
                  ),
                  child: TextField(
                    controller: casualLeaveContController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      // Added this
                      contentPadding: EdgeInsets.all(15),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      hintText: "Enter casual leave count",
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0XffE4E4E4),
                  ),
                  child: TextField(
                    controller: marriageLeaveCountController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      // Added this
                      contentPadding: EdgeInsets.all(15),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      hintText: "Enter marriage leave count",
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0XffE4E4E4),
                  ),
                  child: TextField(
                    controller: usernameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      // Added this
                      contentPadding: EdgeInsets.all(15),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      hintText: "Enter Username",
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0XffE4E4E4),
                  ),
                  child: TextField(
                    controller: passwordController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      // Added this
                      contentPadding: EdgeInsets.all(15),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      hintText: "Enter password",
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0XffE4E4E4),
                  ),
                  child: TextField(
                    controller: confirmPasswordController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      // Added this
                      contentPadding: EdgeInsets.all(15),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      hintText: "Re-enter password",
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }


  void createEmployee(EmployeeModel employeeModel,BuildContext context){

    DataRepo().addEmployee(employeeModel).then((value) {

      isLoading = false;
      setState(() {

      });

      employeeModel.employeeId=value.id;

      if (employeeModel.employeeId!.isNotEmpty){

        Toast.show("Employee created successfully", context);
       Navigator.of(context).pop();

        DataRepo().updateEmployee(employeeModel);
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (BuildContext context) =>
        //         LoginPage()));

      }else{
        Toast.show('Registration failed.',context);

      }
    });

  }
}
