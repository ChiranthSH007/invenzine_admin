import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invenzine_admin/pages/local_admin/admin_panel.dart';
import 'package:invenzine_admin/pages/super_admin/sup_panel.dart';

// ignore: camel_case_types
class supadmin_signinPage extends StatefulWidget {
  @override
  _supadmin_signinPageState createState() => _supadmin_signinPageState();
}

class _supadmin_signinPageState extends State<supadmin_signinPage> {
  var _formkey = GlobalKey<FormState>();
  String _suadpassword, _suademail;
  bool isLoading = false;
  bool autoValidate = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[850],
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height / 1.8,
                color: Colors.yellow,
                padding: EdgeInsets.only(
                    left: size.width / 6,
                    right: size.width / 8,
                    top: size.height / 5),
                child: Text('Super Admin Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.08,
                    )),
              ),
            ],
          ),
          Positioned(
            top: size.height / 2.7,
            left: size.width / 12,
            right: size.width / 12,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.06),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "Welcome Super Admin",
                          style: TextStyle(fontSize: size.width * 0.045),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[850]))),
                        child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (item) {
                              return item.contains("@")
                                  ? null
                                  : "Enter valid Email";
                            },
                            onChanged: (item) {
                              setState(() {
                                _suademail = item;
                              });
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Enter Email",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            )),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[850]))),
                        child: TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            validator: (item) {
                              return item.length > 6
                                  ? null
                                  : "Enter Valid Password";
                            },
                            onChanged: (item) {
                              setState(() {
                                _suadpassword = item;
                              });
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Enter Password",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            )),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        width: size.width * 5,
                        height: size.height * 0.07,
                        padding: EdgeInsets.only(left: 50.0, right: 50.0),
                        child: RaisedButton(
                          color: Colors.yellow,
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.045),
                          ),
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              suadsignin();
                            }
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   return Scaffold(
  //       backgroundColor: Colors.lightBlue[300],
  //       body: isLoading
  //           ? Center(child: CircularProgressIndicator())
  //           : SingleChildScrollView(
  //               child: Center(
  //               child: Padding(
  //                 padding: const EdgeInsets.only(
  //                     top: 230.0, left: 35.0, right: 35.0),
  //                 child: Form(
  //                     key: _formkey,
  //                     autovalidate: autoValidate,
  //                     child: Column(children: [
  //                       Text(
  //                         'Super Admin Signin',
  //                         style: TextStyle(fontSize: 24),
  //                       ),
  //                       SizedBox(
  //                         height: 20,
  //                       ),
  //                       TextFormField(
  //                           keyboardType: TextInputType.emailAddress,
  //                           validator: (item) {
  //                             return item.contains("@")
  //                                 ? null
  //                                 : "Enter valid Email";
  //                           },
  //                           onChanged: (item) {
  //                             setState(() {
  //                               _ademail = item;
  //                             });
  //                           },
  //                           decoration: InputDecoration(
  //                             fillColor: Colors.white,
  //                             filled: true,
  //                             hintText: "Enter Email",
  //                             border: InputBorder.none,
  //                             focusedBorder: InputBorder.none,
  //                             enabledBorder: InputBorder.none,
  //                             errorBorder: InputBorder.none,
  //                             disabledBorder: InputBorder.none,
  //                           )),
  //                       SizedBox(
  //                         height: 20,
  //                       ),
  //                       TextFormField(
  //                           obscureText: true,
  //                           keyboardType: TextInputType.text,
  //                           validator: (item) {
  //                             return item.length > 6
  //                                 ? null
  //                                 : "Error: Please check ur EmailId and Password";
  //                           },
  //                           onChanged: (item) {
  //                             setState(() {
  //                               _adpassword = item;
  //                             });
  //                           },
  //                           decoration: InputDecoration(
  //                             fillColor: Colors.white,
  //                             filled: true,
  //                             hintText: "Enter Password",
  //                             border: InputBorder.none,
  //                             focusedBorder: InputBorder.none,
  //                             enabledBorder: InputBorder.none,
  //                             errorBorder: InputBorder.none,
  //                             disabledBorder: InputBorder.none,
  //                           )),
  //                       SizedBox(
  //                         height: 20,
  //                       ),
  //                       Container(
  //                         margin: EdgeInsets.symmetric(vertical: 5),
  //                         width: size.width * 2,
  //                         height: size.height * 0.07,
  //                         padding: EdgeInsets.only(left: 50.0, right: 50.0),
  //                         child: RaisedButton(
  //                           color: Colors.yellow,
  //                           child: Text(
  //                             "Login",
  //                             style:
  //                                 TextStyle(color: Colors.black, fontSize: 17),
  //                           ),
  //                           onPressed: () {
  //                             suadsignin();
  //                           },
  //                           shape: new RoundedRectangleBorder(
  //                             borderRadius: new BorderRadius.circular(30.0),
  //                           ),
  //                         ),
  //                       ),
  //                     ])),
  //               ),
  //             )));
  // }

  // sign with email and pwd
  Future<void> suadsignin() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      DocumentReference docref =
          Firestore.instance.collection("Super").document(_suademail);
      DocumentSnapshot doc = await docref.get();
      String email = doc.data['Email'];
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _suademail, password: _suadpassword)
          .then(
        (user) async {
          setState(() {
            isLoading = false;
          });
          if (_suademail == email) {
            setState(() {
              isLoading = false;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => Sup_Admin_page()),
                  (Route<dynamic> route) => false);
              Fluttertoast.showToast(msg: "Welcome Admin");
            });
          } else {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
                msg: "Please Enter Correct Super Admin Email and Password..!!");
          }
        },
      );
    }
  }
}
