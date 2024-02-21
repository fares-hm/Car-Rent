import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:photo_app/controller/shared_value.dart';
import 'package:photo_app/pages/add.dart';
import 'package:photo_app/pages/manage-items.dart';
import 'package:photo_app/pages/home.dart';
import 'package:photo_app/pages/login.dart';

import '../controller/auth.dart';

class MyDrawer extends StatelessWidget {

  MyDrawer({Key? key}):super(key: key);

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(AppLocalizations.of(context)!.welcome),
          ),

          !is_logged_in.$ ? ListTile(
            title: Text(AppLocalizations.of(context)!.login),
            trailing: const Icon(Icons.login),

            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return Login();
                  }));
            },
          ) : Container(),
          is_logged_in.$ ? ListTile(
            title: Text(AppLocalizations.of(context)!.home),
            trailing: const Icon(Icons.home),

            onTap: () {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                    return const MyHomePage();
                  }),ModalRoute.withName('/'),);
            },
          ) : Container(),
          is_logged_in.$ && is_admin.$ ?ListTile(
            title: Text(AppLocalizations.of(context)!.list),
            trailing: const Icon(Icons.list_alt),

            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return const ManageItems();
                  }));
            },
          ) : Container(),
          is_logged_in.$ && is_admin.$ ?ListTile(
            title: Text(AppLocalizations.of(context)!.addItem),
            trailing: const Icon(Icons.add),

            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return const AddItem();
                  }));
            },
          ) : Container(),
          is_logged_in.$ ? ListTile(
            title: Text( AppLocalizations.of(context)!.signOut),
            trailing: const Icon(Icons.exit_to_app_outlined),
            onTap: () {
            signOut();
              Navigator.pop(context);
            },
          ): Container(),
        ],
      ),
    );
  }


}