import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:invenzine_admin/services/crud.dart';

class CommentSection extends StatefulWidget {
  final String docid;
  final int likesno, dislikesno;
  const CommentSection({Key key, this.docid, this.likesno, this.dislikesno})
      : super(key: key);

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                ),
                Column(
                  children: [
                    Text(
                      "Likes",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      widget.likesno.toString(),
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                SizedBox(width: 150),
                Column(
                  children: [
                    Text(
                      'Dislikes',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      widget.dislikesno.toString(),
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                )
              ],
            ),
            color: Colors.grey[300],
          ),
          Expanded(
              child: PostList(
            docid: widget.docid,
          )),
          Comment(docid: widget.docid)
        ],
      ),
    );
  }
}

class Comment extends StatefulWidget {
  final String docid;
  const Comment({Key key, this.docid}) : super(key: key);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  String cmt;
  final controller = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<void> click(cmt) async {
    //widget.callback(controller.text);
    final FirebaseUser user = await auth.currentUser();
    final String uname = user.displayName.toString();
    CrudMethods crudMethods = new CrudMethods();
    crudMethods.commentsAdd(widget.docid, cmt, uname);

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: this.controller,
        onChanged: (item) {
          setState(() {
            cmt = item;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.message),
            labelText: 'Add a Comment',
            suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  this.click(cmt);
                })));
  }
}

class PostList extends StatefulWidget {
  final String docid;

  const PostList({Key key, this.docid}) : super(key: key);
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  Stream newsStream;
  CrudMethods crudMethods = new CrudMethods();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                        return cmttile(
                          cmt: item.data['Comment'],
                          uid: item.data['userName'],
                          cmtdocid: item.documentID,
                          docid: widget.docid,
                        );
                      },
                    );
                  }),
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void initState() {
    crudMethods.getcommentsData(widget.docid).then((result) {
      setState(() {
        newsStream = result;
      });
    });
    super.initState();
  }
}

class cmttile extends StatelessWidget {
  final String cmt, uid, cmtdocid, docid;

  const cmttile({Key key, this.cmt, this.uid, this.cmtdocid, this.docid})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
              child: ListTile(
            title: Text(cmt),
            subtitle: Text(uid),
          )),
          RaisedButton(
            color: Colors.yellow,
            child: Text(
              "Remove",
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
            onPressed: () {
              _showDialog(context);
            },
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
        ],
      ),
    );
  }

  _showDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: Text("Delete the Comment"),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    CrudMethods crudMethods = new CrudMethods();
                    crudMethods.deleteComment(cmtdocid, docid);
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
