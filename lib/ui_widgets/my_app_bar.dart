import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_app/controller/shared_value.dart';
import 'package:photo_app/my_theme.dart';

import '../controller/auth.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  MyAppBar({Key? key, required this.title}):super(key: key);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);

  String title;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyTheme.accent_color,
      //background color of Appbar to green
      title: Text(title),
      actions: <Widget>[
        is_logged_in.$ ? IconButton(
          icon: const Icon(Icons.exit_to_app_outlined),
          onPressed: (){
            signOut();
          },
        ): Container()
      ],
    );
  }


}