import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:invenzine_admin/services/crud.dart';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
class Sup_Admin_update extends StatefulWidget {
  final String title, desc, imgurl, docid;
  const Sup_Admin_update(
      {Key key, this.title, this.desc, this.imgurl, this.docid})
      : super(key: key);
  @override
  _Sup_Admin_updateState createState() => _Sup_Admin_updateState();
}

// ignore: camel_case_types
class _Sup_Admin_updateState extends State<Sup_Admin_update> {
  bool _isLoading = false;
  File displayedImage;
  CrudMethods crudMethods = new CrudMethods();
  // ignore: non_constant_identifier_names
  String desc_c, title_c;
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Edit Panel",
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Colors.yellow,
        elevation: 0.0,
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        ;
                      },
                      child: displayedImage != null
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  displayedImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              width: MediaQuery.of(context).size.width,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black45,
                              ),
                            )),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(hintText: ""),
                          onChanged: (val) {
                            this.title_c = val;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: "Desc"),
                          onChanged: (val) {
                            this.desc_c = val;
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      color: Colors.yellow,
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                      onPressed: () {
                        crudMethods.updateDataTitle(widget.docid, {
                          'title': this.title_c,
                          'desc': this.desc_c
                        }); //inside singloe code is the doc filed name and this. is the new value
                        Navigator.pop(context);
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
