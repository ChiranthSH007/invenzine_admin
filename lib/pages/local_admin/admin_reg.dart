import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invenzine_admin/pages/local_admin/admin_appr.dart';
import 'package:invenzine_admin/pages/local_admin/admin_panel.dart';

import 'package:invenzine_admin/services/crud.dart';

// ignore: camel_case_types
class admin_reginPage extends StatefulWidget {
  @override
  _admin_reginPageState createState() => _admin_reginPageState();
}

// ignore: camel_case_types
class _admin_reginPageState extends State<admin_reginPage> {
  String _adpassword, _ademail, _uname, _address, _destination, _id, _pnumber;
  List<dynamic> subs;
  bool isLoading = false;
  var _formkey = GlobalKey<FormState>();
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
                    left: size.width / 4.3,
                    right: size.width / 7,
                    top: size.height / 9),
                child: Text('Admin Register',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.075,
                    )),
              ),
            ],
          ),
          Positioned(
            top: size.height / 5,
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
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[850]))),
                        child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (item) {
                              return item.isNotEmpty
                                  ? null
                                  : "Enter valid UserName";
                            },
                            onChanged: (item) {
                              setState(() {
                                _uname = item;
                              });
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Enter UserName",
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
                            keyboardType: TextInputType.emailAddress,
                            validator: (item) {
                              return item.contains("@")
                                  ? null
                                  : "Enter valid Email";
                            },
                            onChanged: (item) {
                              setState(() {
                                _ademail = item;
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
                            keyboardType: TextInputType.emailAddress,
                            validator: (item) {
                              return item.isNotEmpty ? null : "Enter valid ID";
                            },
                            onChanged: (item) {
                              setState(() {
                                _id = item;
                              });
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Enter Id Proof",
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
                            keyboardType: TextInputType.emailAddress,
                            validator: (item) {
                              return item.isNotEmpty
                                  ? null
                                  : "Enter valid PhoneNumber";
                            },
                            onChanged: (item) {
                              setState(() {
                                _pnumber = item;
                              });
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Enter Phone Number",
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
                            keyboardType: TextInputType.emailAddress,
                            validator: (item) {
                              return item.isNotEmpty
                                  ? null
                                  : "Enter valid Address";
                            },
                            onChanged: (item) {
                              setState(() {
                                _address = item;
                              });
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Enter Address",
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
                            keyboardType: TextInputType.emailAddress,
                            validator: (item) {
                              return item.isNotEmpty
                                  ? null
                                  : "Enter valid Occupation or Destination";
                            },
                            onChanged: (item) {
                              setState(() {
                                _destination = item;
                              });
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Enter Occupation or Destination",
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
                                _adpassword = item;
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
                            "Register",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.045),
                          ),
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              adreg();
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
  //                         'Admin Register',
  //                         style: TextStyle(fontSize: 24),
  //                       ),
  //                       SizedBox(
  //                         height: 20,
  //                       ),
  //                       TextFormField(
  //                           keyboardType: TextInputType.text,
  //                           validator: (item) {
  //                             return item.isNotEmpty
  //                                 ? null
  //                                 : "Error: Please enter Username";
  //                           },
  //                           onChanged: (item) {
  //                             setState(() {
  //                               _uname = item;
  //                             });
  //                           },
  //                           decoration: InputDecoration(
  //                             fillColor: Colors.white,
  //                             filled: true,
  //                             hintText: "Enter UserName",
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
  //                           keyboardType: TextInputType.text,
  //                           validator: (item) {
  //                             return item.isNotEmpty ? null : "Enter valid ID";
  //                           },
  //                           onChanged: (item) {
  //                             setState(() {
  //                               _id = item;
  //                             });
  //                           },
  //                           decoration: InputDecoration(
  //                             fillColor: Colors.white,
  //                             filled: true,
  //                             hintText: "Enter Valid ID",
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
  //                           keyboardType: TextInputType.phone,
  //                           validator: (item) {
  //                             return item.isNotEmpty
  //                                 ? null
  //                                 : "Enter valid Phone Number";
  //                           },
  //                           onChanged: (item) {
  //                             setState(() {
  //                               _pnumber = item;
  //                             });
  //                           },
  //                           decoration: InputDecoration(
  //                             fillColor: Colors.white,
  //                             filled: true,
  //                             hintText: "Enter Phone Number",
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
  //                           keyboardType: TextInputType.streetAddress,
  //                           validator: (item) {
  //                             return item.isNotEmpty
  //                                 ? null
  //                                 : "Enter valid Address";
  //                           },
  //                           onChanged: (item) {
  //                             setState(() {
  //                               _address = item;
  //                             });
  //                           },
  //                           decoration: InputDecoration(
  //                             fillColor: Colors.white,
  //                             filled: true,
  //                             hintText: "Enter Address",
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
  //                           keyboardType: TextInputType.text,
  //                           validator: (item) {
  //                             return item.isNotEmpty
  //                                 ? null
  //                                 : "Enter valid Occupation or Destination";
  //                           },
  //                           onChanged: (item) {
  //                             setState(() {
  //                               _destination = item;
  //                             });
  //                           },
  //                           decoration: InputDecoration(
  //                             fillColor: Colors.white,
  //                             filled: true,
  //                             hintText: "Enter Occupation or Destination",
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
  //                             "Register",
  //                             style:
  //                                 TextStyle(color: Colors.black, fontSize: 17),
  //                           ),
  //                           onPressed: () {
  //                             adreg();
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

  //sign with email and pwd
  void adreg() async {
    CrudMethods crudMethods = new CrudMethods();
    if (_formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      FirebaseAuth _auth = FirebaseAuth.instance;
      try {
        AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: _ademail,
          password: _adpassword,
        );
        setState(() {
          isLoading = false;
        });
        FirebaseUser user = authResult.user;
        try {
          await user.sendEmailVerification();
          var userUpdateInfo =
              new UserUpdateInfo(); //for registering the username to .displayname
          userUpdateInfo.displayName = _uname;
          await user.updateProfile(userUpdateInfo);
          Map<String, dynamic> admindata = {
            "Username": _uname,
            "Email": _ademail,
            "IDProof": _id,
            "PhoneNumber": _pnumber,
            "Address": _address,
            "Occupation": _destination,
            "ApprovalStatus": false,
            "Subscribers": subs,
          };
          crudMethods.addadminusername(admindata, _ademail);
          Fluttertoast.showToast(msg: "Registration Successfull");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => Admin_approval()),
              (Route<dynamic> route) => false);
        } catch (e) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: "Error" + e.toString());
        }
      } on PlatformException catch (e) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Error" + e.toString());
        print(e.details);
      }

      //not work for registing and storing username

      // CrudMethods crudMethods = new CrudMethods();
      //  FirebaseAuth _auth = FirebaseAuth.instance;

      // AuthResult authResult = await _auth
      //     .createUserWithEmailAndPassword(
      //         email: _ademail, password: _adpassword)
      //     .then((user) async {
      //   setState(() {
      //     isLoading = false;
      //   });

      //  var userUpdateInfo = new UserUpdateInfo();
      //   userUpdateInfo.displayName = _uname;
      //   await user.updateProfile(userUpdateInfo);

      //   Fluttertoast.showToast(msg: "Registration Successfull");
      //   Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(builder: (_) => Admin_page()),
      //       (Route<dynamic> route) => false);
      // }).catchError((onError) {
      //   setState(() {
      //     isLoading = false;
      //   });
      //   Fluttertoast.showToast(msg: "Error" + onError.toString());
      // });
    }
  }
}
