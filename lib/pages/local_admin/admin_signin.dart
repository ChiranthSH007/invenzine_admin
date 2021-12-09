import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invenzine_admin/pages/local_admin/admin_panel.dart';
import 'package:invenzine_admin/pages/local_admin/admin_reg.dart';
import 'package:invenzine_admin/pages/local_admin/admin_slt.dart';
import 'package:invenzine_admin/services/crud.dart';

// ignore: camel_case_types
class admin_signinPage extends StatefulWidget {
  @override
  _admin_signinPageState createState() => _admin_signinPageState();
}

class _admin_signinPageState extends State<admin_signinPage> {
  var _formkey = GlobalKey<FormState>();
  String _adpassword, _ademail;

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
                    left: size.width / 3.5,
                    right: size.width / 7,
                    top: size.height / 5),
                child: Text('Admin Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.075,
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
                            "Sign In",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.045),
                          ),
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              adsignin();
                            }
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      clickabletext()
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
  // @override
  // Widget build(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   return Scaffold(
  //       backgroundColor: Colors.yellow,
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
  //                         'Admin Signin',
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
  //                             adsignin();
  //                           },
  //                           shape: new RoundedRectangleBorder(
  //                             borderRadius: new BorderRadius.circular(30.0),
  //                           ),
  //                         ),
  //                       ),
  //                       clickabletext(),
  //                     ])),
  //               ),
  //             )));
  // }

  //sign with email and pwd
  void adsignin() async {
    bool _isUserEmailVerified;
    FirebaseUser currentUser;
    if (_formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _ademail, password: _adpassword)
          .then((user) async {
        setState(() {
          isLoading = false;
        });
        await FirebaseAuth.instance.currentUser()
          ..reload();
        var user = await FirebaseAuth.instance.currentUser();
        if (user.isEmailVerified) {
          setState(() {
            _isUserEmailVerified = user.isEmailVerified;
          });
        }
        if (_isUserEmailVerified == true) {
          DocumentReference docref =
              Firestore.instance.collection("LocalAdmins").document(_ademail);
          DocumentSnapshot doc = await docref.get();
          bool appstatus = doc.data['ApprovalStatus'];
          if (appstatus == true) {
            FirebaseAuth.instance.currentUser().then((firebaseUser) {
              if (firebaseUser == null) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => AdminSelect()),
                    (Route<dynamic> rr) => false);
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => Admin_page()),
                    (route) => false);
              }
            });
            Fluttertoast.showToast(msg: "Login Successfull");
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => Admin_page()),
                (Route<dynamic> route) => false);
          } else {
            Fluttertoast.showToast(msg: "Not Approved");
          }
        } else {
          Fluttertoast.showToast(msg: "Email Id not Verified");
        }
      }).catchError((onError) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Error" + onError.toString());
      });
    }
  }
}

class clickabletext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = TextStyle(color: Colors.black, fontSize: 20.0);
    TextStyle linkStyle =
        TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(
              text: 'New Admin Register here ?',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => admin_reginPage()));
                }),
        ],
      ),
    );
  }
}
