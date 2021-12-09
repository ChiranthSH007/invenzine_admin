import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invenzine_admin/pages/local_admin/admin_slt.dart';

class Admin_approval extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text("Thanks For Registering As Admin /n Will be Approved Soon!!"),
            FlatButton(
                onPressed: () => {
                      Fluttertoast.showToast(msg: "Please Login "),
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => AdminSelect()),
                          (Route<dynamic> route) => false),
                    },
                child: Text("Next")),
          ],
        ),
      ),
    );
  }
}
