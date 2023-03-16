import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leave_management/Ui/AdminDashboard.dart';
import 'package:leave_management/Ui/EmployeeDashboard.dart';
import 'package:leave_management/Utils/Toast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen(this.isAdmin);
  bool isAdmin;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: InkWell(
          onTap: (){
            if(usernameController.text.isEmpty ) {
              Toast.show("Enter username", context);
            }
            else if(passwordController.text.isEmpty){
              Toast.show("Enter password", context);
            }
            else {
              if (widget.isAdmin) {
                if (usernameController.text == "admin" &&
                    passwordController.text == "123") {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                      builder: (context) => widget.isAdmin?
                      AdminDashboard():
                      EmployeeScreen()
                  ));
                }
                else{
                  Toast.show("Wrong username or password", context);
                }
              }
            }
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xfffc153b),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Text(
                  "Login",
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
        backgroundColor: Color(0xff2a2a2a),
        title: Text(
          widget.isAdmin?
              "Admin Login":
              "Emoloyee Login"
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              widget.isAdmin?
              Container(
                height: 300,
                  width: 300,
                  child: Image.asset("assets/images/admin.png")):
              Container(
                  height: 300,
                  width: 300,
                  child: Image.asset("assets/images/employee.png")),
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
                    obscureText: true,
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
                      hintText: "Enter Password",
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),

              SizedBox(
                height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
