import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:invenzine_admin/pages/draft_page.dart';
import 'package:invenzine_admin/pages/local_admin/admin_slt.dart';
import 'package:invenzine_admin/pages/super_admin/Tags.dart';
import 'package:invenzine_admin/pages/super_admin/local_admin_list.dart';
import 'package:invenzine_admin/pages/super_admin/sup_comment.dart';
import 'package:invenzine_admin/pages/super_admin/sup_create.dart';
import 'package:invenzine_admin/pages/super_admin/sup_update.dart';
import 'package:invenzine_admin/services/crud.dart';

//import 'supnavigatorbar.dart';
//import 'package:invenzine/pages/admin_create.dart';

class Sup_Admin_page extends StatefulWidget {
  @override
  _Sup_Admin_pageState createState() => _Sup_Admin_pageState();
}

class _Sup_Admin_pageState extends State<Sup_Admin_page> {
  CrudMethods crudMethods = new CrudMethods();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Stream newsStream;
  @override
  Widget NewsList() {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        child: newsStream != null
            ? Container(
                child: StreamBuilder(
                  stream: newsStream,
                  builder: (context, snapshot) {
                    if (snapshot.data == null)
                      return CircularProgressIndicator();
                    return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        itemCount: snapshot.data.documents.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Admin_NewsTile(
                            // created_time:
                            //     snapshot.data.documents[index].data["date"],
                            title: snapshot.data.documents[index].data["title"],
                            admname: snapshot
                                .data.documents[index].data["adminname"],
                            description:
                                snapshot.data.documents[index].data['desc'],
                            imgUrl:
                                snapshot.data.documents[index].data['imgUrl'],
                            docid: snapshot.data.documents[index].documentID,
                            likesno:
                                snapshot.data.documents[index].data['likes'],
                            dislikesno:
                                snapshot.data.documents[index].data['dislikes'],
                            imgfilename: snapshot
                                .data.documents[index].data['ImageFileName'],
                          );
                        });
                  },
                ),
              )
            : Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  @override
  void initState() {
    crudMethods.getsupData().then((result) {
      setState(() {
        newsStream = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: SupNavDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              " Super Admin ",
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
            IconButton(
              onPressed: () async {
                await signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AdminSelect()));
              },
              icon: Icon(Icons.logout),
              color: Colors.black,
            )
          ],
        ),
        backgroundColor: Colors.yellow,
        elevation: 0.0,
      ),
      body: SafeArea(child: NewsList()),
      floatingActionButton: buildSpeedDial(),
    );
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      /// both default to 16
      marginEnd: 18,
      marginBottom: 20,
      icon: Icons.add,
      activeIcon: Icons.remove,
      buttonSize: 56.0,
      visible: true,
      curve: Curves.bounceIn,
      overlayColor: Colors.transparent,
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.yellow,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child: Icon(Icons.add_box_outlined),
          backgroundColor: Colors.yellow,
          label: 'New Post',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Admin_create()))
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.drafts),
          backgroundColor: Colors.yellow,
          label: 'Saved Posts',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Admin_draft()))
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.settings),
          backgroundColor: Colors.yellow,
          label: 'Local Admins',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Admin_list()))
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.tag),
          backgroundColor: Colors.yellow,
          label: 'Tags',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => addcategory(),
              ),
            ),
          },
        ),
      ],
    );
  }

  signOut() async {
    await googleSignIn.signOut();

    await FirebaseAuth.instance.signOut();
  }
}

class Admin_NewsTile extends StatelessWidget {
  CrudMethods crudMethods = new CrudMethods();

  String imgUrl, title, description, docid, imgfilename, admname;
  int likesno, dislikesno;
  Admin_NewsTile({
    @required this.imgUrl,
    @required this.admname,
    @required this.title,
    @required this.description,
    @required this.docid,
    @required this.imgfilename,
    @required this.dislikesno,
    @required this.likesno,
  });

  _showDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: Text("Delete the Post"),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    crudMethods.deleteData(docid);
                    crudMethods.deleteImage(imgfilename);
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.only(
          bottom: 5, top: MediaQuery.of(context).size.height * 0.01),
      height: 144,
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: imgUrl,
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.35,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.446,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.009,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Author : " + admname,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 16.0),
                //   child: created_time != null
                //       ? Text(
                //           DateFormat('yyyy-MM-dd–kk:mm')
                //               .format(created_time as DateTime),
                //           style: TextStyle(color: Colors.black54, fontSize: 14),
                //         )
                //       : Text("Loading..."),
                // ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                IconButton(
                  iconSize: 20,
                  icon: Icon(Icons.edit),
                  color: Colors.black,
                  alignment: Alignment.center,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Sup_Admin_update(
                                  title: title,
                                  desc: description,
                                  imgurl: imgUrl,
                                  docid: docid,
                                )));
                  },
                ),
                IconButton(
                    iconSize: 20,
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      _showDialog(context);
                    }),
                IconButton(
                    iconSize: 20,
                    icon: Icon(Icons.comment),
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentSection(
                                    docid: docid,
                                    likesno: likesno,
                                    dislikesno: dislikesno,
                                  )));
                    })
              ],
            ),
            height: 144,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
          ),
        ],
      ),
    );
  }
}
