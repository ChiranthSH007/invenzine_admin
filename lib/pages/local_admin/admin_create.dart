import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:invenzine_admin/services/crud.dart';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
class Admin_create extends StatefulWidget {
  @override
  _Admin_createState createState() => _Admin_createState();
}

// ignore: camel_case_types
class _Admin_createState extends State<Admin_create> {
  FirebaseUser currentUser;
  String title, desc;
  File selectedImage;
  bool _isLoading = false;
  CrudMethods crudMethods = new CrudMethods();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String newtag;
  List<dynamic> addtags = new List<dynamic>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _typeAheadController = TextEditingController();

  @override
  void initState() {
    super.initState(); //email getting
    _loadCurrentUser(); //email getting
  }

  void _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        // call setState to rebuild the view
        this.currentUser = user;
      });
    });
  }

  String _uname() {
    if (currentUser != null) {
      return currentUser.displayName;
    } else {
      return "no current user";
    }
  }

  String _email() {
    if (currentUser != null) {
      return currentUser.email;
    } else {
      return null;
    }
  }

  Future getImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = image;
    });
  }

  saveasdraft() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });
      var imageFileName =
          title + DateTime.now().millisecondsSinceEpoch.toString();

      /// uploading image to firebase storage
      StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("NewsImages")
          .child(imageFileName);

      final StorageUploadTask task = firebaseStorageRef.putFile(selectedImage);

      var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
      print("this is url $downloadUrl");

      Map<String, dynamic> newsMap = {
        "imgUrl": downloadUrl,
        "title": title,
        "desc": desc,
        "aemail": _email().toString(),
        "date": DateTime.now(),
        "ImageFileName": imageFileName,
        "adminname": _uname().toString(),
        "tags": addtags.toList(),
        "like": [],
        "dislike": [],
        "likes": 0,
        "dislikes": 0,
      };
      crudMethods.addDraftData(newsMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
  }

  uploadNews() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });
      var imageFileName =
          title + DateTime.now().millisecondsSinceEpoch.toString();

      /// uploading image to firebase storage
      StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("NewsImages")
          .child(imageFileName);

      final StorageUploadTask task = firebaseStorageRef.putFile(selectedImage);

      var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
      print("this is url $downloadUrl");

      Map<String, dynamic> newsMap = {
        "imgUrl": downloadUrl,
        "title": title,
        "aemail": _email().toString(),
        "desc": desc,
        "date": DateTime.now(),
        "ImageFileName": imageFileName,
        "adminname": _uname().toString(),
        "tags": addtags,
        "like": [],
        "dislike": [],
        "likes": 0,
        "dislikes": 0,
      };
      crudMethods.addData(newsMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "New Post",
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
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: selectedImage != null
                            ? Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                height: 170,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.file(
                                    selectedImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
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
                            decoration: InputDecoration(hintText: "Title"),
                            onChanged: (val) {
                              title = val;
                            },
                          ),
                          TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(hintText: "Desc"),
                            onChanged: (val) {
                              desc = val;
                            },
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            child: SingleChildScrollView(
                              child: Container(
                                child: Column(
                                  children: [
                                    TypeAheadField(
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        decoration: InputDecoration(
                                          labelText: 'Search Tags to Add',
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons
                                                .keyboard_arrow_right_outlined),
                                            onPressed: () {
                                              addtag(_typeAheadController.text);
                                            },
                                          ),
                                        ),
                                        controller: this._typeAheadController,
                                      ),
                                      suggestionsCallback: (pattern) async {
                                        return await StateService
                                            .getSuggestions(pattern);
                                      },
                                      transitionBuilder: (context,
                                          suggestionsBox, controller) {
                                        return suggestionsBox;
                                      },
                                      itemBuilder: (context, suggestion) {
                                        return ListTile(
                                          title: Text(suggestion),
                                          onTap: () {
                                            addtag(suggestion.toString());
                                          },
                                        );
                                      },
                                      onSuggestionSelected: (suggestion) {
                                        this._typeAheadController.text =
                                            suggestion;
                                      },
                                    ),
                                    tagtile(addtags),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                            onPressed: () {
                              uploadNews();
                            },
                            child: Text(
                              "Upload",
                            ),
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FlatButton(
                            onPressed: () {
                              saveasdraft();
                            },
                            child: Text("Save as Draft"),
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget tagtile(List<dynamic> addtags) {
    return addtags != null
        ? Container(
            child: Column(
              children: addtags
                  .map((item) => new ListTile(
                        title: Text(item),
                        trailing: RaisedButton(
                          color: Colors.yellow,
                          child: Text(
                            "Remove",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                          onPressed: () {
                            removetag(item);
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          )
        : Text("No Tags");
  }

  removetag(newtag) async {
    setState(() {
      addtags.remove(newtag);
    });
  }

  addtag(newtag) async {
    setState(() {
      addtags.insert(0, newtag);
    });
    print(addtags);
  }
}

class StateService {
  static List<dynamic> tags = new List<dynamic>();

  static getSuggestions(String query) async {
    DocumentReference docref =
        Firestore.instance.collection("Tags").document("newstag");
    DocumentSnapshot doc = await docref.get();
    tags = doc.data['tags'];
    List<dynamic> matches = List();
    matches.addAll(tags);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches.toList();
  }
}

//   Widget dpdown() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: Firestore.instance.collection('Tags').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (!snapshot.hasData) return CircularProgressIndicator();
//         return new DropdownButton<String>(
//           isDense: true,
//           elevation: 10,
//           hint: new Text("Select"),
//           value: _mySelection,
//           onChanged: (String newValue) {
//             setState(() {
//               _mySelection = newValue;
//             });
//             print(_mySelection);
//           },
//           items: snapshot.data.documents.map((map) {
//             return new DropdownMenuItem<String>(
//               value: map["Cat"],
//               child: new Text(
//                 map["Cat"],
//               ),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
