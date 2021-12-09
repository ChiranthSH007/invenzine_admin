import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invenzine_admin/pages/local_admin/admin_panel.dart';
import 'package:invenzine_admin/pages/local_admin/admin_slt.dart';
import 'package:invenzine_admin/pages/super_admin/sup_panel.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseUser currentUser;

  void initState() {
    super.initState();
    _loadCurrentUser();
    Timer(Duration(seconds: 3), () async {
      FirebaseAuth.instance.currentUser().then((firebaseUser) {
        if (firebaseUser == null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => AdminSelect()),
              (Route<dynamic> rr) => false);
        } else if (firebaseUser.email == "techmag12345@gmail.com") {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => Sup_Admin_page()),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => Admin_page()),
              (route) => false);
        }
      });
    });
  }

  void _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        // call setState to rebuild the view
        this.currentUser = user;
      });
    });
  }

  String _email() {
    if (currentUser != null) {
      return currentUser.email;
    } else {
      return "no current user";
    }
  }

  String _uname() {
    if (currentUser != null) {
      return currentUser.displayName;
      // setState(() {
      //   aduname = currentUser.displayName;
      // });
    } else {
      return "no user";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: Text("INVENZINE Admin", style: TextStyle(color: Colors.black)),
      )),
    );
  }
}
