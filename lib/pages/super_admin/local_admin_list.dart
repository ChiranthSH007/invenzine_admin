import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:invenzine_admin/services/crud.dart';

class Admin_list extends StatefulWidget {
  @override
  _Admin_listState createState() => _Admin_listState();
}

class _Admin_listState extends State<Admin_list> {
  Stream newsStream;
  CrudMethods crudMethods = new CrudMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                " Local ",
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
              Text(
                "Admins",
                style: TextStyle(fontSize: 22, color: Colors.black),
              )
            ],
          ),
          backgroundColor: Colors.yellow,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: newsStream != null
                ? Container(
                    child: StreamBuilder(
                        stream: newsStream,
                        builder: (context, snapshot) {
                          if (snapshot.data == null)
                            return CircularProgressIndicator();
                          return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              QuerySnapshot snap = snapshot.data; // Snapshot
                              List<DocumentSnapshot> items =
                                  snap.documents; // List of Documents
                              DocumentSnapshot item =
                                  items[index]; //Specific Document
                              return aduanmetile(
                                cmt: item.data['Username'],
                                uid: item.data['Email'],
                                docid: item.documentID,
                              );
                            },
                          );
                        }),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
          ),
        ));
  }

  @override
  void initState() {
    crudMethods.getadunameData().then((result) {
      setState(() {
        newsStream = result;
      });
    });
    super.initState();
  }
}

class aduanmetile extends StatefulWidget {
  final String cmt, uid, cmtdocid, docid;
  const aduanmetile({Key key, this.cmt, this.uid, this.cmtdocid, this.docid})
      : super(key: key);
  @override
  _aduanmetileState createState() => _aduanmetileState();
}

class _aduanmetileState extends State<aduanmetile> {
  bool status;
  String appdata;
  Color _approvedColor = Colors.yellow;
  Color _notapprovedColor = Colors.red;
  Color _iconColor;

  @override
  void initState() {
    super.initState();
    approvalstatus(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: appdata != null
          ? Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ListTile(
                    title: Text(widget.cmt),
                    subtitle: Row(
                      children: [
                        Text(widget.uid),
                      ],
                    ),
                    trailing: FlatButton(
                      onPressed: () {
                        if (status == true) {
                          setState(() {
                            status = false;
                            changestatus(widget.uid);
                          });
                        } else {
                          setState(() {
                            status = true;
                            changestatus(widget.uid);
                          });
                        }
                      },
                      child: Text(appdata),
                      color: _iconColor,
                    ),
                  )),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  approvalstatus(email) async {
    DocumentReference docref =
        Firestore.instance.collection("LocalAdmins").document(email);
    DocumentSnapshot doc = await docref.get();
    bool appstatus = doc.data['ApprovalStatus'];
    setState(() {
      status = appstatus;
    });
    if (appstatus == true) {
      appdata = "Approved";
      _iconColor = _approvedColor;
    } else {
      appdata = "NotApproved";
      _iconColor = _notapprovedColor;
    }
  }

  changestatus(email) async {
    DocumentReference docref =
        Firestore.instance.collection("LocalAdmins").document(email);
    DocumentSnapshot doc = await docref.get();
    bool appstatus = doc.data['ApprovalStatus'];
    if (appstatus == true) {
      docref.updateData({"ApprovalStatus": false});
      approvalstatus(email);
    } else {
      docref.updateData({"ApprovalStatus": true});
      approvalstatus(email);
    }
  }
}
