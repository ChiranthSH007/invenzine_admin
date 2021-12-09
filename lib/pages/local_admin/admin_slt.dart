import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invenzine_admin/pages/local_admin/admin_panel.dart';
import 'package:invenzine_admin/pages/local_admin/admin_signin.dart';
import 'package:invenzine_admin/pages/super_admin/sup_login.dart';

class AdminSelect extends StatefulWidget {
  @override
  _AdminSelectState createState() => _AdminSelectState();
}

class _AdminSelectState extends State<AdminSelect> {
  FirebaseUser _user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height / 2,
                color: Colors.yellow,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: size.width / 2.8,
                      right: size.width / 5,
                      top: size.height / 5),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        fontSize: size.width * 0.1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  width: size.width * 5,
                  height: size.height * 0.07,
                  padding: EdgeInsets.only(left: 50.0, right: 50.0),
                  child: RaisedButton(
                    color: Colors.grey[850],
                    child: Text(
                      "Super Admin",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => supadmin_signinPage()));
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  width: size.width * 5,
                  height: size.height * 0.07,
                  padding: EdgeInsets.only(left: 50.0, right: 50.0),
                  child: RaisedButton(
                    color: Colors.yellow,
                    child: Text(
                      "Local Admin",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => admin_signinPage()));
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
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
  //       body: Container(
  //           margin: EdgeInsets.symmetric(vertical: size.height * 0.30),
  //           child: SingleChildScrollView(
  //               child: Column(children: [
  //             Text('LOGIN',
  //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
  //             SizedBox(
  //               height: 15,
  //             ),

  //             Container(
  //               //or divider
  //               margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
  //               width: size.width * 0.8,
  //               child: Row(
  //                 children: <Widget>[
  //                   Padding(
  //                     padding: const EdgeInsets.only(left: 150),
  //                     child: Text(
  //                       "OR",
  //                       style: TextStyle(
  //                         color: Colors.black54,
  //                         fontSize: 17,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ), //or divider ends

  //             Container(
  //               margin: EdgeInsets.symmetric(vertical: 5),
  //               width: size.width * 5,
  //               height: size.height * 0.07,
  //               padding: EdgeInsets.only(left: 50.0, right: 50.0),
  //               child: RaisedButton(
  //                 color: Colors.grey[350],
  //                 child: Text(
  //                   "Super Admin",
  //                   style: TextStyle(color: Colors.black, fontSize: 17),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                           builder: (_) => supadmin_signinPage()));
  //                 },
  //                 shape: new RoundedRectangleBorder(
  //                   borderRadius: new BorderRadius.circular(30.0),
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               margin: EdgeInsets.symmetric(vertical: 5),
  //               width: size.width * 5,
  //               height: size.height * 0.07,
  //               padding: EdgeInsets.only(left: 50.0, right: 50.0),
  //               child: RaisedButton(
  //                 color: Colors.grey[350],
  //                 child: Text(
  //                   "Local Admin",
  //                   style: TextStyle(color: Colors.black, fontSize: 17),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.push(context,
  //                       MaterialPageRoute(builder: (_) => admin_signinPage()));
  //                 },
  //                 shape: new RoundedRectangleBorder(
  //                   borderRadius: new BorderRadius.circular(30.0),
  //                 ),
  //               ),
  //             ),
  //           ]))));
  // }
}
