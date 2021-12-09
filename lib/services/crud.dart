import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CrudMethods {
  Future<void> addData(newsData) async {
    Firestore.instance.collection("News").add(newsData).catchError((e) {
      print(e);
    });
  }

  Future<void> addDraftData(newsData) async {
    Firestore.instance.collection("DraftNews").add(newsData).catchError((e) {
      print(e);
    });
  }

  Future<void> addDraftSaveData(newsData) async {
    Firestore.instance.collection("News").add(newsData).catchError((e) {
      print(e);
    });
  }

  Future<void> addadminusername(adminData, email) async {
    Firestore.instance
        .collection("LocalAdmins")
        .document(email)
        .setData(adminData)
        .catchError((e) {
      print(e);
    });
  }

  getadunameData() async {
    // ignore: await_only_futures
    return await Firestore.instance.collection("LocalAdmins").snapshots();
  }

  Future<void> commentsAdd(docid, cmt, String uname) async {
    Firestore.instance
        .collection("News")
        .document(docid)
        .collection("Comments")
        .document()
        .setData({'Comment': cmt, "userName": uname}).catchError((e) {
      print(e);
    });
  }

  getData(auname) async {
    // ignore: await_only_futures
    return await Firestore.instance
        .collection('News')
        .where("adminname", isEqualTo: auname)
        .snapshots();
  }

  getDraftData(auname) async {
    // ignore: await_only_futures
    return await Firestore.instance
        .collection("DraftNews")
        .where("adminname", isEqualTo: auname)
        .snapshots();
  }

  getsupData() async {
    // ignore: await_only_futures
    return await Firestore.instance.collection("News").snapshots();
  }

  updateDataTitle(selectedDoc, newValues) {
    Firestore.instance
        .collection("News")
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

  deleteComment(cmtdocid, docid) {
    Firestore.instance
        .collection("News")
        .document(docid)
        .collection("Comments")
        .document(cmtdocid)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  getcommentsData(docid) async {
    // ignore: await_only_futures
    return await Firestore.instance
        .collection("News")
        .document(docid)
        .collection("Comments")
        .snapshots();
  }

  deleteData(docId) {
    Firestore.instance
        .collection("News")
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  deleteCatg(docId) {
    Firestore.instance
        .collection("Category")
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  Future deleteImage(String imageFileName) async {
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("NewsImages").child(imageFileName);

    try {
      await firebaseStorageRef.delete();
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  getcategoryData() async {
    // ignore: await_only_futures
    return await Firestore.instance.collection("Tags").snapshots();
  }

  getstatus(email) async {
    return await Firestore.instance
        .collection("LocalAdmins")
        .where("email", isEqualTo: email)
        .snapshots();
  }
}
