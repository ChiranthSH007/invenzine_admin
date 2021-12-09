import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:invenzine_admin/services/crud.dart';

class addcategory extends StatefulWidget {
  @override
  _addcategoryState createState() => _addcategoryState();
}

class _addcategoryState extends State<addcategory> {
  String newcatg;
  Stream newsStream;
  String tagdocid;
  final controller = TextEditingController();
  CrudMethods crudMethods = new CrudMethods();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              " Add Tags",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      child: TextField(
                        controller: this.controller,
                        decoration: InputDecoration(hintText: "Add New Tag"),
                        onChanged: (val) {
                          newcatg = val;
                        },
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        this.addtag(newcatg);
                      },
                      child: Text("ADD"),
                      color: Colors.yellow,
                    )
                  ],
                ),
              ),
              Container(
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
                          DocumentSnapshot item = items[index];
                          //Specific Document
                          return catgtile(
                            tag: item.data['tags'],
                          );
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addtag(newcatg) async {
    DocumentReference docref =
        Firestore.instance.collection("Tags").document("newstag");
    DocumentSnapshot doc = await docref.get();
    List tags = doc.data['tags'];
    docref.updateData({
      'tags': FieldValue.arrayUnion([newcatg]),
    });
    controller.clear();
  }

  @override
  void initState() {
    crudMethods.getcategoryData().then((result) {
      setState(() {
        newsStream = result;
      });
    });
    super.initState();
  }
}

class catgtile extends StatelessWidget {
  final String catgdocid = "newstag";
  final List<dynamic> tag;

  catgtile({Key key, this.tag}) : super(key: key);

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return tagtile(context, tag);
  }

  Widget tagtile(BuildContext context, List<dynamic> tag) {
    return new Container(
      child: Column(
        children: tag
            .map((item) => new ListTile(
                  title: Text(item),
                  trailing: RaisedButton(
                    color: Colors.yellow,
                    child: Text(
                      "Remove",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    onPressed: () {
                      _showDialog(context, item);
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  removetag(tag) async {
    DocumentReference docref =
        Firestore.instance.collection("Tags").document("newstag");
    DocumentSnapshot doc = await docref.get();
    List tags = doc.data['tags'];
    docref.updateData({
      'tags': FieldValue.arrayRemove([tag]),
    });
  }

  _showDialog(BuildContext context, tag) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: Text("Delete the Tag"),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    removetag(tag);
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
}
