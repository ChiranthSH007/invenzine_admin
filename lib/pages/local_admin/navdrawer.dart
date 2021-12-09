import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:invenzine_admin/pages/draft_page.dart';
import 'package:invenzine_admin/pages/local_admin/admin_slt.dart';

import 'admin_create.dart';

class NavDrawer extends StatelessWidget {
  String uname;
  NavDrawer(this.uname);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              uname,
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Admin_draft(
                            aduname: uname,
                          )))
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
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

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
