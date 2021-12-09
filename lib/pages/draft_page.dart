import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:invenzine_admin/services/crud.dart';

class Admin_draft extends StatefulWidget {
  String aduname;
  Admin_draft({Key key, this.aduname}) : super(key: key);
  @override
  _Admin_draftState createState() => _Admin_draftState(aduname);
}

class _Admin_draftState extends State<Admin_draft> {
  String aduname;
  _Admin_draftState(
    String aduname,
  );
  CrudMethods crudMethods = new CrudMethods();
  Stream newStream;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Saved Drafts",
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Colors.yellow,
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: SingleChildScrollView(
        child: newStream != null
            ? Container(
                margin: EdgeInsets.only(top: 2),
                child: StreamBuilder(
                    stream: newStream,
                    builder: (context, snapshot) {
                      if (snapshot.data == null)
                        return CircularProgressIndicator();
                      return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (content, index) {
                            QuerySnapshot snap = snapshot.data; // Snapshot
                            List<DocumentSnapshot> items =
                                snap.documents; // List of Documents
                            DocumentSnapshot item =
                                items[index]; //Specific Document
                            return Draft_tile(
                                title: item.data['title'],
                                description: item.data['desc'],
                                imgUrl: item.data['imgUrl'],
                                imageFileName: item.data['ImageFileName'],
                                downloadUrl: item.data['imgUrl'],
                                tags: item.data['tags'],
                                aduname: item.data['adminname'],
                                docuid: item.documentID);
                          });
                    }),
              )
            : Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    crudMethods.getDraftData(widget.aduname).then((result) {
      setState(() {
        newStream = result;
      });
    });
    super.initState();
  }
}

class Draft_tile extends StatelessWidget {
  final String imgUrl,
      title,
      description,
      docuid,
      imageFileName,
      downloadUrl,
      aduname;
  final DateTime date;
  final List<dynamic> tags;

  Draft_tile({
    @required this.imgUrl,
    @required this.title,
    @required this.description,
    @required this.imageFileName,
    @required this.downloadUrl,
    @required this.aduname,
    this.date,
    @required this.docuid,
    this.tags,
  });
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> newsData = {
      "imgUrl": downloadUrl,
      "title": title,
      "desc": description,
      "ImageFileName": imageFileName,
      "adminname": aduname,
      "tags": tags,
      "like": [],
      "dislike": [],
      "likes": 0,
      "dislikes": 0,
    };
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.black))),
        child: Container(
          width: 70,
          height: 50,
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            width: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Row(
        children: <Widget>[
          Flexible(
              child: Text(description,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black))),
        ],
      ),
      trailing: GestureDetector(
        child: Icon(Icons.archive_rounded, color: Colors.black, size: 30.0),
        onTap: () {
          Firestore.instance.collection("News").add(newsData).catchError((e) {
            print(e);
          });
          Firestore.instance
              .collection("DraftNews")
              .document(docuid)
              .delete()
              .catchError((e) {
            print(e);
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
