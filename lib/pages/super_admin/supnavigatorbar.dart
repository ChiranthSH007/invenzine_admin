import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:invenzine_admin/pages/draft_page.dart';
import 'package:invenzine_admin/pages/local_admin/admin_slt.dart';
import 'package:invenzine_admin/pages/super_admin/Tags.dart';
import 'package:invenzine_admin/pages/super_admin/local_admin_list.dart';

import '../local_admin/admin_create.dart';

class SupNavDrawer extends StatelessWidget {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              "Welcome",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
              // image: DecorationImage(
              //     fit: BoxFit.fill,
              //     image: AssetImage('assets/images/cover.jpg'))
            ),
          ),
          ListTile(
            leading: Icon(Icons.add_box_outlined),
            title: Text('New Posts'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Admin_create()))
            },
          ),
          ListTile(
            leading: Icon(Icons.drafts),
            title: Text('Saved Drafts'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Admin_draft()))
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Local Admins'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Admin_list()))
            },
          ),
          ListTile(
            leading: Icon(Icons.tag),
            title: Text('Tags'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => addcategory()))
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              signOut(),
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AdminSelect()))
            },
          ),
        ],
      ),
    );
  }

  void signOut() async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
